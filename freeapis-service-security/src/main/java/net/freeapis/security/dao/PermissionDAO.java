package net.freeapis.security.dao;

import java.util.Collection;
import java.util.List;

import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.security.face.entity.Permission;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: SecurityRolePrivilegeDao.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: SecurityRolePrivilegeDao.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年6月16日		wuqiang		Initial.
 *
 * </pre>
 */
public interface PermissionDAO extends GenericDAO<Permission>
{

	/**
	 * 查询主体对应的模块权限信息
	 * @param agencyCode
	 * @param moduleCode
	 * @param primaryType
	 * @param primaryCode
	 * @return
	 * @throws Exception
	 */
	List<Permission> findByPrimaryInfo(String agencyCode,String moduleCode,String primaryType,String primaryCode) throws Exception;

	/**
	 * 根据主体信息删除权限关系
	 * @param agencyCode
	 * @param primaryType
	 * @param primaryCode
	 * @throws Exception
	 */
	int deleteByPrimaryInfo(String agencyCode, String primaryType, String primaryCode) throws Exception;

	/**
	 * 获取主体权限的funcIds
	 * @param agencyCode
	 * @param primaryType
	 * @param primaryCode
	 * @return
	 */
	List<String> findPrimaryFuncIds(String agencyCode,String primaryType,String primaryCode) throws Exception;
}
