package net.freeapis.airplayauth.service;

import net.freeapis.airplayauth.dao.AuthConfigDAO;
import net.freeapis.airplayauth.dao.AuthHistoryDAO;
import net.freeapis.airplayauth.dao.AuthInfoDAO;
import net.freeapis.airplayauth.face.AuthInfoService;
import net.freeapis.airplayauth.face.constants.AirplayauthConstants;
import net.freeapis.airplayauth.face.entity.AuthConfig;
import net.freeapis.airplayauth.face.entity.AuthInfo;
import net.freeapis.airplayauth.face.model.AuthInfoModel;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.exceptions.DataValidateException;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.sequence.SequenceGenerator;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.PyKit;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.BaseServiceImpl;
import net.freeapis.systemctl.face.DictionaryService;
import net.freeapis.systemctl.face.model.DictionaryEntryModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AuthInfoServiceImpl.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthInfoServiceImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
@Service(value="authInfoService")
public class AuthInfoServiceImpl extends BaseServiceImpl<AuthInfoModel, AuthInfo> implements AuthInfoService
{
    @Autowired
    private AuthInfoDAO authInfoDAO;

    @Autowired
    private DictionaryService dictionaryService;

    @Autowired
    private AuthConfigDAO authConfigDAO;

    @Autowired
    private SequenceGenerator sequenceGenerator;

    @Autowired
    private AuthHistoryDAO authHistoryDAO;

    @Override
    public AuthInfoModel createAuthInfo(Map<String,String> authRequest) throws Exception {
        String company = authRequest.get("org");
        String machineModel = authRequest.get("dev");
        String deviceMac = authRequest.get("mac");
        String privateKey = authRequest.get("code");
        String companyCode = PyKit.pin(company);

        /*String deviceMacMonitorKey = Redis.genKey(
                AirplayauthConstants.CACHE_KEY_DEVICE_AUTH_MONITOR,companyCode,machineModel,deviceMac);
        return ConcurrentUtil.runWithLock(deviceMacMonitorKey,
                () -> doDeviceAuth(company,companyCode,machineModel,deviceMac,privateKey));*/
        return doDeviceAuth(company,companyCode,machineModel,deviceMac,privateKey);
    }

    @Override
    public Page getAuthInfos(Long authConfigId, String deviceMac, Page page) throws Exception {
        List<AuthInfoModel> result =
                Bean.toModels(authInfoDAO.findAuthInfosByConfigId(authConfigId,deviceMac,page),this.getModelClass());
        page.setList(result);
        return page;
    }

    @Override
    public AuthInfoModel deleteAuthInfo(Long id) throws Exception {
        //删除认证信息
        AuthInfo authInfo = authInfoDAO.deleteAuthInfo(id);
        //删除认证记录
        authHistoryDAO.deleteByDeviceMac(authInfo.getDeviceMac());

        return Bean.toModel(authInfo,new AuthInfoModel());
    }

    private AuthInfoModel doDeviceAuth(
            String company,String companyCode,String machineModel,String deviceMac,String privateKey) throws Exception{
        //#1判断该设备是否之前认证成功过,如果认证成功则直接返回授权码
        AuthConfig authConfig = authConfigDAO.findAuthConfig(companyCode,machineModel);
        AuthInfo authInfo = authInfoDAO.findAuthInfo(companyCode,machineModel,deviceMac);
        if(!ValidationUtil.isEmpty(authInfo)){
            if(!authConfig.getPrivateKey().equals(privateKey)){
                throw new DataValidateException("Invalid auth password.");
            }
            //#1-1判断认证次数是否超过上限
            int authSuccessCount = Redis.increment(1L,
                    AirplayauthConstants.DEVICE_AUTH_COUNT_MONITOR,companyCode,machineModel,deviceMac).intValue();
            if(authConfig.getMaxAuthCount() < authSuccessCount){
                throw new DataValidateException("can not beyond the limit of auth count");
            }
            AuthInfoModel result = Bean.toModel(authInfo,new AuthInfoModel());
            result.setCompanyName(company);
            return result;
        }

        //#2如果未认证则进行认证
        //#2-1判断机型是否正确
        DictionaryEntryModel machineModelEntry =
                dictionaryService.getEntry(
                        CoreConstants.CODE_SUPER_ADMIN,AirplayauthConstants.DICT_CODE_MACHINE_MODEL,machineModel);
        if(ValidationUtil.isEmpty(machineModelEntry)){
            throw new DataValidateException("Invalid machine model.");
        }

        //#2-2获取授权配置
        if(ValidationUtil.isEmpty(authConfig)){
            throw new DataValidateException("not found authConfig.");
        }

        //#2-3校验密钥是否正确
        if(!authConfig.getPrivateKey().equals(privateKey)){
            throw new DataValidateException("Invalid auth password.");
        }

        //#2-4获取授权码
        String authCodePoolKey = Redis.genKey(
                AirplayauthConstants.CACHE_KEY_AUTH_CODES_POOL,companyCode,machineModel);
        String authCode = Redis.spop(authCodePoolKey);
        if(ValidationUtil.isEmpty(authCode)){
            throw new DataValidateException("can not obtain authorized code,please contact admin to increase device count");
        }

        //#2-5记录认证信息
        authInfo = new AuthInfo();
        authInfo.setSequenceNBR(sequenceGenerator.getNextValue());
        authInfo.setAuthConfigId(authConfig.getSequenceNBR());
        authInfo.setCompanyCode(companyCode);
        authInfo.setMachineModel(machineModel);
        authInfo.setDeviceMac(deviceMac);
        authInfo.setAuthCode(authCode);
        authInfo.setRecDate(new Date());
        authInfo.setRecStatus(CoreConstants.COMMON_ACTIVE);
        authInfo.setRecUserId(CoreConstants.COMMON_0);
        authInfoDAO.insert(authInfo);
        
        Redis.increment(1L,AirplayauthConstants.DEVICE_AUTH_COUNT_MONITOR,companyCode,machineModel,deviceMac).intValue();

        AuthInfoModel result = Bean.toModel(authInfo,new AuthInfoModel());
        result.setCompanyName(company);
        return result;
    }
}
