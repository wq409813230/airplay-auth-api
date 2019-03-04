package net.freeapis.resource.airplayauth;

import com.alibaba.fastjson.JSON;
import net.freeapis.airplayauth.face.AuthInfoService;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.core.rest.containers.FreeapisOperation;
import net.freeapis.core.rest.containers.FreeapisResource;
import net.freeapis.core.rest.utils.ResponseHelper;
import net.freeapis.core.rest.utils.ResponseModel;
import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.spec.SecretKeySpec;
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

    private static final String KEY = "0123456789ABCDEF";

    private static final String ALGORITHMSTR = "AES/ECB/PKCS5Padding";

    @FreeapisOperation(name = "doAuthDevice", ApiLevel = APILevel.ALL, description = "设备认证", needAuth = false)
    @RequestMapping(value = "", method = RequestMethod.POST)
    public String doAuthDevice(
            @RequestBody String authBody) {
        return this.doAuth(authBody);
    }

    private String doAuth(String authBody) {
        //#1AES解密出明文json
        ResponseModel responseModel = null;
        try {
            Map<String,String> authRequest = JSON.parseObject(decrypt(authBody,KEY),Map.class);
            String authCode = authInfoService.createAuthInfo(authRequest);
            responseModel = ResponseHelper.buildResponseModel("认证成功,授权码为" + authCode);
        } catch (Exception e) {
            e.printStackTrace();
            responseModel = ResponseHelper.internal_server_error(e.getMessage());
        }
        String result = null;
        try {
            result = encrypt(JSON.toJSONString(responseModel),KEY);
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 加密
     *
     * @param content    加密的字符串
     * @param encryptKey key值
     * @return
     * @throws Exception
     */
    private static String encrypt(String content, String encryptKey) throws Exception {
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        kgen.init(128);
        Cipher cipher = Cipher.getInstance(ALGORITHMSTR);
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
    public static String decrypt(String encryptStr, String decryptKey) throws Exception {
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        kgen.init(128);
        Cipher cipher = Cipher.getInstance(ALGORITHMSTR);
        cipher.init(Cipher.DECRYPT_MODE, new SecretKeySpec(decryptKey.getBytes(), "AES"));
        // 采用base64算法进行转码,避免出现中文乱码
        byte[] encryptBytes = Base64.decodeBase64(encryptStr);
        byte[] decryptBytes = cipher.doFinal(encryptBytes);
        return new String(decryptBytes);
    }

    public static void main(String[] args) throws Exception{
        String content = "{" +
                "\"company\":\"公司B\"," +
                "\"machineModel\":\"windows95\"," +
                "\"deviceMac\":\"12-de-23-08-ef-46\"," +
                "\"privateKey\":\"a123456\"" +
                "}";

        String content2 = "YcJi8X68UjJh5RQDktieJTcQgcizMk7uycaJhS7IeKUycFuv0cmlYHq1crN+yQ5umaAw8EzbIk8gWC+31jXsHBlOUagOVZQhNdjXaIR5yxBDFLTOKwPoIQMk45cQAMlbEtefpD5ldkJy9fSMMYMu4QBArpU8dLiYtd/3G1FXN1o=";
        System.out.println(encrypt(content,KEY));
    }
}