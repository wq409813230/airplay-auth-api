package net.freeapis.agency.service;

import net.freeapis.agency.dao.DepartmentDAO;
import net.freeapis.agency.face.DepartmentService;
import net.freeapis.agency.face.entity.Department;
import net.freeapis.agency.face.model.DepartmentModel;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.constants.ParamConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.exceptions.BadRequestException;
import net.freeapis.core.foundation.exceptions.BusinessException;
import net.freeapis.core.foundation.exceptions.DAOException;
import net.freeapis.core.foundation.exceptions.DataValidateException;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.BaseServiceImpl;
import net.freeapis.core.mysql.ReferenceModel;
import net.freeapis.security.face.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: DepartmentServiceImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:部门接口业务逻辑实现
 *  @author gaoyuanteng@zhaotai.ren
 * 
 *  Notes:
 *  $Id: DepartmentServiceImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年07月18日		framework		Initial.
 *
 * </pre>
 */
@Service(value="departmentService")
public class DepartmentServiceImpl extends BaseServiceImpl<DepartmentModel, Department> implements DepartmentService
{
	
	@Autowired
	DepartmentDAO departmentDAO;

	@Autowired
	private EmployeeService employeeService;

	@Override
	public DepartmentModel buildDepartmentTree(String agencyCode, String departmentCode) throws Exception {
		if(ValidationUtil.isEmpty(agencyCode)){
			throw new BadRequestException(MessageConstants.DATA_VALIDATION_FAILED);
		}
		DepartmentModel departmentModel = null;
		if(ParamConstants.ROOT_CODE.equals(departmentCode)){
			departmentModel = new DepartmentModel();
			departmentModel.setDepartmentCode(ParamConstants.ROOT_CODE);
			departmentModel.setDepartmentName("所有部门");
			departmentModel.setAgencyCode(RequestContext.getAgencyCode());
		}else{
			Department department = departmentDAO.findByDepartmentCode(agencyCode, departmentCode);
			if(!ValidationUtil.isEmpty(department)){
				departmentModel = Bean.toModel(department, this.getModelClass().newInstance());
			}
		}
		if(!ValidationUtil.isEmpty(departmentModel)){
			buildTree(departmentModel);
		}
		return departmentModel;
	}

	/**
	 * 构造部门树
	 * @param parentDepartment
	 * @throws DAOException
	 * @throws Exception
	 */
	private void buildTree(DepartmentModel parentDepartment)
			throws Exception {
		List<Department> departments = departmentDAO.findByParentCode(parentDepartment.getAgencyCode(), parentDepartment.getDepartmentCode(), null);
		if(ValidationUtil.isEmpty(departments)){
			parentDepartment.setHasChildren(false);
		}else{
			parentDepartment.setHasChildren(true);
			parentDepartment.setChildren(Bean.toModels(departments,DepartmentModel.class));
			for(DepartmentModel model:parentDepartment.getChildren()){
				buildTree(model);
			}
		}
	}

	@Override
	public List<DepartmentModel> getDepartmentsByParentCode(String agencyCode, String parentCode) throws Exception {
		List<Department> departments = departmentDAO.findByParentCode(agencyCode, parentCode, null);
		return ValidationUtil.isEmpty(departments)?null:Bean.toModels(departments,DepartmentModel.class);
	}

	@Override
	public Page getByPage(String agencyCode, String parentCode, String departmentCode, String departmentName,
			String lockStatus, Page page, String orderBy, String order) throws Exception {
		List<Department> departmentList = departmentDAO.findByPage(agencyCode,parentCode,departmentCode,departmentName,lockStatus,page,orderBy,order);
		page.setList(ValidationUtil.isEmpty(departmentList)?null:Bean.toModels(departmentList,DepartmentModel.class));
		return page;
	}

	@Override
	public DepartmentModel createDepartment(DepartmentModel newDepartment) throws Exception {
		newDepartment.setAgencyCode(RequestContext.getAgencyCode());
		Department department = this.prepareEntity(newDepartment);
		if (ValidationUtil.isEmpty(newDepartment.getLockStatus())){
			department.setLockStatus(CoreConstants.COMMON_N);
		}
		department.setRecDate(new Date());
		department.setRecUserId(RequestContext.getExeUserId());
		departmentDAO.insert(department);
		return Bean.toModel(department, newDepartment);
	}

