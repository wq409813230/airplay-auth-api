package net.freeapis.security.dao;

import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.security.face.entity.Employee;

import java.util.List;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: EmployeeDAO.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: EmployeeDAO.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016-09-09 15:33:42		freeapis		Initial.
 *
 * </pre>
 */
public interface EmployeeDAO extends GenericDAO<Employee> {

	/**
	 * 验证员工编号是否存在
	 * @param agencyCode
	 * @param employeeCode
	 * @return
	 * @throws Exception
	 */
    boolean isEmployeeCodeAvailable(String agencyCode, String employeeCode) throws Exception;

	/**
	 * 分页查询系统用户信息
	 * @param agencyCode
	 * @param departmentCode
	 * @param userName
	 * @param employeeCode
	 * @param page
	 * @param orderBy
	 * @param order
	 * @return
	 * @throws Exception
	 */
    List<Map<String, Object>> findByPage(String agencyCode, String departmentCode, String userName,
                                         String employeeCode, Page page, String orderBy, String order) throws Exception;

	/**
	 * 根据RoleCode查询Employee
	 * @param roleCode
	 * @return
	 * @throws Exception
	 */
    List<Employee> getEmployeesByRoleCode(String roleCode) throws Exception;

	/**
	 * 根据userId查询系统用户信息
	 * @param userId
	 * @return
	 */
    Employee findByUserId(Long userId) throws Exception;

	/**
	 * 根据员工号获取员工手机号码
	 * @param employeeCode
	 * @param employeeCode
	 * @return
	 * @throws Exception
	 */
    List<String> findEmployeeMobile(String employeeCode) throws Exception;

	/**
	 * 根据员工编码获取员工userId
	 * @param employeeCode
	 * @return
	 * @throws Exception
	 */
	Long findEmployeeCode(String employeeCode) throws Exception;

	/**
	 * 根据用户ID列表查询多个员工部门信息
	 * @param userIds
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> findEmployeeDepartmentByUserIds(List<Long> userIds) throws Exception;

	/**
	 * 根据部门编码获取员工
	 * @param agencyCode
	 * @param departmentCode
	 * @return
	 * @throws Exception
	 */
	List<Long> findUserIdsByDepartmentCode(String agencyCode, String departmentCode) throws Exception;

	/**
	 * 根据部门编码获取员工信息
	 * @param agencyCode
	 * @param departmentCode
	 * @param localStatus
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> findEmployeesByDepartmentCode(String agencyCode, String departmentCode, String localStatus)throws Exception;
}
