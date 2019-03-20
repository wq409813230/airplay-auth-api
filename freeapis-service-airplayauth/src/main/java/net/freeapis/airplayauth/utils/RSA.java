package net.freeapis.airplayauth.utils;

import com.google.common.collect.Maps;
import net.freeapis.core.foundation.utils.ByteUtil;
import org.apache.commons.codec.binary.Base64;
import org.bouncycastle.asn1.ASN1Encodable;
import org.bouncycastle.asn1.ASN1Primitive;
import org.bouncycastle.asn1.pkcs.PrivateKeyInfo;
import org.bouncycastle.asn1.x509.SubjectPublicKeyInfo;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.bouncycastle.util.io.pem.PemObject;
import org.bouncycastle.util.io.pem.PemWriter;

import javax.crypto.Cipher;
import java.io.StringWriter;
import java.security.*;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
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
        return Base64.decodeBase64(key);
    }

    public static String encryptBase64(byte[] key) {
        return Base64.encodeBase64URLSafeString(key);
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
            Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
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
     * java生成openssl兼容的rsa 公私钥
     * <p>
     * KeyPairGenerator生成的 私钥是pkcs8格式，需要先转为pkcs1格式，再由pkcs1转为pem格式(openssl生成的pem)
     * KeyPairGenerator生成的 公钥是x509格式,需要替换_为/,替换-为+，格式化后，加-----BEGIN PUBLIC KEY-----头，-----END PUBLIC KEY-----尾，就与openssl生成的公钥一致了
     * <p>
     * 根据私钥生成公钥，公私钥是一对一 openssl rsa -pubout -in rsa_private_key.pem -out rsa_public_key.pem
     */
    public static String publicPem(String publicKey){
        try {
            byte[] pubBytes = Base64.decodeBase64(publicKey);

            SubjectPublicKeyInfo spkInfo = SubjectPublicKeyInfo.getInstance(pubBytes);
            ASN1Primitive primitive = spkInfo.parsePublicKey();
            byte[] publicKeyPKCS1 = primitive.getEncoded();

            PemObject pemObject = new PemObject("RSA PUBLIC KEY", publicKeyPKCS1);
            StringWriter stringWriter = new StringWriter();
            PemWriter pemWriter = new PemWriter(stringWriter);
            pemWriter.writeObject(pemObject);
            pemWriter.close();
            return stringWriter.toString();
        }catch (Exception e){
            e.printStackTrace();
            throw new IllegalStateException(e.getMessage());
        }
    }

    public static String privatePem(String privateKey)  {
        try {
            byte[] privBytes = Base64.decodeBase64(privateKey);
            PrivateKeyInfo pkInfo = PrivateKeyInfo.getInstance(privBytes);
            ASN1Encodable encodable = pkInfo.parsePrivateKey();
            ASN1Primitive primitive = encodable.toASN1Primitive();
            byte[] privateKeyPKCS1 = primitive.getEncoded();
            return pkcs1ToPem(privateKeyPKCS1, false);
        }catch (Exception e){
            e.printStackTrace();
            throw new IllegalStateException(e.getMessage());
        }
    }

    public static String pkcs1ToPem(byte[] pcks1KeyBytes, boolean isPublic) {
        try {
            String type;
            if (isPublic) {
                type = "RSA PUBLIC KEY";
            } else {
                type = "RSA PRIVATE KEY";
            }
            PemObject pemObject = new PemObject(type, pcks1KeyBytes);
            StringWriter stringWriter = new StringWriter();
            PemWriter pemWriter = new PemWriter(stringWriter);
            pemWriter.writeObject(pemObject);
            pemWriter.close();
            return stringWriter.toString();
        }catch (Exception e){
            e.printStackTrace();
            throw new IllegalStateException(e.getMessage());
        }
    }

    /**
     * 测试方法
     */
    public static void main(String[] args) {
        /*Map<String, Key> map = RSA.init();
        System.out.println("公钥："+RSA.getPublicKey(map));
        System.out.println("私钥："+RSA.getPrivateKey(map));
        //由前四行代码获得公、私密钥
        String publicKey = RSA.getPublicKey(map);
        String privateKey = RSA.getPrivateKey(map);

        System.out.println(privateKey);
        String pem = RSA.privatePem(privateKey);
        System.out.println("openssl 生成的私钥.pem:");
        System.out.println(pem);

        System.out.println(publicKey);
        System.out.println("openssl 生成的公钥.pem");
        System.out.println(RSA.publicPem(publicKey));

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
        System.out.println("状态:" + status);*/
        String privateData = "a73355a375b1d89d8893a12b58aac92c0d0bc258cda92757b44f25db816cb3324c7605ab5c70fdb10c4a45ebdc5a82e0faae7cc8186aef155dabc63dbccc0834798f2f86bf4924fef810e0199ced963812258c30c7cc3cdc3d196713fdf11fc5e662283aab1d097f993fa07166a83d3e63f4d6da4652ed9bad99d40b9c995611";
        String privateKey = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAK7zhKC4F2wOggAH5FuYsRe4KEnBtahtOaJZDcJyATTH2YNPZfG0YUBomW5xrYJ6-FsoKnqx4Whi_Wa-l6FnetW2IZBmo1tpU7nZ_GIQrpn6VqqY7lgYQ7KurCpc3dadd81m0pHhoHkaHRaoeEfrKnvlr7WC5NE_-jNpOKOrvHnvAgMBAAECgYA6raiVM0l_z5ngosT_x8XV-8lfe54PIJtNDWtlBVHMPx-AQDgkCmj37l1Pwsb8VXxJLr6YqmK83T66oEBBPXDgAM5QeRuaXiFCUTN6UM1_DR1kMUsto2hjK4CfqW7W5G7y-43ZOga5iXrv_XSndZCyUT27QzjauTOWIXqBa8_ZQQJBAOJgBY0Di4Wgonk7ehqFJxe7OA0WryKT8kXtMaiJp3ZSWUSHKYII1D-UylD0sDMPZpE_AZQJP9h30JUoO6crAc8CQQDF2LQwokCVVcxbpKVXPK3AL9ey-Fc05yuRtXdS2qZlv2chdT6EgxfWHOas9804Y6pJznZb499dZYizqAVGma3hAkEAgim6J1n5eI1jvpePXv5e-wtAcG4xp40wCjsXiZQVATjacUfSex1-hUyVhDUdt05MqIl069zhpCNIgOtQWY-mCwJAL1ReFtxZ0t_JmYrTuwDbGATZ9wiN5CwBMkRVHU8NS330b_6aTB0IUMJtNKe7QmglTq7DhcwHnVIy17e0O2V8QQJAYHtjqYcveRw64BRU1Y6Smj0DI4sJ0Y158tBV9HGU6l8xerhmAPDD0wA8ThZPzEiFffQxfcadG2IHuVkxlXD9Rw";
        System.out.println(RSA.decryptByPrivate(privateData,privateKey));
    }
}