package net.freeapis.asi.service.core.validation;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.NoSuchBeanDefinitionException;

import net.freeapis.asi.face.enums.DataType;
import net.freeapis.core.foundation.exceptions.DataValidateException;
import net.freeapis.core.foundation.support.SpringContextHelper;

/**
 * <pre>
 * 
 *  freeapis
 *  File: ASIDataValidator.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 * 	$Id: ASIDataValidator.java 72642 2009-01-01 20:01:57Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年8月19日		wuqiang		Initial.
 *  
 * </pre>
 */
public class ASIDataValidatorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(ASIDataValidatorAdapter.class);
	
	private static final String DEFAULT_BEAN_NAME_SUFIX = "Validator";
	
	public static boolean validate(DataType dataType,String value) throws DataValidateException{
		return getValidator(dataType).validate(value);
	}
	
	private static Validator getValidator(DataType dataType) throws DataValidateException{
		Validator validator = null;
		try {
			validator = SpringContextHelper.getBean(dataType.name().concat(DEFAULT_BEAN_NAME_SUFIX));
		} catch (NoSuchBeanDefinitionException e) {
			logger.error("no Validator found for DataType {}",dataType.name());
			throw new DataValidateException("no Validator found for DataType " + dataType.name());
		}
		return validator;
	}
}

/*
*$Log: av-env.bat,v $
*/