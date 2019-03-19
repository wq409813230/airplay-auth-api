package net.freeapis.airplayauth.utils;

import com.google.common.collect.Maps;
import net.freeapis.core.foundation.utils.ByteUtil;

import javax.crypto.Cipher;
import java.security.*;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.Map;

/**
 * 1、公钥加密，私钥解密用于信息加密
 * 2、私钥加密，公钥解密用于数字签名
 */
public class RSA {

    //定义加密方式
    public static final String KEY_RSA = "RSA";
    //定义公钥关键词
    public static final String KEY_RSA_PUBLIC_KEY = "RSAPublicKey";
    //定义私钥关键词
    public static final String KEY_RSA_PRIVATE_KEY = "RSAPrivateKey";
    //定义签名算法
    private final static String KEY_RSA_SIGNATURE = "MD5withRSA";

    /**
     * 生成公私密钥对
     */
    public static Map<String, Key> init() {
        Map<String, Key> map = Maps.newHashMap();
        try {
            KeyPairGenerator generator = KeyPairGenerator.getInstance(KEY_RSA);
            //设置密钥对的bit数，越大越安全，但速度减慢，一般使用512或1024
            generator.initialize(1024);
            KeyPair keyPair = generator.generateKeyPair();
            // 获取公钥  
            RSAPublicKey publicKey = (RSAPublicKey) keyPair.getPublic();
            // 获取私钥  
            RSAPrivateKey privateKey = (RSAPrivateKey) keyPair.getPrivate();
            // 将密钥对封装为Map
            map.put(KEY_RSA_PUBLIC_KEY, publicKey);
            map.put(KEY_RSA_PRIVATE_KEY, privateKey);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            throw new IllegalArgumentException(e.getMessage());
        }

        return map;
    }

    /**
     * 获取Hex编码的公钥字符串
     */
    public static String getPublicKey(Map<String, Key> map) {
        return encryptBase64(map.get(KEY_RSA_PUBLIC_KEY).getEncoded());
    }

    /**
     * 获取Hex编码的私钥字符串
     */
    public static String getPrivateKey(Map<String, Key> map) {
        return encryptBase64(map.get(KEY_RSA_PRIVATE_KEY).getEncoded());
    }

    public static byte[] decryptHexString(String key) {
        return ByteUtil.hexString2Bytes(key);
    }

    public static String encryptHexString(byte[] key) {
        return ByteUtil.toString(key,16);
    }

    public static byte[] decryptBase64(String key) {
        return Base64.getDecoder().decode(key);
    }

    public static String encryptBase64(byte[] key) {
        return new String(Base64.getEncoder().encode(key));
    }

