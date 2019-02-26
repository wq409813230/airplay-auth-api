package net.freeapis.airplayauth.dao;

import net.freeapis.airplayauth.face.entity.AuthConfig;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.mysql.GenericDAO;

import java.util.List;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AuthConfigDAO.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODOs
 * 
 *  Notes:
 *  $Id: AuthConfigDAO.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:37		freeapis		Initial.
 *
 * </pre>
 */
public interface AuthConfigDAO extends GenericDAO<AuthConfig>
{
    AuthConfig findAuthConfig(String companyCode,String machineModel) throws Exception;

    List<AuthConfig> findByPage(String company, String machineModel, Page page) throws Exception;
}