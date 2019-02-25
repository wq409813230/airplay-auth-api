package net.freeapis.resource.agency;

import ch.qos.logback.core.CoreConstants;
import net.freeapis.agency.face.DepartmentService;
import net.freeapis.agency.face.model.DepartmentModel;
import net.freeapis.core.foundation.constants.ParamConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.rest.BaseResources;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.core.rest.containers.FreeapisOperation;
import net.freeapis.core.rest.containers.FreeapisResource;
import net.freeapis.core.rest.utils.ResponseHelper;
import net.freeapis.core.rest.utils.ResponseModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <pre>
 * 
 *  freeapis
 *  File: AgencyResourceV1.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:部门信息管理
 *  TODO
 * 
 *  Notes:
 * 	$Id: AgencyResourceV1.java 31101200-9 2015年1月13日 freeapis\zhaoqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年1月13日		zhaoqiang		Initial.
 *  @author gaoyuanteng@zhaotai.ren
 * </pre>
 */
@RestController
@RequestMapping(value = "/1/departments")
@FreeapisResource(module = "agency",value = "DepartmentResourceV1", description = "部门信息管理")
public class DepartmentResourceV1 extends BaseResources
{
	@Autowired
	DepartmentService departmentService;
	
	@FreeapisOperation(name = "getDepartmentTree", ApiLevel = APILevel.AGENCY,  description = "获取当前机构部门树。")
	@RequestMapping(value = "/tree", method = RequestMethod.GET)
	public ResponseModel<DepartmentModel> getDepartmentTree(
			@RequestParam(value = "parentCode", required = true, defaultValue = ParamConstants.ROOT_CODE) String parentCode) throws Exception{
			return ResponseHelper.buildResponseModel(departmentService.buildDepartmentTree(RequestContext.getAgencyCode(), parentCode));
	}

	@FreeapisOperation(name = "getAllChildrenDepartments", ApiLevel = APILevel.AGENCY,  description = "获取所有的子部门。")
	@RequestMapping(value = "/{departmentCode}/children", method = RequestMethod.GET)
	public ResponseModel<List<DepartmentModel>> getAllChildrenDepartments(
			@PathVariable String departmentCode) throws Exception
	{
		return ResponseHelper.buildResponseModel(departmentService.getDepartmentsByParentCode(RequestContext.getAgencyCode(), departmentCode));
	}

	@FreeapisOperation(name = "getDepartments", ApiLevel = APILevel.AGENCY,  description = "分页查询部门信息(列表结构)。")
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public ResponseModel<Page> getDepartments(
			@RequestParam(value = "parentCode", required = false) String parentCode,
			@RequestParam(value = "departmentCode", required = false) String departmentCode,
			@RequestParam(value = "departmentName", required = false) String departmentName,
			@RequestParam(value = "lockStatus", required = false) String lockStatus,
			@RequestParam(value = ParamConstants.OFFSET) int start,
			@RequestParam(value = ParamConstants.LENGTH) int length,
			@RequestParam(value = ParamConstants.SIDX, required = false) String orderBy,
			@RequestParam(value = ParamConstants.SORT, required = false) String order) throws Exception
	{
		return ResponseHelper.buildResponseModel(
				departmentService.getByPage(
						RequestContext.getAgencyCode(),parentCode, departmentCode,departmentName, lockStatus,new Page(length,start) , orderBy, order));
	}

	@FreeapisOperation(name = "createDepartment", ApiLevel = APILevel.AGENCY,  description = "创建部门信息。",beanValidation = true)
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseModel<DepartmentModel> createDepartment(@RequestBody DepartmentModel departmentModel) throws Exception
	{
		return ResponseHelper.buildResponseModel(departmentService.createDepartment(departmentModel));
	}

	@FreeapisOperation(name = "deleteDepartment", ApiLevel = APILevel.AGENCY,  description = "删除部门。")
	@RequestMapping(value = "", method = RequestMethod.DELETE)
	public ResponseModel<String> deleteDepartment(@RequestBody String[] departmentCodes) throws Exception
	{
		departmentService.deleteDepartments(RequestContext.getAgencyCode(),departmentCodes);
		return ResponseHelper.buildResponseModel(CoreConstants.SUPPRESSED);
	}

	@FreeapisOperation(name = "updateDepartment", ApiLevel = APILevel.AGENCY,  description = "更新部门信息。",beanValidation = true)
	@RequestMapping(value = "/{departmentCode}", method = RequestMethod.PUT)
	public ResponseModel<DepartmentModel> updateDepartment(@PathVariable String departmentCode,@RequestBody DepartmentModel departmentModel)throws Exception
	{
		departmentModel.setDepartmentCode(departmentCode);
		return ResponseHelper.buildResponseModel(departmentService.updateDepartment(departmentModel));
	}
	
	@FreeapisOperation(name = "updatelockStatus", ApiLevel = APILevel.AGENCY, description = "修改锁定状态。")
	@RequestMapping(value = "/{departmentCode}/lockstatus", method = RequestMethod.PUT)
	public ResponseModel<DepartmentModel> updatelockStatus(@PathVariable String departmentCode)throws Exception
	{
		return ResponseHelper.buildResponseModel(departmentService.updateLockStatus(RequestContext.getAgencyCode(), departmentCode));
	}
	
	@FreeapisOperation(name = "getDepartment", ApiLevel = APILevel.AGENCY,  description = "根据code获取部门信息。")
	@RequestMapping(value = "/{departmentCode}", method = RequestMethod.GET)
	public ResponseModel<DepartmentModel> getDepartment(@PathVariable String departmentCode) throws Exception
	{
		return ResponseHelper.buildResponseModel(departmentService.getDepartmentByCode(RequestContext.getAgencyCode(), departmentCode));
	}

	@FreeapisOperation(name = "isDepartmentNameAvailable", ApiLevel = APILevel.AGENCY,  description = "判断部门名称是否可用。")
	@RequestMapping(value = "/departmentName/available", method = RequestMethod.GET)
	public ResponseModel<Boolean> isDepartmentNameAvailable(
			@RequestParam String departmentName,
			@RequestParam(required=false) Long id)throws Exception {
		return ResponseHelper.buildResponseModel(departmentService.isDepartmentNameAvailable(RequestContext.getAgencyCode(), departmentName,id));
	}

	@FreeapisOperation(name = "isDepartmentNameAvailable", ApiLevel = APILevel.AGENCY,  description = "判断部门编码是否可用。")
	@RequestMapping(value = "/departmentCode/available", method = RequestMethod.GET)
	public ResponseModel<Boolean> isDepartmentCodeAvailable(
			@RequestParam String departmentCode,
			@RequestParam(required=false) Long id) throws Exception
	{
		return ResponseHelper.buildResponseModel(departmentService.isDepartmentCodeAvailable(RequestContext.getAgencyCode(), departmentCode,id));
	}

	@FreeapisOperation(name = "getByEmployees", ApiLevel = APILevel.AGENCY, description = "根据一级部门获取员工信息")
	@RequestMapping(value = "/withEmployee", method = RequestMethod.GET)
	public ResponseModel<List<DepartmentModel>> getByEmployees(
			@RequestParam(value = "parentCode", required = true, defaultValue = ParamConstants.ROOT_CODE) String parentCode) throws Exception{
		return ResponseHelper.buildResponseModel(departmentService.getByEmployees(RequestContext.getAgencyCode(), parentCode));
	}

}

/*
 * $Log: av-env.bat,v $
 */