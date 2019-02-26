package net.freeapis.airplayauth.dao;

import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.airplayauth.face.entity.AuthInfo;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AuthInfoDAO.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthInfoDAO.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
public interface AuthInfoDAO extends GenericDAO<AuthInfo>
{
	Integer findAuthedCount(String companyCode,String machineModel) throws Exception;

	AuthInfo findAuthInfo(String companyCode,String machineModel,String deviceMac) throws Exception;
}