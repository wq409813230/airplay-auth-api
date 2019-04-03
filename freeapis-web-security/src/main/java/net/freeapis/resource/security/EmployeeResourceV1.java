package net.freeapis.resource.security;

import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.constants.ParamConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.rest.BaseResources;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.core.rest.containers.FreeapisOperation;
import net.freeapis.core.rest.containers.FreeapisResource;
import net.freeapis.core.rest.utils.ResponseHelper;
import net.freeapis.core.rest.utils.ResponseModel;
import net.freeapis.security.face.EmployeeService;
import net.freeapis.security.face.SecurityService;
import net.freeapis.security.face.model.EmployeeModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;


@RestController
@RequestMapping(value = "/1/employees")
@FreeapisResource(module = "employee",value = "EmployeeResourceV1", description = "员工管理")
public class EmployeeResourceV1 extends BaseResources {

	@Autowired
	private EmployeeService employeeService;

	@Autowired
	private SecurityService securityService;
	
	@FreeapisOperation(name = "createEmployee", ApiLevel = APILevel.AGENCY, description = "新增员工信息",beanValidation = true)
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseModel<EmployeeModel> createEmployee(@RequestBody EmployeeModel employeeModel) throws Exception
	{
			return ResponseHelper.buildResponseModel(employeeService.createEmployee(employeeModel));
	}
	
	
	@FreeapisOperation(name = "updateEmployee", ApiLevel = APILevel.AGENCY, description = "编辑员工信息")
	@RequestMapping(value = "/{userId}", method = RequestMethod.PUT)
	public ResponseModel<EmployeeModel> updateEmployee(@PathVariable Long userId,@RequestBody EmployeeModel employeeModel) throws Exception
	{
		employeeModel.setUserId(userId);
		return ResponseHelper.buildResponseModel(employeeService.updateEmployee(employeeModel));
	}
	
	@FreeapisOperation(name = "getEmployeeDetail", ApiLevel = APILevel.AGENCY, description = "获取员工信息详情")
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseModel<EmployeeModel> getEmployeeDetail(@PathVariable Long id) throws Exception
	{
		return ResponseHelper.buildResponseModel(employeeService.getEmployee(id));
	}
	
	@FreeapisOperation(name = "isEmployeeCodeUnique", ApiLevel = APILevel.AGENCY, description = "验证工号是否可用")
	@RequestMapping(value = "/available", method = RequestMethod.GET)
	public ResponseModel<Boolean> isEmployeeCodeUnique(@RequestParam String employeeCode) throws Exception
	{
		return ResponseHelper.buildResponseModel(employeeService.isEmployeeCodeAvailable(RequestContext.getAgencyCode(),employeeCode));
	}
	
	@FreeapisOperation(name = "updateLockStatus", ApiLevel = APILevel.AGENCY, description = "启用/禁用员工")
	@RequestMapping(value = "/{userId}/lockStatus", method = RequestMethod.PUT)
	public ResponseModel<EmployeeModel> updateLockStatus(@PathVariable Long userId) throws Exception
	{
		return ResponseHelper.buildResponseModel(employeeService.updateLockStatus(userId));
	}
	
	@FreeapisOperation(name = "getEmployeeForPage", ApiLevel = APILevel.AGENCY, description = "分页获取员工信息")
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public ResponseModel<Page> getEmployeeForPage(
			@RequestParam(value = "departmentCode",required=false) String departmentCode,
			@RequestParam(value = "userName",required = false) String userName,
			@RequestParam(value = "employeeCode",required = false) String employeeCode,
			@RequestParam(value = ParamConstants.OFFSET,defaultValue = "0") int start,
			@RequestParam(value = ParamConstants.LENGTH,defaultValue  ="10") int length,
			@RequestParam(value = ParamConstants.SIDX, required = false) String orderby,
			@RequestParam(value = ParamConstants.SORT, required = false) String order) throws Exception
	{
		Page page = new Page(length, start);
		page = employeeService.getByPage(RequestContext.getAgencyCode(), departmentCode, userName, employeeCode, page,orderby, order);
		return ResponseHelper.buildResponseModel(page);
	}
	
	@FreeapisOperation(name = "updateEmployeePassword", ApiLevel = APILevel.AGENCY,  description = "员工修改密码")
	@RequestMapping(value = "/password", method = RequestMethod.PUT)
	public ResponseModel<String> updatePublicUserPassword(@RequestBody EmployeeModel employeeModel) throws Exception{
		employeeService.updatePasswordBySelf(employeeModel);
		return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
	}

	@FreeapisOperation(name = "getBrieflyEmployee", ApiLevel = APILevel.SUPERADMIN, description = "获取员工简要信息")
	@RequestMapping(value = "/brieflyEmployee", method = RequestMethod.GET)
	public ResponseModel<List<Map<String,String>>> getEmployeeForPage() throws Exception
	{
		return ResponseHelper.buildResponseModel(employeeService.getBrieflyEmployee());
	}

	@FreeapisOperation(name = "getBrieflyEmployeeByParam", ApiLevel = APILevel.AGENCY, description = "获取员工简要信息(条件查询)")
	@RequestMapping(value = "/brieflyEmployee/by/param", method = RequestMethod.GET)
	public ResponseModel<List<Map<String,Object>>> getBrieflyEmployeeByParam(@RequestParam(required=false) String roleCode) throws Exception
	{
		return ResponseHelper.buildResponseModel(employeeService.getBrieflyEmployee(roleCode));
	}

	@FreeapisOperation(name = "updateEmployeePassword", ApiLevel = APILevel.SUPERADMIN, description = "重置员工密码")
	@RequestMapping(value = "/reset/{userId}", method = RequestMethod.PUT)
	public ResponseModel<String> updateEmployeePassword(@PathVariable Long userId) throws Exception
	{
		securityService.resetPassword(userId);
		return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
	}
}
