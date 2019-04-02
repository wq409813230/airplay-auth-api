package net.freeapis.airplayauth.service;

import com.google.common.collect.Lists;
import net.freeapis.airplayauth.dao.AuthConfigDAO;
import net.freeapis.airplayauth.dao.AuthInfoDAO;
import net.freeapis.airplayauth.face.AuthConfigService;
import net.freeapis.airplayauth.face.constants.AirplayauthConstants;
import net.freeapis.airplayauth.face.entity.AuthConfig;
import net.freeapis.airplayauth.face.model.AuthConfigModel;
import net.freeapis.airplayauth.utils.RSA;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.exceptions.DataNotFoundException;
import net.freeapis.core.foundation.exceptions.DataValidateException;
import net.freeapis.core.foundation.exceptions.DuplicateException;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.PyKit;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.lightkit.$;
import net.freeapis.core.mysql.BaseServiceImpl;
import net.freeapis.systemctl.face.DictionaryService;
import net.freeapis.systemctl.face.constants.DictionaryConstants;
import net.freeapis.systemctl.face.model.DictionaryEntryModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AuthConfigServiceImpl.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthConfigServiceImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:37		freeapis		Initial.
 *
 * </pre>
 */
@Service(value="authConfigService")
public class AuthConfigServiceImpl extends BaseServiceImpl<AuthConfigModel, AuthConfig> implements AuthConfigService
{
    @Autowired
    private AuthConfigDAO authConfigDAO;

    @Autowired
    private AuthInfoDAO authInfoDAO;

    @Autowired
    private DictionaryService dictionaryService;

    @Override
    public AuthConfigModel createAuthConfig(AuthConfigModel authConfigModel) throws Exception {
        //#1判断机型存不存在
        String machineModel = authConfigModel.getMachineModel();
        DictionaryEntryModel machineModelEntry =
                dictionaryService.getEntry(
                        RequestContext.getAgencyCode(),
                        AirplayauthConstants.DICT_CODE_MACHINE_MODEL,machineModel);
        if(ValidationUtil.isEmpty(machineModelEntry)){
            throw new DataValidateException("机型" + machineModel + "不存在.");
        }

        //#2判断是否已配置授权
        String companyName = authConfigModel.getCompanyName();
        String companyCode = PyKit.pin(companyName);
        AuthConfig authConfig = authConfigDAO.findAuthConfig(companyCode,machineModel);
        if(!ValidationUtil.isEmpty(authConfig)){
            throw new DuplicateException("已经为" + companyName + "授权过机型" + machineModel);
        }

        //#3根据最大授权数生成授权码
        int maxDeviceCount = authConfigModel.getMaxDeviceCount();
        this.generateAuthCode(companyCode,machineModel,maxDeviceCount);

        //#4保存设备授权配置
        authConfigModel.setCompanyCode(companyCode);
        authConfigModel.setCreateTime(new Date());
        return super.create(authConfigModel);
    }

    @Override
    public void deleteAuthConfig(Long id) throws Exception {
        AuthConfig authConfig = authConfigDAO.findById(id);
        if(ValidationUtil.isEmpty(authConfig)){
            throw new DataNotFoundException(MessageConstants.DATA_NOT_FOUND);
        }
        //#0校验有没有已经授权的设备
        int authedCount = authInfoDAO.findAuthedCount(authConfig.getCompanyCode(),authConfig.getMachineModel());
        if(authedCount > 0){
            throw new DataValidateException(
                    "已经为【"+ authConfig.getCompanyName()
                            +"】授权机型【"+ authConfig.getMachineModel() + "】【" + authedCount +"】台,不能删除授权配置.");
        }
        //#1删除授权码
        Redis.remove(
                AirplayauthConstants.CACHE_KEY_AUTH_CODES_POOL,authConfig.getCompanyCode(),authConfig.getMachineModel());
        //#2删除授权配置
        authConfigDAO.delete(id);
    }

