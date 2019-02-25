package net.freeapis.security.dao;

import net.freeapis.core.foundation.exceptions.DAOException;
import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.security.face.entity.Module;

import java.util.List;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: SecurityModuleDao.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: SecurityModuleDao.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年8月2日		Initial.
 *
 * </pre>
 */
public interface ModuleDAO extends GenericDAO<Module>
{
	/**
	 * 修改模块
	 * @param module
	 * @throws Exception
	 */
	void update(Module module) throws Exception;

	/**
	 * 根据模块编号查询模块信息
	 * @param agencyCode
	 * @param moduleCode
	 * @return
	 * @throws DAOException 
	 * @throws Exception 
	 */
	Module findByModuleCode(String agencyCode,String moduleCode) throws Exception;

	/**
	 *根据父编码获取模块列表
	 * @param agencyCode
	 * @param parentCode
	 * @return
	 * @throws Exception
	 */
	List<Module> findByParentCode(String agencyCode,String parentCode, boolean isAgencyTemplate)throws Exception;

	/**
	 *根据agencyCode查找模块信息
	 * @param agencyCode
	 * @return
	 * @throws Exception
	 */
	List<Module> findByAgencyCode(String agencyCode)throws Exception;

	/**
	 * 删除模块
	 * @param agencyCode
	 * @param moduleCode
	 * @throws Exception
	 */
	void deleteByModuleCode(String agencyCode,String moduleCode)throws Exception;

	/**
	 * 判断模块code是否可用
	 * @param agencyCode
	 * @param moduleCode
	 * @param id
	 * @return
	 * @throws Exception
	 */
	boolean isModuleCodeAvailable(String agencyCode,String moduleCode, Long id)throws Exception;

}
