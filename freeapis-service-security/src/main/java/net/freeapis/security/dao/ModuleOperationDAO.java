package net.freeapis.security.dao;

import java.util.List;

import net.freeapis.core.foundation.exceptions.DAOException;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.security.face.entity.ModuleOperation;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: SecurityModuleResourceDao.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: SecurityModuleResourceDao.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年6月16日		wuqiang		Initial.
 *
 * </pre>
 */
public interface ModuleOperationDAO extends GenericDAO<ModuleOperation>
{

	/**
	 * 根据模块code查询对应的接口资源信息
	 * @param agencyCode
	 * @param moduleCode
	 * @return
	 * @throws DAOException 
	 */
	List<ModuleOperation> findByModuleCode(String agencyCode,String moduleCode) throws Exception;

	/**
	 * 根据ModuleCode删除模块权限信息
	 * @param agencyCode
	 * @param moduleCode
	 */
	void deleteByModule(String agencyCode, String moduleCode) throws Exception;

	/**
	 * 根据agencyCode查询所有模块权限
	 * @param agencyCode
	 * @return
	 * @throws Exception
	 */
	List<ModuleOperation> findByAgencyCode(String agencyCode) throws Exception;

	/**
	 * 判断模块操作按钮编码是否唯一
	 * @param agencyCode
	 * @param moduleCode
	 * @param buttonCode
	 * @param id
	 * @return
	 */
    boolean isOperationButtonCodeAvailable(String agencyCode, String moduleCode, String buttonCode, Long id) throws Exception;

	/**
	 * 分页获取模块资源操作信息
	 * @param agencyCode
	 * @param moduleCode
	 * @param buttonName
	 * @param page
	 * @param order
	 * @param orderBy
	 * @return
	 */
	List<ModuleOperation> findByPage(String agencyCode, String moduleCode, String buttonName, Page page, String order, String orderBy) throws Exception;
}
