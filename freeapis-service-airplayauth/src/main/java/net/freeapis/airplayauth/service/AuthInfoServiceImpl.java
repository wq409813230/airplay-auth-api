package net.freeapis.airplayauth.service;

import net.freeapis.airplayauth.dao.AuthConfigDAO;
import net.freeapis.airplayauth.dao.AuthInfoDAO;
import net.freeapis.airplayauth.face.AuthInfoService;
import net.freeapis.airplayauth.face.constants.AirplayauthConstants;
import net.freeapis.airplayauth.face.entity.AuthConfig;
import net.freeapis.airplayauth.face.entity.AuthInfo;
import net.freeapis.airplayauth.face.model.AuthInfoModel;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.exceptions.DataValidateException;
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

    @Override
    public AuthInfoModel createAuthInfo(Map<String,String> authRequest) throws Exception {
        String company = authRequest.get("company");
        String machineModel = authRequest.get("machineModel");
        String deviceMac = authRequest.get("deviceMac");
        String privateKey = authRequest.get("privateKey");
        String companyCode = PyKit.pin(company);

        //#1判断该设备是否之前认证成功过,如果认证成功则直接返回授权码
        AuthInfo authInfo = authInfoDAO.findAuthInfo(companyCode,machineModel,deviceMac);
        if(!ValidationUtil.isEmpty(authInfo)){
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
            throw new DataValidateException("机型校验失败.");
        }

        //#2-2获取授权配置
        AuthConfig authConfig = authConfigDAO.findAuthConfig(companyCode,machineModel);
        if(ValidationUtil.isEmpty(authConfig)){
            throw new DataValidateException("未找到授权信息.");
        }

        //#2-3校验密钥是否正确
        if(!authConfig.getPrivateKey().equals(privateKey)){
            throw new DataValidateException("授权密钥校验失败.");
        }

        //#2-4获取授权码
        String authCodePoolKey = Redis.genKey(
                AirplayauthConstants.CACHE_KEY_AUTH_CODES_POOL,companyCode,machineModel);
        String authCode = Redis.spop(authCodePoolKey);
        if(ValidationUtil.isEmpty(authCode)){
            throw new DataValidateException("未获取到可用的授权码,联系管理员增加授权数量.");
        }

        //#2-5记录认证信息
        authInfo = new AuthInfo();
        authInfo.setSequenceNBR(sequenceGenerator.getNextValue());
        authInfo.setCompanyCode(companyCode);
        authInfo.setMachineModel(machineModel);
        authInfo.setDeviceMac(deviceMac);
        authInfo.setAuthCode(authCode);
        authInfo.setRecDate(new Date());
        authInfo.setRecStatus(CoreConstants.COMMON_ACTIVE);
        authInfo.setRecUserId(CoreConstants.COMMON_0);
        authInfoDAO.insert(authInfo);

        AuthInfoModel result = Bean.toModel(authInfo,new AuthInfoModel());
        result.setCompanyName(company);
        return result;
    }
}