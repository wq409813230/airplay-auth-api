package net.freeapis.asi.service.extension;

import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Component;

import net.freeapis.asi.face.extension.ASIExtension;

/**
 * <pre>
 * 
 *  freeapis
 *  File: DefaultASIExtension.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 * 	$Id: DefaultASIExtension.java 72642 2009-01-01 20:01:57Z freeapis\wuqiang $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年8月22日		wuqiang		Initial.
 *  
 * </pre>
 */
@Component(value = "defaultASIExtension")
public class DefaultASIExtension implements ASIExtension{

	@Override
	public boolean updateBefore(String action, Update update, String groupCode, String entityType, String entityId)throws Exception {
		return false;
	}

	@Override
	public boolean updateAfter(String action, Update update, String groupCode, String entityType, String entityId)throws Exception {
		return false;
	}
}

/*
*$Log: av-env.bat,v $
*/