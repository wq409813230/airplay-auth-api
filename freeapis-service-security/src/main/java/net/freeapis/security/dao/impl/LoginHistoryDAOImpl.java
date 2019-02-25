package net.freeapis.security.dao.impl;

import net.freeapis.core.mysql.GenericDAOImpl;
import net.freeapis.security.dao.LoginHistoryDAO;
import net.freeapis.security.face.entity.LoginHistory;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: LoginHistoryDAOImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: LoginHistoryDAOImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月7日		freeapis		Initial.
 *
 * </pre>
 */
@Repository(value = "loginHistoryDAO")
public class LoginHistoryDAOImpl extends GenericDAOImpl<LoginHistory>implements LoginHistoryDAO {

    @Override
    public LoginHistory findLastLoginHistory(String token, String product) throws Exception {
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("SESSION_ID",token);
        params.put("PRODUCT",product);
        return this.findFirst(" AND SESSION_ID = :SESSION_ID AND PRODUCT = :PRODUCT",params);
    }
}