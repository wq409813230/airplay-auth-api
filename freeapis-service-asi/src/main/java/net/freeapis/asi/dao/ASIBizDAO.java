package net.freeapis.asi.dao;

import net.freeapis.asi.face.entity.ASIBiz;
import net.freeapis.core.mysql.GenericDAO;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: ASIBizDAO.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: ASIBizDAO.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
public interface ASIBizDAO extends GenericDAO<ASIBiz> {
	
	void insertWithCache(ASIBiz asiBiz) throws Exception;

	void deleteWithCache(String agencyCode, String entityType) throws Exception;

	void updateWithCache(ASIBiz asiBiz) throws Exception;

	ASIBiz findASIBiz(String agencyCode,String groupCode,String entityType) throws Exception;

}
