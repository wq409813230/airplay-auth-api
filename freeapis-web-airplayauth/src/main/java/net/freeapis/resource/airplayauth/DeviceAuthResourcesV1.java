package net.freeapis.resource.airplayauth;

import com.alibaba.fastjson.JSON;
import net.freeapis.airplayauth.face.AuthInfoService;
import net.freeapis.airplayauth.face.constants.AirplayauthConstants;
import net.freeapis.airplayauth.utils.RSA;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.exceptions.DataNotFoundException;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.core.rest.containers.FreeapisOperation;
import net.freeapis.core.rest.containers.FreeapisResource;
import net.freeapis.core.rest.utils.ResponseHelper;
import net.freeapis.core.rest.utils.ResponseModel;
import net.freeapis.systemctl.face.DictionaryService;
import net.freeapis.systemctl.face.constants.DictionaryConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * freeapis,Inc.
 * Copyright(C): 2016
 *
 * <p>请描述这个类的作用,以及必要的示例
 *
 * @author Administrator
 * @date 2019年02月26日 16:10
 */
@RestController
@RequestMapping(value = "/1/deviceAuth")
@FreeapisResource(module = "deviceAuth", value = "DeviceAuthResourcesV1", description = "设备授权管理")
public class DeviceAuthResourcesV1 {

    @Autowired
    private AuthInfoService authInfoService;

    @Autowired
    private DictionaryService dictionaryService;

    @FreeapisOperation(name = "doAuthDevice", ApiLevel = APILevel.ALL, description = "设备认证", needAuth = false)
    @RequestMapping(value = "", method = RequestMethod.POST)
    public Object doAuthDevice(
            @RequestBody Map<String,String> authBody) throws Exception{
        return authInfoService.createAuthInfo(authBody);
    }

    @FreeapisOperation(name = "getPublicKey", ApiLevel = APILevel.ALL, description = "获取RSA加密公钥", needAuth = false)
    @RequestMapping(value = "/rsa/publicKey", method = RequestMethod.GET)
    public ResponseModel<String> getPublicKey() throws Exception {
        String publicKey = dictionaryService.getValue(
                CoreConstants.CODE_SUPER_ADMIN,
                DictionaryConstants.DICT_CODE_SYS_PARAMS,AirplayauthConstants.DICT_KEY_RSA_PUBLIC_KEY);
        if(ValidationUtil.isEmpty(publicKey)){
            throw new DataNotFoundException("RSA公钥未生成,请联系管理员.");
        }
        return ResponseHelper.buildResponseModel(RSA.publicPem(publicKey));
    }

    @FreeapisOperation(name = "encryptTest", ApiLevel = APILevel.ALL, description = "encryptTest", needAuth = false)
    @RequestMapping(value = "/testEncrypt", method = RequestMethod.POST)
    public String encryptTest(
            @RequestBody String authBody) throws Exception{
        String publicKey = dictionaryService.getValue(
                CoreConstants.CODE_SUPER_ADMIN,
                DictionaryConstants.DICT_CODE_SYS_PARAMS,AirplayauthConstants.DICT_KEY_RSA_PUBLIC_KEY);
        return RSA.encryptByPublic(authBody,publicKey);
    }
}