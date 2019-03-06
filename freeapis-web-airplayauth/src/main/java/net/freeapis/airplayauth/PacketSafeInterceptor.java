package net.freeapis.airplayauth;

import com.alibaba.fastjson.JSON;
import net.freeapis.airplayauth.face.AuthHistoryService;
import net.freeapis.airplayauth.face.constants.AirplayauthConstants;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.rest.utils.ResponseHelper;
import net.freeapis.core.rest.utils.ResponseModel;
import net.freeapis.systemctl.face.DictionaryService;
import net.freeapis.systemctl.face.constants.DictionaryConstants;
import org.apache.commons.codec.binary.Base64;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Component;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.spec.SecretKeySpec;

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

    @Autowired
    private DictionaryService dictionaryService;

    @Autowired
    private TaskExecutor taskExecutor;

    @Autowired
    private AuthHistoryService authHistoryService;

    @Pointcut("execution(* net.freeapis.resource.airplayauth.DeviceAuthResourcesV1.*(..))")
    public void packetSafeGuarantee() {
    }

    @Around("packetSafeGuarantee()")
    public Object makeSurePacketSafety(ProceedingJoinPoint pjp) throws Throwable {
        String aesKey = dictionaryService.getValue(
                CoreConstants.CODE_SUPER_ADMIN,DictionaryConstants.DICT_CODE_SYS_PARAMS,"AES_KEY");
        String authBody = decrypt(pjp.getArgs()[0].toString(),aesKey);

        Object retVal = null;
        ResponseModel authResponse;
        try {
            retVal = pjp.proceed(new Object[]{authBody});
            authResponse = ResponseHelper.buildResponseModel(retVal);
        }catch (Exception e){
            e.printStackTrace();
            authResponse = ResponseHelper.internal_server_error(e.getMessage());
        }

        this.recordAuthHistory(authResponse);

        return encrypt(JSON.toJSONString(authResponse),aesKey);
    }

    /**
     * 加密
     *
     * @param content    加密的字符串
     * @param encryptKey key值
     * @return
     * @throws Exception
     */
    private String encrypt(String content, String encryptKey) throws Exception {
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        kgen.init(128);
        Cipher cipher = Cipher.getInstance(AirplayauthConstants.ALGORITHMSTR);
        cipher.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(encryptKey.getBytes(), "AES"));
        byte[] b = cipher.doFinal(content.getBytes("utf-8"));
        // 采用base64算法进行转码,避免出现中文乱码
        return Base64.encodeBase64String(b);

    }

    /**
     * 解密
     *
     * @param encryptStr 解密的字符串
     * @param decryptKey 解密的key值
     * @return
     * @throws Exception
     */
    private String decrypt(String encryptStr, String decryptKey) throws Exception {
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        kgen.init(128);
        Cipher cipher = Cipher.getInstance(AirplayauthConstants.ALGORITHMSTR);
        cipher.init(Cipher.DECRYPT_MODE, new SecretKeySpec(decryptKey.getBytes(), "AES"));
        // 采用base64算法进行转码,避免出现中文乱码
        byte[] encryptBytes = Base64.decodeBase64(encryptStr);
        byte[] decryptBytes = cipher.doFinal(encryptBytes);
        return new String(decryptBytes);
    }

    private void recordAuthHistory(final ResponseModel authResponse){
        taskExecutor.execute(() -> {

        });
    }
}