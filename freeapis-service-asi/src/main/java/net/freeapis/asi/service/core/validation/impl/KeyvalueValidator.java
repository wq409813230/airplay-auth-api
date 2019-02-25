package net.freeapis.asi.service.core.validation.impl;

import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;

import net.freeapis.asi.service.core.validation.Validator;

/**
 * <pre>
 * 
 *  freeapis
 *  File: KeyvalueValidator.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 * 	$Id: KeyvalueValidator.java 72642 2009-01-01 20:01:57Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年8月19日		wuqiang		Initial.
 *  
 * </pre>
 */
@Component(value = "KeyvalueValidator")
public class KeyvalueValidator implements Validator{

	@Override
	public boolean validate(String value) {
		try {
			JSONObject.parse(value);
		} catch (JSONException e) {
			return false;
		}
		return true;
	}
	
	public static void main(String[] args) {
		System.out.println(new KeyvalueValidator().validate("{\"name\":\"wuqiang\"}"));
	}

}

/*
*$Log: av-env.bat,v $
*/