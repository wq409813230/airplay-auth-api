package net.freeapis.security.face.enums;

/**
 * <pre>
 * 
 *  freeapis
 *  File: AuthType.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:认证方式
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthType.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年9月7日		wuqiang		Initial.
 *
 * </pre>
 */
public enum AuthType {
	/**
	 * 用户名密码登录
	 */
	userNamePassword,
	/**
	 * 短信验证码登录
	 */
	smscode,
	/**
	 * 第三方登录
	 */
	thirdParty,
	/**
	 * 二维码扫码登录
	 */
	qrScanning;
	
	public static AuthType getAuthType(String name){
		for(AuthType authType : AuthType.values()){
			if(authType.name().equals(name)){
				return authType;
			}
		}
		return null;
	}
}

/*
 * $Log: freeapisbuild.bat,v $
 */