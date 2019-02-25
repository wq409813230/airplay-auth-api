package net.freeapis.asi.service.core.validation.impl;

import org.springframework.stereotype.Component;

import net.freeapis.asi.service.core.validation.Validator;

/**
 * <pre>
 * 
 *  freeapis
 *  File: StringValidator.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 * 	$Id: StringValidator.java 72642 2009-01-01 20:01:57Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年8月19日		wuqiang		Initial.
 *  
 * </pre>
 */
@Component(value = "StringValidator")
public class StringValidator implements Validator{

	@Override
	public boolean validate(String value) {
		return value.length() <= 100;
	}

}

/*
*$Log: av-env.bat,v $
*/