package net.freeapis.security.dao;

import java.util.List;

import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.security.face.entity.LoginHistory;

/**
 * <pre>
 * 
 *  freeapis
 *  File: LoginHistoryDAO.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  LoginHisttorydao接口
 * 
 *  Notes:
 *  $Id: LoginHistoryDAO.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月7日		freeapis		Initial.
 *
 * </pre>
 */
public interface LoginHistoryDAO extends GenericDAO<LoginHistory> {

    LoginHistory findLastLoginHistory(String token,String product) throws Exception;
}