    /**
     * 公钥加密
     *
     * @param encryptingStr
     * @param publicKeyStr
     * @return
     */
    public static String encryptByPublic(String encryptingStr, String publicKeyStr) {
        try {
            // 将公钥由字符串转为UTF-8格式的字节数组
            byte[] publicKeyBytes = decryptBase64(publicKeyStr);
            // 获得公钥  
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicKeyBytes);
            // 取得待加密数据
            byte[] data = encryptingStr.getBytes();
            KeyFactory factory;
            factory = KeyFactory.getInstance(KEY_RSA);
            PublicKey publicKey = factory.generatePublic(keySpec);
            // 对数据加密  
            Cipher cipher = Cipher.getInstance(factory.getAlgorithm());
            cipher.init(Cipher.ENCRYPT_MODE, publicKey);
            // 返回加密后由Base64编码的加密信息
            return encryptHexString(cipher.doFinal(data));
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalArgumentException(e.getMessage());
        }
    }

    /**
     * 私钥解密
     *
     * @param encryptedStr
     * @param privateKeyStr
     * @return
     */
    public static String decryptByPrivate(String encryptedStr, String privateKeyStr) {
        try {
            // 对私钥解密  
            byte[] privateKeyBytes = decryptBase64(privateKeyStr);
            // 获得私钥 
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(privateKeyBytes);
            // 获得待解密数据
            byte[] data = decryptHexString(encryptedStr);
            KeyFactory factory = KeyFactory.getInstance(KEY_RSA);
            PrivateKey privateKey = factory.generatePrivate(keySpec);
            // 对数据解密
            Cipher cipher = Cipher.getInstance(factory.getAlgorithm());
            cipher.init(Cipher.DECRYPT_MODE, privateKey);
            // 返回UTF-8编码的解密信息
            return new String(cipher.doFinal(data));
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalArgumentException(e.getMessage());
        }
    }

    /**
     * 私钥加密
     *
     * @param encryptingStr
     * @param privateKeyStr
     * @return
     */
    public static String encryptByPrivate(String encryptingStr, String privateKeyStr) {
        try {
            byte[] privateKeyBytes = decryptBase64(privateKeyStr);
            // 获得私钥  
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(privateKeyBytes);
            // 取得待加密数据
            byte[] data = encryptingStr.getBytes();
            KeyFactory factory = KeyFactory.getInstance(KEY_RSA);
            PrivateKey privateKey = factory.generatePrivate(keySpec);
            // 对数据加密 
            Cipher cipher = Cipher.getInstance(factory.getAlgorithm());
            cipher.init(Cipher.ENCRYPT_MODE, privateKey);
            // 返回加密后由Base64编码的加密信息
            return encryptHexString(cipher.doFinal(data));
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalArgumentException(e.getMessage());
        }
    }

    /**
     * 公钥解密
     *
     * @param encryptedStr
     * @param publicKeyStr
     * @return
     */
    public static String decryptByPublic(String encryptedStr, String publicKeyStr) {
        try {
            // 对公钥解密  
            byte[] publicKeyBytes = decryptBase64(publicKeyStr);
            // 取得公钥  
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicKeyBytes);
            // 取得待加密数据
            byte[] data = decryptHexString(encryptedStr);
            KeyFactory factory = KeyFactory.getInstance(KEY_RSA);
            PublicKey publicKey = factory.generatePublic(keySpec);
            // 对数据解密  
            Cipher cipher = Cipher.getInstance(factory.getAlgorithm());
            cipher.init(Cipher.DECRYPT_MODE, publicKey);
            // 返回UTF-8编码的解密信息
            return new String(cipher.doFinal(data));
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalArgumentException(e.getMessage());
        }
    }

    /**
     * 用私钥对加密数据进行签名
     *
     * @param encryptedStr
     * @param privateKey
     * @return
     */
    public static String sign(String encryptedStr, String privateKey) {
        try {
            //将私钥加密数据字符串转换为字节数组
            byte[] data = encryptedStr.getBytes();
            // 解密由base64编码的私钥  
            byte[] bytes = decryptBase64(privateKey);
            // 构造PKCS8EncodedKeySpec对象  
            PKCS8EncodedKeySpec pkcs = new PKCS8EncodedKeySpec(bytes);
            // 指定的加密算法  
            KeyFactory factory = KeyFactory.getInstance(KEY_RSA);
            // 取私钥对象  
            PrivateKey key = factory.generatePrivate(pkcs);
            // 用私钥对信息生成数字签名  
            Signature signature = Signature.getInstance(KEY_RSA_SIGNATURE);
            signature.initSign(key);
            signature.update(data);
            return encryptHexString(signature.sign());
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalArgumentException(e.getMessage());
        }
    }

    /**
     * 校验数字签名
     *
     * @param encryptedStr
     * @param publicKey
     * @param sign
     * @return 校验成功返回true，失败返回false
     */
    public static boolean verify(String encryptedStr, String publicKey, String sign) {
        try {
            //将私钥加密数据字符串转换为字节数组
            byte[] data = encryptedStr.getBytes();
            // 解密由base64编码的公钥  
            byte[] bytes = decryptBase64(publicKey);
            // 构造X509EncodedKeySpec对象  
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(bytes);
            // 指定的加密算法  
            KeyFactory factory = KeyFactory.getInstance(KEY_RSA);
            // 取公钥对象  
            PublicKey key = factory.generatePublic(keySpec);
            // 用公钥验证数字签名  
            Signature signature = Signature.getInstance(KEY_RSA_SIGNATURE);
            signature.initVerify(key);
            signature.update(data);
            return signature.verify(decryptHexString(sign));
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalArgumentException(e.getMessage());
        }
    }

    /**
     * 测试方法
     */
    public static void main(String[] args) {
        Map<String, Key> map = RSA.init();
        System.out.println("公钥："+RSA.getPublicKey(map));
        System.out.println("私钥："+RSA.getPrivateKey(map));
        //由前四行代码获得公、私密钥
        String publicKey = RSA.getPublicKey(map);
        String privateKey = RSA.getPrivateKey(map);

        String str = "你好goldlone, RSA!";
        // 公钥加密，私钥解密
        String enStr1 = RSA.encryptByPublic(str, publicKey);
        System.out.println("公钥加密后：" + enStr1);
        String deStr1 = RSA.decryptByPrivate(enStr1, privateKey);
        System.out.println("私钥解密后：" + deStr1);
        // 私钥加密，公钥解密
        String enStr2 = RSA.encryptByPrivate(str, privateKey);
        System.out.println("私钥加密后：" + enStr2);
        String deStr2 = RSA.decryptByPublic(enStr2, publicKey);
        System.out.println("公钥解密后：" + deStr2);
        // 产生签名
        String sign = sign(enStr2, privateKey);
        System.out.println("签名:" + sign);
        // 验证签名
        boolean status = verify(enStr2, publicKey, sign);
        System.out.println("状态:" + status);

    }
}