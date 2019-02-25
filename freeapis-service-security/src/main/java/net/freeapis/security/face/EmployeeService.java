package net.freeapis.security.face;

import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.orm.BaseService;
import net.freeapis.security.face.entity.Employee;
import net.freeapis.security.face.model.EmployeeModel;

import java.util.List;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: EmployeeService.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: EmployeeService.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016-09-09 15:33:42		freeapis		Initial.
 *
 * </pre>
 */
public interface EmployeeService extends BaseService<EmployeeModel,Employee>
{

	EmployeeModel createEmployee(EmployeeModel employeeModel) throws Exception;

	EmployeeModel updateEmployee(EmployeeModel employeeModel) throws Exception;

	EmployeeModel getEmployee(Long id) throws Exception;

	boolean isEmployeeCodeAvailable(String agencyCode, String employeeCode) throws Exception;

	EmployeeModel updateLockStatus(Long id) throws Exception;

	Page getByPage(String agencyCode, String departmentCode, String userName,
                   String employeeCode, Page page, String orderBy, String order) throws Exception;

	/**
	 * 员工修改自身密码
	 * @param employeeModel
	 * @throws Exception
	 */
    void updatePasswordBySelf(EmployeeModel employeeModel) throws Exception;

	/**
	 * 根据员工号获取员工手机号码
	 * @param employeeCode
	 * @return
	 * @throws Exception
	 */
    String getEmployeeMobile(String employeeCode) throws Exception;

    List<Map<String,String>> getBrieflyEmployee() throws Exception;

	/**
	 * 根据部门编码获取部门下员工
	 * @param agencyCode
	 * @param departmentCode
	 * @return
	 * @throws Exception
	 */
	List<Long> getUserIdsByDepartmentCode(String agencyCode,String departmentCode)throws Exception;

	/**
	 * 查询用户简要信息
	 * @param roleCode
	 * @return
	 * @throws Exception
	 */
	List<Map<String,Object>> getBrieflyEmployee(String roleCode) throws Exception;

	List<Map<String, Object>> getUserDepartmentNameByUserIds(List<Long> userIds) throws Exception;

	/**
	 * 根据部门编码获取员工信息
	 * @param agencyCode
	 * @param departmentCode
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> getEmployeesByDepartmentCode(String agencyCode,String departmentCode, String localStatus)throws Exception;
}