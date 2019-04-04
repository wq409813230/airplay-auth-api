package net.freeapis.resource.airplayauth;

import com.google.common.collect.Maps;
import net.freeapis.airplayauth.face.AuthConfigService;
import net.freeapis.airplayauth.face.AuthInfoService;
import net.freeapis.airplayauth.face.constants.AirplayauthConstants;
import net.freeapis.airplayauth.face.model.AuthConfigModel;
import net.freeapis.airplayauth.face.model.AuthInfoModel;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.constants.ParamConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.rest.BaseResources;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.core.rest.containers.FreeapisOperation;
import net.freeapis.core.rest.containers.FreeapisResource;
import net.freeapis.core.rest.utils.ResponseHelper;
import net.freeapis.core.rest.utils.ResponseModel;
import net.freeapis.systemctl.face.DictionaryService;
import net.freeapis.systemctl.face.constants.DictionaryConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * <pre>
 *
 *  freeapis
 *  File: AuthConfigResourcesV1.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: AuthConfigResourcesV1.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:37		freeapis		Initial.
 *
 * </pre>
 */
@RestController
@RequestMapping(value = "/1/authConfig")
@FreeapisResource(module = "airplayauth", value = "AuthConfigResourcesV1", description = "设备授权配置管理")
public class AuthConfigResourcesV1 extends BaseResources {

    @Autowired
    private AuthConfigService authConfigService;

    @Autowired
    private DictionaryService dictionaryService;

    @Autowired
    private AuthInfoService authInfoService;

    @FreeapisOperation(name = "createAuthConfig", ApiLevel = APILevel.SUPERADMIN, description = "创建设备授权配置")
    @RequestMapping(value = "", method = RequestMethod.POST)
    public ResponseModel<AuthConfigModel> createAuthConfig(
            @RequestBody AuthConfigModel authConfigModel) throws Exception {
        return ResponseHelper.buildResponseModel(authConfigService.createAuthConfig(authConfigModel));
    }

    @FreeapisOperation(name = "deleteAuthConfig", ApiLevel = APILevel.SUPERADMIN, description = "删除设备授权配置")
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public ResponseModel<String> deleteAuthConfig(
            @PathVariable Long id) throws Exception {
        authConfigService.deleteAuthConfig(id);
        return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
    }

    @FreeapisOperation(name = "updateAuthConfig", ApiLevel = APILevel.SUPERADMIN, description = "修改设备授权配置")
    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    public ResponseModel<AuthConfigModel> updateAuthConfig(
            @PathVariable Long id,
            @RequestBody AuthConfigModel authConfigModel) throws Exception {
        authConfigModel.setSequenceNBR(id);
        return ResponseHelper.buildResponseModel(authConfigService.updateAuthConfig(authConfigModel));
    }

    @FreeapisOperation(name = "getAuthConfigById", ApiLevel = APILevel.SUPERADMIN, description = "后台根据ID查询$设备授权配置")
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ResponseModel<AuthConfigModel> getAuthConfigById(
            @PathVariable Long id) throws Exception {
        return ResponseHelper.buildResponseModel(authConfigService.get(id));
    }

    @FreeapisOperation(name = "getAuthConfigByPage", ApiLevel = APILevel.SUPERADMIN, description = "后台分页获取设备授权配置信息")
    @RequestMapping(value = "/manage/page", method = RequestMethod.GET)
    public ResponseModel<Page> getAuthConfigByPage(
            @RequestParam(required = false) String company,
            @RequestParam(required = false) String machineModel,
            @RequestParam(value = ParamConstants.OFFSET, defaultValue = "0") int start,
            @RequestParam(value = ParamConstants.LENGTH, defaultValue = "10") int length) throws Exception {
        Page page = new Page(length, start);
        return ResponseHelper.buildResponseModel(authConfigService.getByPage(company, machineModel, page));
    }

    @FreeapisOperation(name = "getAuthInfoByConfig", ApiLevel = APILevel.SUPERADMIN, description = "根据授权配置分页获取设备认证信息列表")
    @RequestMapping(value = "/{configId}/authInfo/page", method = RequestMethod.GET)
    public ResponseModel<Page> getAuthInfoByConfig(
            @PathVariable Long configId,
            @RequestParam(required = false) String deviceMac,
            @RequestParam(value = ParamConstants.OFFSET, defaultValue = "0") int start,
            @RequestParam(value = ParamConstants.LENGTH, defaultValue = "10") int length) throws Exception {
        Page page = new Page(length, start);
        return ResponseHelper.buildResponseModel(authInfoService.getAuthInfos(configId, deviceMac, page));
    }

    @FreeapisOperation(name = "deleteAuthInfo", ApiLevel = APILevel.SUPERADMIN, description = "删除设备认证信息")
    @RequestMapping(value = "/authInfo/{authInfoId}", method = RequestMethod.DELETE)
    public ResponseModel<String> deleteAuthInfo(@PathVariable Long authInfoId) throws Exception {
        AuthInfoModel authInfo = authInfoService.deleteAuthInfo(authInfoId);
        //删除设备认证信息后要返还授权码
        String authCodePoolKey = Redis.genKey(
                AirplayauthConstants.CACHE_KEY_AUTH_CODES_POOL,authInfo.getCompanyCode(),authInfo.getMachineModel());
        Redis.sadd(new String[]{authInfo.getAuthCode()},authCodePoolKey);
        return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
    }

    @FreeapisOperation(name = "generateRSAKeyPair", ApiLevel = APILevel.SUPERADMIN, description = "生成RSA密钥对")
    @RequestMapping(value = "/rsa/keyPair", method = RequestMethod.POST)
    public ResponseModel<String> generateRSAKeyPair() throws Exception {
        authConfigService.createRSAKeyPair();
        return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
    }

    @FreeapisOperation(name = "getRSAKeyPair", ApiLevel = APILevel.SUPERADMIN, description = "获取RSA密钥对")
    @RequestMapping(value = "/rsa/keyPair", method = RequestMethod.GET)
    public ResponseModel<Map<String, String>> getRSAKeyPair() throws Exception {
        Map<String, String> map = Maps.newHashMap();
        map.put("publicKey", dictionaryService.getValue(RequestContext.getAgencyCode(),
                DictionaryConstants.DICT_CODE_SYS_PARAMS, AirplayauthConstants.DICT_KEY_RSA_PUBLIC_KEY));
        map.put("privateKey", dictionaryService.getValue(RequestContext.getAgencyCode(),
                DictionaryConstants.DICT_CODE_SYS_PARAMS, AirplayauthConstants.DICT_KEY_RSA_PRIVATE_KEY));
        return ResponseHelper.buildResponseModel(map);
    }
}