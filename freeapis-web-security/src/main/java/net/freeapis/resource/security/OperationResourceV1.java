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
import net.freeapis.security.face.OperationService;
import net.freeapis.security.face.model.OperationModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: OperationResourceV1.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: OperationResourceV1.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月21日		freeapis		Initial.
 *
 * </pre>
 */
@RestController
@RequestMapping(value = "/1/operations")
@FreeapisResource(module = "security",value = "OperationResourceV1", description = "平台资源操作管理")
public class OperationResourceV1 extends BaseResources
{
	@Autowired
	OperationService operationService;

	@FreeapisOperation(name = "createSecurityResource", ApiLevel = APILevel.SUPERADMIN,  description = "创建单个的资源操作信息",beanValidation = true)
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseModel<OperationModel> createResource(@RequestBody OperationModel resourceModel) throws Exception
	{
		resourceModel = operationService.createOperation(resourceModel);
		return ResponseHelper.buildResponseModel(resourceModel);
	}

	@FreeapisOperation(name = "updateOperation", ApiLevel = APILevel.SUPERADMIN,  description = "根据ID查询系统资源操作")
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseModel<OperationModel> updateOperation(@PathVariable Long id) throws Exception
	{
		OperationModel operationModel = operationService.get(id);
		return ResponseHelper.buildResponseModel(operationModel);
	}

	@FreeapisOperation(name = "getAllOperations", ApiLevel = APILevel.SUPERADMIN,description = "获取系统所有资源操作")
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ResponseModel<List<Object>> getAllOperations() throws Exception
	{
		List<Object> returnList = operationService.getAllOperations();
		return ResponseHelper.buildResponseModel(returnList);
	}

	@FreeapisOperation(name = "deleteResources", ApiLevel = APILevel.SUPERADMIN,  description = "删除系统资源操作")
	@RequestMapping(value = "", method = RequestMethod.DELETE)
	public ResponseModel<String> deleteResources(@RequestBody Long[] ids) throws Exception
	{
		operationService.deleteOperations(ids);
		return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
	}

	@FreeapisOperation(name = "updateOperation", ApiLevel = APILevel.SUPERADMIN,  description = "修改系统资源操作")
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public ResponseModel<OperationModel> updateOperation(@PathVariable Long id,@RequestBody OperationModel operationModel) throws Exception
	{
		operationModel.setSequenceNBR(id);
		operationModel = operationService.updateOperation(operationModel);
		return ResponseHelper.buildResponseModel(operationModel);
	}

	@FreeapisOperation(name = "isFuncIdAvailable", ApiLevel = APILevel.AGENCY, description = "判断资源FID否唯一")
	@RequestMapping(value = "/funcId/available", method = RequestMethod.GET)
	public ResponseModel<Boolean> isFuncIdAvailable(
			@RequestParam String funcId,
			@RequestParam(required = false) Long id)throws Exception{
		return ResponseHelper.buildResponseModel(operationService.isFuncIdAvailable(funcId,id));
	}

	@FreeapisOperation(name = "getForPage", ApiLevel = APILevel.AGENCY, description = "分页获取资源列表")
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public ResponseModel<Page> getForPage(
			@RequestParam(value = "resourceName",required = false) String resourceName,
			@RequestParam(value = ParamConstants.OFFSET,defaultValue = "0") int start,
			@RequestParam(value = ParamConstants.LENGTH,defaultValue = "10") int length,
			@RequestParam(value = ParamConstants.SIDX,required = false) String orderBy,
			@RequestParam(value = ParamConstants.SORT,required = false) String order) throws Exception{
		Page page = new Page(length,start);
		return ResponseHelper.buildResponseModel(operationService.getForPage(resourceName,page,orderBy,order));
	}

}
/*
 * $Log: av-env.bat,v $
 */