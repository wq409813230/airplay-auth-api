package net.freeapis.deviceauth;

import com.alibaba.fastjson.JSON;
import com.google.common.collect.Maps;
import net.freeapis.airplayauth.face.AuthHistoryService;
import net.freeapis.airplayauth.face.constants.AirplayauthConstants;
import net.freeapis.airplayauth.face.entity.AuthHistory;
import net.freeapis.airplayauth.face.model.AuthInfoModel;
import net.freeapis.airplayauth.utils.RSA;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.sequence.SequenceGenerator;
import net.freeapis.core.foundation.utils.PyKit;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.rest.utils.ResponseHelper;
import net.freeapis.core.rest.utils.ResponseModel;
import net.freeapis.systemctl.face.DictionaryService;
import net.freeapis.systemctl.face.constants.DictionaryConstants;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.Map;

/**
 * freeapis, Inc.
 * Copyright (C): 2016
 * <p>
 * Description:设备认证数据包安全拦截器,实现对数据包的加解密
 * <p>
 * Author:Administrator
 * Date:2016年11月22日 14:13
 */
@Aspect
@Order(value = 10)
@Component
public class PacketSafeInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(PacketSafeInterceptor.class);

    @Autowired
    private DictionaryService dictionaryService;

    @Autowired
    private TaskExecutor taskExecutor;

    @Autowired
    private AuthHistoryService authHistoryService;

    @Autowired
    private SequenceGenerator sequenceGenerator;

    @Pointcut("execution(* net.freeapis.resource.airplayauth.DeviceAuthResourcesV1.doAuthDevice(..))")
    public void packetSafeGuarantee() {
    }

    @Around("packetSafeGuarantee()")
    public Object makeSurePacketSafety(ProceedingJoinPoint pjp) throws Throwable {
        String privateKey = dictionaryService.getValue(
                CoreConstants.CODE_SUPER_ADMIN, DictionaryConstants.DICT_CODE_SYS_PARAMS,
                AirplayauthConstants.DICT_KEY_RSA_PRIVATE_KEY);
        Map<String,String> authBody = (Map)pjp.getArgs()[0];
        String authInfo = authBody.get("authinfo");
        authInfo = RSA.decryptByPrivate(authInfo,privateKey);
        authBody.putAll(JSON.parseObject(authInfo,Map.class));
        authBody.remove("authinfo");

        Object retVal = null;
        ResponseModel authResponse;
        try {
            retVal = pjp.proceed(new Object[]{authBody});
            authResponse = ResponseHelper.buildResponseModel(retVal);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            authResponse = ResponseHelper.internal_server_error(e.getMessage());
        }

        this.recordAuthHistory(authBody, authResponse);

        String clientPublicKey = authBody.get("pubkey");
        int httpStatus = authResponse.getStatus();
        Map<String,Object> responsePacket = Maps.newHashMap();
        Map<String,String> packetResult = Maps.newHashMap();
        packetResult.put("mac",authBody.get("mac"));
        packetResult.put("status",httpStatus == 200? "yes" : "no");
        responsePacket.put("result",RSA.encryptByClientPubKey(JSON.toJSONString(packetResult),clientPublicKey));
        responsePacket.put("reason",authResponse.getMessage());

        return JSON.toJSONString(responsePacket);
    }

    private void recordAuthHistory(final Map<String,String> authBody, final ResponseModel authResponse) {
        taskExecutor.execute(() -> {
            try {
                AuthHistory authHistory = new AuthHistory();
                authHistory.setSequenceNBR(sequenceGenerator.getNextValue());
                authHistory.setRecDate(new Date());
                authHistory.setRecStatus(CoreConstants.COMMON_ACTIVE);
                authHistory.setRecUserId(CoreConstants.SYSTEM.toString());
                authHistory.setAuthTime(new Date());

                AuthInfoModel authInfo = (AuthInfoModel) authResponse.getResult();
                if (ValidationUtil.isEmpty(authInfo)) {
                    String company = authBody.get("org");
                    String machineModel = authBody.get("dev");
                    String deviceMac = authBody.get("mac");
                    String companyCode = PyKit.pin(company);

                    authHistory.setDeviceMac(deviceMac);
                    authHistory.setMachineModel(machineModel);
                    authHistory.setCompanyName(company);
                    authHistory.setCompanyCode(companyCode);
                    authHistory.setAuthSuccess(CoreConstants.COMMON_N);
                    authHistory.setFailedMessage(authResponse.getMessage());
                } else {
                    authHistory.setAuthSuccess(CoreConstants.COMMON_Y);
                    authHistory.setCompanyCode(authInfo.getCompanyCode());
                    authHistory.setCompanyName(authInfo.getCompanyName());
                    authHistory.setDeviceMac(authInfo.getDeviceMac());
                    authHistory.setMachineModel(authInfo.getMachineModel());
                }
                authHistoryService.create(authHistory);
            } catch (Exception e) {
                e.printStackTrace();
                logger.error(e.getMessage());
            }
        });
    }
}