package net.freeapis.security.dao;

import java.util.List;

import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.security.face.entity.ModulePrimary;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: SecurityModuleRoleDao.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: SecurityModuleRoleDao.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年6月16日		wuqiang		Initial.
 *
 * </pre>
 */
public interface ModulePrimaryDAO extends GenericDAO<ModulePrimary>
{

	/**
	 * 通过主体权限信息查询模块关系
	 * @param agencyCode
	 * @param primaryType
	 * @param primaryCode
	 * @return
	 * @throws Exception 
	 */
	List<ModulePrimary> findByPrimaryInfo(String agencyCode, String primaryType, String primaryCode) throws Exception;

	/**
	 * 根据主体权限删除所有的主体权限模块关系
	 * @param agencyCode
	 * @param primaryType
	 * @param primaryCode
	 * @throws Exception
	 */
	int deleteByPrimaryInfo(String agencyCode, String primaryType, String primaryCode) throws Exception;
	
}
