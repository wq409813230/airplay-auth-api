package net.freeapis.resource.security;


import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.rest.BaseResources;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.core.rest.containers.FreeapisOperation;
import net.freeapis.core.rest.containers.FreeapisResource;
import net.freeapis.core.rest.utils.ResponseHelper;
import net.freeapis.core.rest.utils.ResponseModel;
import net.freeapis.security.face.PermissionService;
import net.freeapis.security.face.RoleService;
import net.freeapis.security.face.model.ModuleModel;
import net.freeapis.security.face.model.PrimarySecurityModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 *
 * <pre>
 *
 *  freeapis
 *  File: RoleResourceV1.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: RoleResourceV1.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月21日		freeapis		Initial.
 *
 * </pre>
 */
@RestController
@RequestMapping(value = "/1/permissions")
@FreeapisResource(module = "security",value = "PermissionResourceV1", description = "系统权限管理")
public class PermissionResourceV1 extends BaseResources {

	@Autowired
	PermissionService permissionService;

	@Autowired
	RoleService roleService;

	@FreeapisOperation(name = "getUserModuleTree", ApiLevel = APILevel.AGENCY, description = "获取用户模块树")
	@RequestMapping(value = "/userModuleTree", method = RequestMethod.GET)
	public ResponseModel<ModuleModel> getUserModuleTree() throws Exception {
		ModuleModel moduleModel = permissionService.getCurrentUserModuleTree();
		return ResponseHelper.buildResponseModel(moduleModel);
	}

	@FreeapisOperation(name = "getSysPrivilegeTree", ApiLevel = APILevel.AGENCY, description = "获取当前商家所有模块按钮资源")
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ResponseModel<List<ModuleModel>> getSysPrivilegeTree() throws Exception {
		List<ModuleModel> moduleModelList = permissionService.getModelOperations(RequestContext.getAgencyCode());
		return ResponseHelper.buildResponseModel(moduleModelList);
	}

	@FreeapisOperation(name = "getPrimaryPermissions", ApiLevel = APILevel.AGENCY, description = "获取权限主体模块资源树")
	@RequestMapping(value = "/{primaryType}/{primaryCode}", method = RequestMethod.GET)
	public ResponseModel<List<Object>> getPrimaryPermissions(@PathVariable String primaryType,@PathVariable String primaryCode) throws Exception {
		List<Object> moduleFidList = permissionService.getPrimaryPermissions(RequestContext.getAgencyCode(),primaryType,primaryCode);
		return ResponseHelper.buildResponseModel(moduleFidList);
	}

	@FreeapisOperation(name = "createOrUpdatePermission", ApiLevel = APILevel.AGENCY, description = "创建主体权限信息")
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseModel<PrimarySecurityModel> createOrUpdatePermission(@RequestBody PrimarySecurityModel primarySecurityModel) throws Exception {
		primarySecurityModel.setAgencyCode(RequestContext.getAgencyCode());
		return ResponseHelper.buildResponseModel(permissionService.createPermission(primarySecurityModel));
	}

	@FreeapisOperation(name = "getCurrentUserModuleButtons", ApiLevel = APILevel.AGENCY, description = "获取当前登录用户所有模块的按钮信息")
	@RequestMapping(value = "/module/operations", method = RequestMethod.GET)
	public ResponseModel<Map<String,Set<String>>> getCurrentUserModuleButtons() throws Exception {
		Map<String,Set<String>> buttons = permissionService.getCurrentUserModuleButtons();
		return ResponseHelper.buildResponseModel(buttons);
	}
}