	@Override
	public void deleteDepartments(String agencyCode,String... departmentCodes) throws Exception {
		for(String departmentCode : departmentCodes){
			this.deleteOneDepartment(agencyCode, departmentCode);
		}
	}
	
	private void deleteOneDepartment(String agencyCode,String departmentCode) throws Exception{
		Department department = departmentDAO.findByDepartmentCode(agencyCode, departmentCode);
		if(ValidationUtil.isEmpty(department)){
			return;
		}
		String checkResult = departmentDAO.deleteCheck(new ReferenceModel(this.getTableName(),
				new String[]{"AGENCY_CODE", "PARENT_CODE"},
				new String[]{agencyCode,departmentCode},"在子部门中"));
		if(!ValidationUtil.isEmpty(checkResult)){
			throw new BusinessException(checkResult);
		}
		checkResult = departmentDAO.deleteDepartmentCheck(agencyCode,departmentCode);
		if(!ValidationUtil.isEmpty(checkResult)){
			throw new DataValidateException(checkResult);
		}
		departmentDAO.deleteWithCache(agencyCode, departmentCode);
	}

	@Override
	public DepartmentModel updateDepartment(DepartmentModel currentDepartment) throws Exception {
		if(ValidationUtil.isEmpty(currentDepartment.getAgencyCode())){
			currentDepartment.setAgencyCode(RequestContext.getAgencyCode());
		}
		Department department = departmentDAO.findByDepartmentCode(currentDepartment.getAgencyCode(), currentDepartment.getDepartmentCode());
		if(ValidationUtil.isEmpty(department)){
			return null;
		}
		Bean.copyExistPropertis(currentDepartment, department);
		department.setRecDate(new Date());
		department.setRecUserId(RequestContext.getExeUserId());
		departmentDAO.update(department);
		return Bean.toModel(department, currentDepartment);
	}

	@Override
	public DepartmentModel updateLockStatus(String agencyCode, String departmentCode) throws Exception {
		Department department = departmentDAO.findByDepartmentCode(agencyCode, departmentCode);
		if(ValidationUtil.isEmpty(department)){
			return null;
		}
		department.setLockStatus(CoreConstants.COMMON_N.equals(department.getLockStatus())?CoreConstants.COMMON_Y:CoreConstants.COMMON_N);
		department.setRecDate(new Date());
		department.setRecUserId(RequestContext.getExeUserId());
		departmentDAO.update(department);
		return Bean.toModel(department, new DepartmentModel());
	}

	@Override
	public DepartmentModel getDepartmentByCode(String agencyCode, String departmentCode) throws Exception {
		return Bean.toModel(departmentDAO.findByDepartmentCode(agencyCode, departmentCode), new DepartmentModel());
	}

	@Override
	public boolean isDepartmentCodeAvailable(String agencyCode, String departmentCode, Long id) throws Exception {
		return departmentDAO.isDepartmentCodeAvailable(agencyCode, departmentCode,id);
	}

	@Override
	public boolean isDepartmentNameAvailable(String agencyCode, String departmentName, Long id) throws Exception {
		return departmentDAO.isDepartmentNameAvailable(agencyCode, departmentName,id);
	}

	@Override
	public Map<String, Object> getByUserId(Long userId) throws Exception {
		return departmentDAO.findByUserId(userId);
	}

    @Override
    public List<DepartmentModel> getByEmployees(String agencyCode, String parentCode) throws Exception {
		List<Department> departments = departmentDAO.findByParentCode(agencyCode, parentCode, CoreConstants.COMMON_N);
		List<DepartmentModel> departmentModels = new ArrayList<>();
		if(!ValidationUtil.isEmpty(departments)){
			departmentModels = Bean.toModels(departments, DepartmentModel.class);
			List<DepartmentModel> removeDepartment = new ArrayList<>();
			//目前员工只和一级部门关联，所以这里查询一级部门及员工信息
			for (DepartmentModel departmentModel : departmentModels){
				List<Map<String, Object>> employees = employeeService.getEmployeesByDepartmentCode(departmentModel.getAgencyCode(), departmentModel.getDepartmentCode(), CoreConstants.COMMON_N);
				if(ValidationUtil.isEmpty(employees)){
					removeDepartment.add(departmentModel);
				}else{
					departmentModel.setEmployeeInfoList(employees);
				}
			}
			departmentModels.removeAll(removeDepartment);
		}
        return departmentModels;
    }
}
