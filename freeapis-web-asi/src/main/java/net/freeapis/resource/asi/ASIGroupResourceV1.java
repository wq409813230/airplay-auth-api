package net.freeapis.resource.asi;


import net.freeapis.asi.face.GroupService;
import net.freeapis.asi.face.constants.ASIConstants;
import net.freeapis.asi.face.model.GroupModel;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.exceptions.BusinessException;
import net.freeapis.core.foundation.utils.ValidationUtil;
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
 * &lt;pre&gt;
 * <p/>
 * freeapis
 * File: ASIGroupResourceV1
 * PROJECT: build-generator
 * <p/>
 * freeapis, Inc.v 
 * Copyright (C): 2015
 * <p/>
 * Description:
 * ${todo}
 * <p/>
 * Notes:
 * $$Id: ASIGroupResourceV1 31101200-9 2014-10-14 16:43:51Z freeapis\ Tony.Li $$
 * <p/>
 * Revision History
 * &amp;lt;Date&amp;gt;,			&amp;lt;Who&amp;gt;,			&amp;lt;What&amp;gt;
 * 2015/11/16		Tony.Li		Initial.
 * <p/>
 * &lt;/pre&gt;
 */
@RestController
@RequestMapping(value = "/1/asi/groups")
@FreeapisResource(module = "asi",value = "ASIGroupResourceV1", description = "动态表单组管理")
public class ASIGroupResourceV1 extends BaseResources {

    @Autowired
    private GroupService groupService;

    @FreeapisOperation(name = "createGroup",ApiLevel = APILevel.AGENCY, description = "创建组定义")
    @RequestMapping(value = "/{agencyCode}", method = RequestMethod.POST)
    public ResponseModel<GroupModel> createGroup(@PathVariable String agencyCode,@RequestBody GroupModel groupModel) throws Exception{
    	groupModel.setAgencyCode(agencyCode);
        Redis.removeByPrefix(ASIConstants.ASIVALUE_CACHEKEY_PREFIX);
        return ResponseHelper.buildResponseModel(groupService.createGroup(groupModel));
    }
    
    @FreeapisOperation(name = "deleteGroup",ApiLevel = APILevel.AGENCY, description = "删除组定义")
    @RequestMapping(value = "/{agencyCode}/{groupCode}", method = RequestMethod.DELETE)
    public ResponseModel<GroupModel> deleteGroup(@PathVariable String agencyCode,@PathVariable String groupCode)
					throws Exception{
    	String msg = groupService.deleteGroup(agencyCode, groupCode);
    	if(!ValidationUtil.isEmpty(msg)){
            throw new BusinessException(msg);
    	}
        Redis.removeByPrefix(ASIConstants.ASIVALUE_CACHEKEY_PREFIX);
		return ResponseHelper.buildResponseModel(groupService.buildGruopTree(agencyCode,ASIConstants.ROOT_GROUP_CODE));
    }
    
	@FreeapisOperation(name = "updateGroup",ApiLevel = APILevel.AGENCY, description = "更新组定义")
    @RequestMapping(value = "/{agencyCode}", method = RequestMethod.PUT)
    public ResponseModel<GroupModel> updateGroup(@PathVariable String agencyCode,@RequestBody GroupModel groupModel) throws Exception{
    	groupModel.setAgencyCode(agencyCode);
        Redis.removeByPrefix(ASIConstants.ASIVALUE_CACHEKEY_PREFIX);
        return ResponseHelper.buildResponseModel(groupService.updateGroup(groupModel));
    }
    
	@FreeapisOperation(name = "getGroup",ApiLevel = APILevel.AGENCY, description = "获取组定义详情")
    @RequestMapping(value = "/{agencyCode}/{groupCode}", method = RequestMethod.GET)
    public ResponseModel<GroupModel> getGroup(@PathVariable String agencyCode,@PathVariable String groupCode) throws Exception{
        return ResponseHelper.buildResponseModel(groupService.getGroup(agencyCode, groupCode));
    }
    
	@FreeapisOperation(name = "syncGroupTree",ApiLevel = APILevel.ALL, description = "同步获取分组树",limitRequest = false,needAuth = false)
    @RequestMapping(value = "/{agencyCode}/tree", method = RequestMethod.GET)
    public ResponseModel<GroupModel> syncGroupTree(
            @PathVariable String agencyCode,
            @RequestParam(value = "parentCode",required = true,defaultValue = ASIConstants.ROOT_GROUP_CODE) String parentCode) throws Exception{
		return ResponseHelper.buildResponseModel(groupService.buildGruopTree(agencyCode,parentCode));
    }
	
	@FreeapisOperation(name = "getGroupList",ApiLevel = APILevel.ALL, description = "根据父分组编码获取分组列表")
    @RequestMapping(value = "/{agencyCode}/list", method = RequestMethod.GET)
    public ResponseModel<List<GroupModel>> getGroupList(@PathVariable String agencyCode,
			@RequestParam(value = "parentCode",required = true,defaultValue = ASIConstants.ROOT_GROUP_CODE) String parentCode) 
					throws Exception{
		return ResponseHelper.buildResponseModel(groupService.getGroupsByParentCode(agencyCode, parentCode));
    }
	
	@FreeapisOperation(name = "isGroupCodeAvailable",ApiLevel = APILevel.AGENCY, description = "判断分组编码是否可用")
    @RequestMapping(value = "/{agencyCode}/available", method = RequestMethod.GET)
    public ResponseModel<Boolean> isGroupCodeAvailable(@PathVariable String agencyCode,@RequestParam(value = "groupCode") String groupCode) throws Exception{
        return ResponseHelper.buildResponseModel(groupService.isGroupCodeAvailable(agencyCode, groupCode));
    }
    
}


