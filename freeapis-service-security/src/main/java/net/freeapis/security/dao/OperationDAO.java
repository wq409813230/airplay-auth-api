package net.freeapis.security.dao;

import net.freeapis.core.foundation.exceptions.DAOException;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.security.face.entity.Operation;

import java.util.List;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: SecurityResourceDao.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: SecurityResourceDao.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年6月16日		wuqiang		Initial.
 *
 * </pre>
 */
public interface OperationDAO extends GenericDAO<Operation>
{

	/**
	 * 删除所有的资源操作信息
	 * @return 返回受影响的行数
	 * @throws DAOException 
	 */
	int deleteAllOperations() throws Exception;

	/**
	 * 清理模块权限关系表
	 * @throws Exception
	 */
	void cleanModuleOperation() throws Exception;

	/**
	 * 清理权限表
	 * @throws Exception
	 */
	void cleanPermission() throws Exception;

	/**
	 * 根据fid查询资源详细信息
	 * @param funcId
	 * @return
	 * @throws DAOException 
	 */
	Operation findByFid(String funcId) throws Exception;

	/**
	 * 获取系统所有资源信息
	 * @return
	 */
	 List<Operation> findAllOperations()throws Exception;

	/**
	 * 判断funcid是否可用
	 * @param funcId
	 * @param id
	 * @return
	 */
    Boolean isFuncIdAvailable(String funcId, Long id) throws Exception;

	/**
	 * 分页查询资源列表
	 * @param resourceName
	 * @param page
	 * @param orderBy
	 * @param order
	 * @return
	 * @throws Exception
	 */
	List<Operation> findForPage(String resourceName, Page page, String orderBy, String order) throws Exception;
}
