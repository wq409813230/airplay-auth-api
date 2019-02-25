package net.freeapis.asi.face.extension;

import net.freeapis.asi.face.constants.ASIConstants;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.support.SpringContextHelper;
import net.freeapis.core.foundation.utils.ValidationUtil;
import org.springframework.data.mongodb.core.query.Update;

/**
 * <pre>
 * 
 *  freeapis
 *  File: ASIBizHandler.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 * 	$Id: ASIBizHandler.java 72642 2009-01-01 20:01:57Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年8月22日		wuqiang		Initial.
 * 
 * </pre>
 */
public class ASIBizHandler {

	private static final String HANDLER_BEAN_SUFIX = "ASIExtension";

	private static ASIExtension getExtension(String groupCode) throws Exception {
		return SpringContextHelper.getBean(getBeanName(groupCode) + HANDLER_BEAN_SUFIX);

	}

	private static String getBeanName(String typeName){
		ASIGroupType asiGroupType = ASIGroupType.getASIGroupType(typeName);
		if (!ValidationUtil.isEmpty(asiGroupType)){
			switch (asiGroupType) {
				case BANNER:
				case SAMPLEBANNER:
					return ASIGroupType.BANNER.name();
				case HOT:
				case TOPIC:
				case ADPLACELIST:
					return typeName;
				case UZAOC:
				case FRMB:
				case FAQ:
					return ASIConstants.DEFAULT;
				default:
					return ASIConstants.DEFAULT;
			}
		}
		return ASIConstants.DEFAULT;
	}

	public static boolean updateBefore(String action, Update update, String groupCode,String entityType, String entityId) throws Exception {
		return getExtension(groupCode).updateBefore(action, update, groupCode,entityType, entityId);
	}

	public static boolean updateAfter(String action, Update update, String groupCode,String entityType, String entityId) throws Exception {
		return getExtension(groupCode).updateAfter(action, update,groupCode, entityType, entityId);
	}
}

/*
 * $Log: av-env.bat,v $
 */