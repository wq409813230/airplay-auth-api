package net.freeapis.agency.face;

import net.freeapis.agency.face.entity.Department;
import net.freeapis.agency.face.model.DepartmentModel;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.orm.BaseService;

import java.util.List;
import java.util.Map;

/**
 * <pre>
 * 
 *  freeapis
 *  File: DepartmentService.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2014
 * 
 *  Description:商家部门service
 *  TODO
 * 
 *  Notes:
 * 	$Id: DepartmentService.java 31101200-9 2009-01-01 20:01:57Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年3月10日		wuqiang		Initial.
 *
 * 	@author gaoyuanteng@zhaotai.ren
 * </pre>
 */
public interface DepartmentService extends BaseService<DepartmentModel, Department> {
	
	/**
	 * 获取部门树
	 * @param agencyCode 机构编码
	 * @param parentCode 父部门UID
	 * @return DepartmentModel
	 * @throws Exception
	 */
	DepartmentModel buildDepartmentTree(String agencyCode, String parentCode) throws Exception;
	
	/**
	 * 根据父部门编号获取子部门列表
	 * @param agencyCode 机构编码
	 * @param parentCode 父部门UID
	 * @return List<DepartmentModel>
	 * @throws Exception
	 */
	List<DepartmentModel> getDepartmentsByParentCode(String agencyCode, String parentCode) throws Exception;
	
	/**
	 * 分页查询部门信息列表
	 * @param agencyCode 机构编码
	 * @param parentCode 父部门UID
	 * @param departmentCode 部门编码
	 * @param departmentName 部门名称
	 * @param lockStatus 锁定状态 N :非锁定 / Y: 锁定
	 * @param page {@link net.freeapis.core.foundation.model.Page}
	 * @param orderBy 排序字段
	 * @param order 排序方式
	 * @return Page
	 * @throws Exception 
	 */
	Page getByPage(String agencyCode, String parentCode, String departmentCode, String departmentName,
			String lockStatus, Page page, String orderBy, String order) throws Exception;
	
	/**
	 * 创建部门信息
	 * @param newDepartment 部门model
	 * @return DepartmentModel
	 * @throws Exception
	 */
	DepartmentModel createDepartment(DepartmentModel newDepartment) throws Exception;

	/**
	 * 删除部门
	 * @param agencyCode 机构编码
	 * @param departmentCodes…… 部门编码数组形式
	 * @throws Exception
	 */
	void deleteDepartments(String agencyCode,String... departmentCodes) throws Exception;
	
	/**
	 * 修改部门信息
	 * @param currentDepartment 部门model
	 * @return DepartmentModel
	 * @throws Exception
	 */
	DepartmentModel updateDepartment(DepartmentModel currentDepartment) throws Exception;

	/**
	 * 修改锁定状态
	 * @param agencyCode 机构编码
	 * @param departmentCode 部门编码
	 * @return DepartmentModel
	 * @throws Exception 
	 */
	DepartmentModel updateLockStatus(String agencyCode, String departmentCode) throws Exception;
	
	/**
	 * 根据部门code获取部门信息
	 * @param agencyCode 机构编码
	 * @param departmentCode 部门编码
	 * @return DepartmentModel
	 * @throws Exception
	 */
	DepartmentModel getDepartmentByCode(String agencyCode, String departmentCode) throws Exception;

	/**
	 * 判断部门code是否可用
	 * @param agencyCode 机构编码
	 * @param departmentCode 部门编码
	 * @return 如果部门code可以使用返回{@code true} 否则 返回{@code false}
	 * @throws Exception
	 */
	boolean isDepartmentCodeAvailable(String agencyCode, String departmentCode,Long id) throws Exception;

	/**
	 * 判断部门名称是否可用
	 * @param agencyCode 机构编码
	 * @param departmentName 部门名称
	 * @return 如果名称可以使用返回{@code true} 否则 返回{@code false}
	 * @throws Exception
	 */
	boolean isDepartmentNameAvailable(String agencyCode, String departmentName,Long id) throws Exception;

	/**
	 * 根据员工userId获取部门名称
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	Map<String,Object> getByUserId(Long userId)throws Exception;

	/**
	 * 根据一级部门获取员工信息
	 * @param agencyCode
	 * @param parentCode
	 * @return
	 * @throws Exception
	 */
	List<DepartmentModel> getByEmployees(String agencyCode, String parentCode)throws Exception;
}
