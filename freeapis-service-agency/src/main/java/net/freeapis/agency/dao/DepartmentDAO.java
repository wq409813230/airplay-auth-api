package net.freeapis.agency.dao;

import net.freeapis.agency.face.entity.Department;
import net.freeapis.core.foundation.exceptions.DAOException;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.mysql.GenericDAO;

import java.util.List;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AgDepartmentDao.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:部门的数据访问接口
 *  TODO
 * 
 *  Notes:
 *  $Id: AgDepartmentDao.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月24日		freeapis		Initial.
 *	@author gaoyuanteng@zhaotai.ren
 * </pre>
 */
public interface DepartmentDAO extends GenericDAO<Department> {
	
	/**
	 *	根据机构编码和父级编码查询部门列表
	 * @param agencyCode 机构编码
	 * @param parentCode 父级编码
	 * @param localStatus 锁定状态
	 * @return List<Department>
	 * @throws DAOException
	 */
	List<Department> findByParentCode(String agencyCode,String parentCode, String localStatus) throws Exception;
	
	/**
	 * 根据部门编号查询部门信息
	 * @param agencyCode 机构编码
	 * @param departmentCode 部门编码
	 * @return Department
	 * @throws Exception
	 */
	Department findByDepartmentCode(String agencyCode, String departmentCode) throws Exception;

	/**
	 * 分页查询部门信息
	 * @param agencyCode 机构编码
	 * @param parentCode 父级编码
	 * @param departmentCode 部门编码
	 * @param departmentName 部门名称
	 * @param lockStatus 启禁状态
	 * @param page {@link net.freeapis.core.foundation.model.Page}
	 * @param orderBy 排序字段
	 * @param order 排序方式
	 * @return List<Department>
	 * @throws DAOException 
	 */
	List<Department> findByPage(String agencyCode, String parentCode, String departmentCode, String departmentName,
			String lockStatus, Page page, String orderBy, String order) throws Exception;
	
	/**
	 * 删除部门
	 * @param agencyCode 机构编码
	 * @param departmentCode 部门编码
	 * @throws Exception
	 */
	void deleteWithCache(String agencyCode, String departmentCode) throws Exception;

	/**
	 * 验证部门编号是否可用
	 * @param departmentCode 部门编码
	 * @param id 主键sequenceNBR
	 * @return 如果编码可以使用返回{@code true} 否则 返回{@code false}
	 * @throws Exception
	 */
	boolean isDepartmentCodeAvailable(String agencyCode, String departmentCode, Long id) throws Exception;

	/**
	 * 验证部门名称是否可用
	 * @param agencyCode 机构编码
	 * @param departmentName 部门名称
	 * @param id 主键sequenceNBR
	 * @return 如果名称可以使用返回{@code true} 否则 返回{@code false}
	 * @throws Exception 
	 */
	boolean isDepartmentNameAvailable(String agencyCode, String departmentName, Long id) throws Exception;

	/**
	 * 检查删除引用
	 * @param agencyCode 机构编码
	 * @param departmentCode 部门编码
	 * @return String
	 */
    String deleteDepartmentCheck(String agencyCode, String departmentCode) throws Exception;

	/**
	 * 根据员工userId获取部门名称
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	Map<String,Object> findByUserId(Long userId)throws Exception;
}

/*
 * $Log: av-env.bat,v $
 */