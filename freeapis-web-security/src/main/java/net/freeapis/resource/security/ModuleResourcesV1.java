package net.freeapis.resource.security;

import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.rest.BaseResources;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.core.rest.containers.FreeapisOperation;
import net.freeapis.core.rest.containers.FreeapisResource;
import net.freeapis.core.rest.utils.ResponseHelper;
import net.freeapis.core.rest.utils.ResponseModel;
import net.freeapis.security.face.ModuleService;
import net.freeapis.security.face.model.ModuleModel;
import net.freeapis.security.face.model.ModuleOperationModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
 *  2016/10/26		freeapis		Initial.
 *
 * </pre>
 */
@RestController
@RequestMapping(value = "/1/modules")
@FreeapisResource(module = "security", value = "ModuleResourcesV1", description = "业务模块管理")
public class ModuleResourcesV1 extends BaseResources{

    @Autowired
    private ModuleService moduleService;

    @FreeapisOperation(name = "getModuleTree", ApiLevel = APILevel.SUPERADMIN, description = "根据商家编码获取业务模块树")
    @RequestMapping(value = "/{agencyCode}/tree", method = RequestMethod.GET)
    public ResponseModel<ModuleModel> getModuleTree(@PathVariable String agencyCode)throws Exception{
        return ResponseHelper.buildResponseModel(moduleService.buildModuleTree(agencyCode));
    }

    @FreeapisOperation(name = "getAgencyTemplateModuleTree", ApiLevel = APILevel.AGENCY, description = "获取商家模板业务模块树")
    @RequestMapping(value = "/agencyTemplate/tree", method = RequestMethod.GET)
    public ResponseModel<ModuleModel> getAgencyTemplateModuleTree()throws Exception{
        return ResponseHelper.buildResponseModel(moduleService.buildAgencyTemplateModuleTree());
    }

    @FreeapisOperation(name = "getByModuleCode", ApiLevel = APILevel.SUPERADMIN, description = "根据模块编码获取模块详细信息")
    @RequestMapping(value = "/{agencyCode}/{moduleCode}", method = RequestMethod.GET)
    public ResponseModel<ModuleModel> getByModule(@PathVariable String agencyCode,@PathVariable String moduleCode)throws Exception{
        return ResponseHelper.buildResponseModel(moduleService.getByModuleCode(agencyCode,moduleCode));
    }

    @FreeapisOperation(name = "getAllChildrenModule", ApiLevel = APILevel.SUPERADMIN, description = "根据父业务模块编码获取子业务模块")
    @RequestMapping(value = "/children", method = RequestMethod.GET)
    public ResponseModel<List<ModuleModel>> getAllChildrenModule(
            @RequestParam String agencyCode,
            @RequestParam String parentCode)throws Exception{
        return ResponseHelper.buildResponseModel(moduleService.getModulesByParentCode(agencyCode,parentCode));
    }

    @FreeapisOperation(name= "createModule", ApiLevel = APILevel.SUPERADMIN, description = "创建模块",beanValidation = true)
    @RequestMapping(value = "",method = RequestMethod.POST)
    public ResponseModel<ModuleModel> createModule(@RequestBody ModuleModel moduleModel)throws Exception{
        return ResponseHelper.buildResponseModel(moduleService.createModule(moduleModel));
    }

    @FreeapisOperation(name= "createModuleOperation", ApiLevel = APILevel.SUPERADMIN, description = "创建模块按钮",beanValidation = true)
    @RequestMapping(value = "/moduleOperation",method = RequestMethod.POST)
    public ResponseModel<ModuleOperationModel> createModuleOperation(@RequestBody ModuleOperationModel moduleOperation)throws Exception{
        return ResponseHelper.buildResponseModel(moduleService.createModuleOperation(moduleOperation));
    }

    @FreeapisOperation(name= "updateModuleOperation", ApiLevel = APILevel.SUPERADMIN, description = "修改模块按钮",beanValidation = true)
    @RequestMapping(value = "/moduleOperation/{moduleOperationId}",method = RequestMethod.PUT)
    public ResponseModel<ModuleOperationModel> updateModuleOperation(@PathVariable Long moduleOperationId,@RequestBody ModuleOperationModel moduleOperation)throws Exception{
        moduleOperation.setSequenceNBR(moduleOperationId);
        return ResponseHelper.buildResponseModel(moduleService.updateModuleOperation(moduleOperation));
    }

