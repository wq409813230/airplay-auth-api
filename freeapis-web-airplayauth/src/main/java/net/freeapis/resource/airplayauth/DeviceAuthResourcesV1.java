package net.freeapis.resource.airplayauth;

import com.alibaba.fastjson.JSON;
import net.freeapis.airplayauth.face.AuthInfoService;
import net.freeapis.airplayauth.face.model.AuthInfoModel;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.core.rest.containers.FreeapisOperation;
import net.freeapis.core.rest.containers.FreeapisResource;
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

    @FreeapisOperation(name = "doAuthDevice", ApiLevel = APILevel.ALL, description = "设备认证", needAuth = false)
    @RequestMapping(value = "", method = RequestMethod.POST)
    public Object doAuthDevice(
            @RequestBody String authBody) throws Exception{
        Map<String,String> authRequest = JSON.parseObject(authBody,Map.class);
        return authInfoService.createAuthInfo(authRequest);
        //return new AuthInfoModel();
    }
}