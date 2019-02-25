package net.freeapis.asi.service.core.validation.impl;

import org.springframework.stereotype.Component;

import net.freeapis.asi.service.core.validation.Validator;

/**
 * <pre>
 * 
 *  freeapis
 *  File: IntValidator.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 * 	$Id: IntValidator.java 72642 2009-01-01 20:01:57Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年8月19日		wuqiang		Initial.
 * 
 * </pre>
 */
@Component(value = "IntegerValidator")
public class IntegerValidator implements Validator {

	@Override
	public boolean validate(String value) {
		try {
			Integer.parseInt(value);
		} catch (NumberFormatException e) {
			return false;
		}
		return true;
	}
	
	public static void main(String[] args) {
		System.out.println(new IntegerValidator().validate("123"));
	}
}

/*
 * $Log: av-env.bat,v $
 */