    @FreeapisOperation(name= "deleteModuleOperation", ApiLevel = APILevel.SUPERADMIN, description = "删除模块按钮")
    @RequestMapping(value = "/moduleOperation/{moduleOperationId}",method = RequestMethod.DELETE)
    public ResponseModel<String> deleteModuleOperation(@PathVariable Long moduleOperationId)throws Exception{
        moduleService.deleteModuleOperation(moduleOperationId);
        return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
    }

    @FreeapisOperation(name = "getModuleButtonsByPage", ApiLevel = APILevel.SUPERADMIN, description = "分页查询模块按钮")
    @RequestMapping(value = "/moduleOperation/page", method = RequestMethod.GET)
    public ResponseModel<Page> getModuleButtonsByPage(@RequestParam (required = false) String agencyCode,
                                                      @RequestParam (required = false) String moduleCode,
                                                      @RequestParam(required = false) String buttonName,
                                                      @RequestParam(required = false) String orderBy,
                                                      @RequestParam(required = false) String order,
                                                      @RequestParam(defaultValue = "0") int start,
                                                      @RequestParam(defaultValue = "15") int length)throws Exception{
        return ResponseHelper.buildResponseModel(moduleService.getModuleOperationsByPage(agencyCode,moduleCode,buttonName,new Page(length,start),orderBy,order));
    }

    @FreeapisOperation(name= "createAgencyModuleOperation", ApiLevel = APILevel.SUPERADMIN, description = "给商家端分配模块操作")
    @RequestMapping(value = "/agencyModuleOperation",method = RequestMethod.POST)
    public ResponseModel<String> createAgencyModuleOperation(@RequestBody ModuleModel moduleModel)throws Exception{
        moduleService.createAgencyModuleAndOperation(moduleModel);
        return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
    }

    @FreeapisOperation(name = "isOperationButtonCodeAvailable", ApiLevel = APILevel.SUPERADMIN, description = "判断模块关联的按钮编码是否唯一")
    @RequestMapping(value = "/moduleOperation/buttonCode/available", method = RequestMethod.GET)
    public ResponseModel<Boolean> isOperationButtonCodeAvailable(
            @RequestParam String agencyCode,
            @RequestParam String moduleCode,
            @RequestParam String buttonCode,
            @RequestParam(required = false) Long id)throws Exception{
        return ResponseHelper.buildResponseModel(moduleService.isOperationButtonCodeAvailable(agencyCode,moduleCode,buttonCode,id));
    }

    @FreeapisOperation(name = "updateModule", ApiLevel = APILevel.SUPERADMIN, description = "更新模块信息")
    @RequestMapping(value = "/{agencyCode}/{moduleCode}", method = RequestMethod.PUT)
    public ResponseModel<ModuleModel> updateModule(@PathVariable String agencyCode,
                                                   @PathVariable String moduleCode,
                                                   @RequestBody ModuleModel moduleModel)throws Exception{
        moduleModel.setModuleCode(moduleCode);
        return ResponseHelper.buildResponseModel(moduleService.updateModule(agencyCode,moduleModel));
    }

    @FreeapisOperation(name = "deleteModule", ApiLevel = APILevel.SUPERADMIN, description = "删除模块")
    @RequestMapping(value = "/{agencyCode}", method = RequestMethod.DELETE)
    public ResponseModel<String> deleteModule(@PathVariable String agencyCode,@RequestBody String[] moduleCodes)throws Exception{
        moduleService.deleteModules(agencyCode,moduleCodes);
        return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
    }

    @FreeapisOperation(name = "isModuleCodeAvailable", ApiLevel = APILevel.SUPERADMIN, description = "判断模块code是否唯一")
    @RequestMapping(value = "/moduleCode/available", method = RequestMethod.GET)
    public ResponseModel<Boolean> isModuleCodeAvailable(
            @RequestParam String agencyCode,
            @RequestParam String moduleCode,
            @RequestParam(required = false) Long id)throws Exception{
        return ResponseHelper.buildResponseModel(moduleService.isModuleCodeAvailable(agencyCode,moduleCode,id));
    }

}
