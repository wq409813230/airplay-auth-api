package net.freeapis.common.sso;

import net.freeapis.core.foundation.enumeration.UserType;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.security.face.model.UserSession;
import org.springframework.stereotype.Component;

/**
 * <pre>
 *
 *  freeapis
 *  File: AnonymousAuthAdapter.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: AnonymousAuthAdapter.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月21日		freeapis		Initial.
 *
 * </pre>
 */
@Component(value = "anonymousAuthAdapter")
public class AnonymousAuthAdapter extends AuthAdapter {

    @Override
    protected boolean doSubAuth(String module, String resource,
                                String operation, APILevel apiLevel, UserSession session) throws Exception {
        return UserType.ANONYMOUS.getValue() >= apiLevel.getValue();
    }
}

/*
 * $Log: av-env.bat,v $
 */