    private void generateAuthCode(String companyCode,String machineModel,int maxAuthCount) throws Exception{
        char[] digits = {
                '0' , '1' , '2' , '3' , '4' , '5' ,
                '6' , '7' , '8' , '9' , 'A' , 'B' ,
                'C' , 'D' , 'E' , 'F' , 'G' , 'H' ,
                'I' , 'J' , 'K' , 'L' , 'M' , 'N' ,
                'O' , 'P' , 'Q' , 'R' , 'S' , 'T' ,
                'U' , 'V' , 'W' , 'X' , 'Y' , 'Z'
        };
        int radix = digits.length;
        int bitSize = 4;

        List<String> existsAuthCodes = $.mysql().query("" +
                "SELECT AUTH_CODE FROM AIRPLAYAUTH_AUTH_INFO WHERE COMPANY_CODE = ? AND MACHINE_MODEL = ?",companyCode,machineModel);
        List<String> authCodes = Lists.newArrayList();
        for(int i = 0; i < maxAuthCount; i++){
            char[] bits = new char[bitSize];
            int currentNum = i;
            for(int j = 1; j <= bitSize; j++){
                bits[bitSize - j] = digits[currentNum % radix];
                currentNum = currentNum / radix;
            }
            String authCode = new String(bits);
            if(!existsAuthCodes.contains(authCode)){
                authCodes.add(authCode);
            }
        }
        String authCodePoolKey = Redis.genKey(
                AirplayauthConstants.CACHE_KEY_AUTH_CODES_POOL,companyCode,machineModel);
        if(!ValidationUtil.isEmpty(authCodes)){
            Redis.remove(authCodePoolKey);
            Redis.sadd(authCodes.toArray(),authCodePoolKey);
        }
    }

    @Override
    public AuthConfigModel updateAuthConfig(AuthConfigModel authConfigModel) throws Exception {
        //#更新授权配置,公司和机型不允许修改
        AuthConfig authConfig = authConfigDAO.findById(authConfigModel.getSequenceNBR());
        this.generateAuthCode(authConfig.getCompanyCode(),authConfig.getMachineModel(),authConfigModel.getMaxDeviceCount());
        authConfig.setMaxAuthCount(authConfigModel.getMaxAuthCount());
        authConfig.setMaxDeviceCount(authConfigModel.getMaxDeviceCount());
        authConfig.setPrivateKey(authConfigModel.getPrivateKey());
        authConfig.setRecDate(new Date());
        authConfig.setRecUserId(RequestContext.getExeUserId());
        authConfigDAO.update(authConfig);
        return Bean.toModel(authConfig,authConfigModel);
    }

    @Override
    public Page getByPage(String company,String machineModel,Page page) throws Exception {
        page.setList(authConfigDAO.findByPage(company,machineModel,page));
        return page;
    }

    @Override
    public void createRSAKeyPair() throws Exception {
        dictionaryService.deleteEntry(
                RequestContext.getAgencyCode(),DictionaryConstants.DICT_CODE_SYS_PARAMS,
                AirplayauthConstants.DICT_KEY_RSA_PUBLIC_KEY,AirplayauthConstants.DICT_KEY_RSA_PRIVATE_KEY);

        Map<String, Key> map = RSA.init();
        String publicKey = RSA.getPublicKey(map);
        String privateKey = RSA.getPrivateKey(map);

        DictionaryEntryModel publicKeyEntry = new DictionaryEntryModel();
        publicKeyEntry.setDictCode(DictionaryConstants.DICT_CODE_SYS_PARAMS);
        publicKeyEntry.setEntryKey(AirplayauthConstants.DICT_KEY_RSA_PUBLIC_KEY);
        publicKeyEntry.setEntryValue(publicKey);
        dictionaryService.createEntry(publicKeyEntry);

        DictionaryEntryModel privateKeyEntry = new DictionaryEntryModel();
        privateKeyEntry.setDictCode(DictionaryConstants.DICT_CODE_SYS_PARAMS);
        privateKeyEntry.setEntryKey(AirplayauthConstants.DICT_KEY_RSA_PRIVATE_KEY);
        privateKeyEntry.setEntryValue(privateKey);
        dictionaryService.createEntry(privateKeyEntry);
    }
}