package net.freeapis.asi.service.core.validation.impl;

import org.springframework.stereotype.Component;

import net.freeapis.asi.service.core.validation.Validator;

/**
 * <pre>
 * 
 *  freeapis
 *  File: MoneyValidator.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 * 	$Id: MoneyValidator.java 72642 2009-01-01 20:01:57Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年8月19日		wuqiang		Initial.
 *  
 * </pre>
 */
@Component(value = "MoneyValidator")
public class MoneyValidator implements Validator{

	@Override
	public boolean validate(String value) {
		return value.matches("\\d+\\.?[0-9]{2}");
	}

	public static void main(String[] args) {
		System.out.println(new MoneyValidator().validate("13.12"));
	}
}

/*
*$Log: av-env.bat,v $
*/