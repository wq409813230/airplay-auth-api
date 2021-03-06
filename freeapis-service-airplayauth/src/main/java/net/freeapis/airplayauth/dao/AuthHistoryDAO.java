package net.freeapis.airplayauth.dao;

import net.freeapis.airplayauth.face.entity.AuthHistory;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.mysql.GenericDAO;

import java.util.List;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AuthHistoryDAO.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthHistoryDAO.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
public interface AuthHistoryDAO extends GenericDAO<AuthHistory>
{
    List<Map<String,Object>> findByPage(String deviceMac,String machineModel, String companyName, Page page) throws Exception;

    Integer findAuthSuccessCount(String company,String machineModel,String deviceMac) throws Exception;

    void deleteByDeviceMac(String deviceMac) throws Exception;
}