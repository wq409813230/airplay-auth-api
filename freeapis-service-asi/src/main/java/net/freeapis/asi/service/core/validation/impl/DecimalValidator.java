package net.freeapis.asi.service.core.validation.impl;

import java.math.BigDecimal;

import org.springframework.stereotype.Component;

import net.freeapis.asi.service.core.validation.Validator;

/**
 * <pre>
 * 
 *  freeapis
 *  File: DecimalValidator.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 * 	$Id: DecimalValidator.java 72642 2009-01-01 20:01:57Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年8月19日		wuqiang		Initial.
 *  
 * </pre>
 */
@Component(value = "DecimalValidator")
public class DecimalValidator implements Validator{

	@Override
	public boolean validate(String value) {
		try {
			new BigDecimal(value);
		} catch (NumberFormatException e) {
			return false;
		}
		return true;
	}

	public static void main(String[] args) {
		System.out.println(new DecimalValidator().validate("11.2365489"));
	}
}

/*
*$Log: av-env.bat,v $
*/