package net.freeapis.asi.face.extension;

import org.springframework.data.mongodb.core.query.Update;

/**
 * <pre>
 * 
 *  freeapis
 *  File: ASIExtension.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:动态表单的扩展接口
 *  TODO
 * 
 *  Notes:
 * 	$Id: ASIExtension.java 72642 2009-01-01 20:01:57Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年8月22日		wuqiang		Initial.
 *  
 * </pre>
 */
public interface ASIExtension {
	
	boolean updateBefore(String action,Update update,String groupCode,String entityType,String entityId) throws Exception;
	
	boolean updateAfter(String action,Update update,String groupCode,String entityType,String entityId)throws Exception;
	
}

/*
*$Log: av-env.bat,v $
*/