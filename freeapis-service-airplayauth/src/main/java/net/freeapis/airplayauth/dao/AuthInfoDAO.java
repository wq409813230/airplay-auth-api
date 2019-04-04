package net.freeapis.airplayauth.dao;

import net.freeapis.airplayauth.face.entity.AuthInfo;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.mysql.GenericDAO;

import java.util.List;

/**
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
public interface AuthInfoDAO extends GenericDAO<AuthInfo> {

    AuthInfo deleteAuthInfo(Long id) throws Exception;

    Integer findAuthedCount(String companyCode, String machineModel) throws Exception;

    AuthInfo findAuthInfo(String companyCode, String machineModel, String deviceMac) throws Exception;

    List<AuthInfo> findAuthInfosByConfigId(Long authConfigId,String deviceMac,Page page) throws Exception;
}