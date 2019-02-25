package net.freeapis.common.sso;

import net.freeapis.core.foundation.enumeration.UserType;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.security.face.model.UserSession;
import org.springframework.stereotype.Component;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: SuperadminAdapter.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: SuperadminAdapter.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月21日		freeapis		Initial.
 *
 * </pre>
 */
@Component(value = "superAuthAdapter")
public class SuperAuthAdapter extends AuthAdapter {

	@Override
	protected boolean doSubAuth(String module, String resource,
                                String operation, APILevel apiLevel, UserSession session) throws Exception {
		if(!(UserType.SUPER_ADMIN.getValue() >= apiLevel.getValue())) return false;
		return this.hasPermission(module,resource,operation,session);
	}
}

/*
 * $Log: av-env.bat,v $
 */