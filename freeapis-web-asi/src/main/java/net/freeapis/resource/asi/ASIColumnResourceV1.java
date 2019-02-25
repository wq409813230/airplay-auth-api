package net.freeapis.resource.asi;


import net.freeapis.asi.face.ColumnTemplateService;
import net.freeapis.asi.face.GroupColumnService;
import net.freeapis.asi.face.constants.ASIConstants;
import net.freeapis.asi.face.enums.DataType;
import net.freeapis.asi.face.model.ColumnTemplateModel;
import net.freeapis.asi.face.model.GroupColumnModel;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.constants.ParamConstants;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.rest.BaseResources;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.core.rest.containers.FreeapisOperation;
import net.freeapis.core.rest.containers.FreeapisResource;
import net.freeapis.core.rest.utils.ResponseHelper;
import net.freeapis.core.rest.utils.ResponseModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: ASIColumnResourceV1.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: ASIColumnResourceV1.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年1月22日		wuqiang		Initial.
 *
 * </pre>
 */
@RestController
@RequestMapping(value = "/1/asi/columns")
@FreeapisResource(module = "asi",value = "ASIColumnResourceV1", description = "动态表单列定义管理")
public class ASIColumnResourceV1  extends BaseResources {
	
	@Autowired
	private ColumnTemplateService columnTemplateService;
	
	@Autowired
	private GroupColumnService groupColumnService;
	
	@FreeapisOperation(name = "getAllDataTypes",ApiLevel = APILevel.SUPERADMIN, description = "获取所有定义的数据类型")
    @RequestMapping(value = "/datatypes", method = RequestMethod.GET)
    public ResponseModel<List<Map<String,String>>> getAllDataTypes() throws Exception{
		List<Map<String,String>> result = new ArrayList<Map<String,String>>();
		Map<String,String> datatype = null;
		for(DataType d : DataType.values()){
			datatype = new HashMap<String,String>();
			datatype.put("name",d.description());
			datatype.put("value",d.name());
			result.add(datatype);
		}
        return ResponseHelper.buildResponseModel(result);
    }
	
    @FreeapisOperation(name = "createColumnTemplate",ApiLevel = APILevel.SUPERADMIN, description = "创建列定义模板")
    @RequestMapping(value = "/template/{agencyCode}", method = RequestMethod.POST)
    public ResponseModel<ColumnTemplateModel> createColumnTemplate(
    		@PathVariable String agencyCode,@RequestBody ColumnTemplateModel columnTemplate) throws Exception{
		columnTemplate.setAgencyCode(agencyCode);
        return ResponseHelper.buildResponseModel(columnTemplateService.createColumnTemplate(columnTemplate));
    }
    
    @FreeapisOperation(name = "deleteColumnTemplate",ApiLevel = APILevel.SUPERADMIN, description = "删除列定义模板")
    @RequestMapping(value = "/template/{agencyCode}/{columnCode}", method = RequestMethod.DELETE)
    public ResponseModel<String> deleteColumnTemplate(
    		@PathVariable String agencyCode,@PathVariable String columnCode) throws Exception{
    	 columnTemplateService.deleteColumnTemplate(agencyCode, columnCode);
    	 return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
    }
    
    @FreeapisOperation(name = "updateASIColulnMeta",ApiLevel = APILevel.SUPERADMIN, description = "更新列定义模板")
    @RequestMapping(value = "/template/{agencyCode}", method = RequestMethod.PUT)
    public ResponseModel<ColumnTemplateModel> updateASIColulnMeta(@PathVariable String agencyCode,
    		@RequestBody ColumnTemplateModel columnTemplate) throws Exception{
		columnTemplate.setAgencyCode(agencyCode);
        return ResponseHelper.buildResponseModel(columnTemplateService.updateColumnTemplate(columnTemplate));
    }
	
    @FreeapisOperation(name = "getColumnTemplate",ApiLevel = APILevel.SUPERADMIN, description = "获取列定义模板详情")
    @RequestMapping(value = "/template/{agencyCode}/{columnCode}", method = RequestMethod.GET)
    public ResponseModel<ColumnTemplateModel> getColumnTemplate(
    		@PathVariable String agencyCode,@PathVariable String columnCode) throws Exception{
        return ResponseHelper.buildResponseModel(columnTemplateService.getColumnTemplate(agencyCode, columnCode));
    }
	
    @FreeapisOperation(name = "getASIColulnMetas",ApiLevel = APILevel.SUPERADMIN, description = "分页获取列定义模板列表")
    @RequestMapping(value = "/template/{agencyCode}/page", method = RequestMethod.GET)
    public ResponseModel<Page> getASIColulnMetas(
    		@PathVariable String agencyCode,
    		@RequestParam(value = ParamConstants.OFFSET,defaultValue = "0") int start,
			@RequestParam(value = ParamConstants.LENGTH,defaultValue = "10") int length,
			@RequestParam(value = ParamConstants.SIDX, required = false) String orderBy,
			@RequestParam(value = ParamConstants.SORT, required = false) String order,
			@RequestParam(value="columnCode",required=false) String columnCode,
			@RequestParam(value="columnName",required=false) String columnName
			) throws Exception{
        return ResponseHelper.buildResponseModel(
        		columnTemplateService.getColumnTemplateByPage(
        				agencyCode, columnCode, columnName, new Page(length, start), orderBy, order));
    }
    
    @FreeapisOperation(name = "isColumnTemplateCodeAvailable",ApiLevel = APILevel.SUPERADMIN, description = "判断模板列的编码是否可用")
    @RequestMapping(value = "/template/{agencyCode}/{columnCode}/available", method = RequestMethod.GET)
    public ResponseModel<Boolean> isColumnTemplateCodeAvailable(
    		@PathVariable String agencyCode,@PathVariable String columnCode) throws Exception{
        return ResponseHelper.buildResponseModel(columnTemplateService.isColumnCodeAvailable(agencyCode, columnCode));
    }
	
    @FreeapisOperation(name = "upsertGroupColumn",ApiLevel = APILevel.AGENCY, description = "创建/更新子分组的自定义列")
    @RequestMapping(value = "/custom/{agencyCode}/{groupCode}", method = RequestMethod.POST)
    public ResponseModel<GroupColumnModel> upsertGroupColumn(
    		@PathVariable String agencyCode,
    		@PathVariable String groupCode,
    		@RequestBody GroupColumnModel groupColumn) throws Exception{
		groupColumn.setAgencyCode(agencyCode);
		groupColumn.setGroupCode(groupCode);
        Redis.removeByPrefix(ASIConstants.ASIVALUE_CACHEKEY_PREFIX);
        return ResponseHelper.buildResponseModel(groupColumnService.createGroupColumn(groupColumn));
    }

    @FreeapisOperation(name = "deleteGroupColumn",ApiLevel = APILevel.AGENCY, description = "删除子分组的自定义列")
    @RequestMapping(value = "/custom/{agencyCode}/{groupCode}/{columnCode}", method = RequestMethod.DELETE)
    public ResponseModel<String> deleteGroupColumn(
    		@PathVariable String agencyCode,
    		@PathVariable String groupCode,
    		@PathVariable String columnCode) throws Exception{
    	groupColumnService.deleteGroupColumn(agencyCode, groupCode, columnCode);
        Redis.removeByPrefix(ASIConstants.ASIVALUE_CACHEKEY_PREFIX);
        return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
    }
	
    @FreeapisOperation(name = "getGroupColumn",ApiLevel = APILevel.AGENCY, description = "获取自定义列详情")
    @RequestMapping(value = "/custom/{agencyCode}/{groupCode}/{columnCode}", method = RequestMethod.GET)
    public ResponseModel<GroupColumnModel> getGroupColumn(
    		@PathVariable String agencyCode,
    		@PathVariable String groupCode,
    		@PathVariable String columnCode) throws Exception{
        return ResponseHelper.buildResponseModel(groupColumnService.getGroupColumn(agencyCode, groupCode, columnCode));
    }
	
    @FreeapisOperation(name = "getGroupColumns",ApiLevel = APILevel.AGENCY, description = "根据子分组获取列定义列表")
    @RequestMapping(value = "/custom/{agencyCode}/{groupCode}", method = RequestMethod.GET)
    public ResponseModel<List<GroupColumnModel>> getGroupColumns(
    		@PathVariable String agencyCode,
    		@PathVariable String groupCode) throws Exception{
        return ResponseHelper.buildResponseModel(groupColumnService.getGroupColumns(agencyCode, groupCode));
    }
	
    @FreeapisOperation(name = "copyASIColumns",ApiLevel = APILevel.AGENCY, description = "将列定义模板复制到子分组中")
    @RequestMapping(value = "/custom/replication/{agencyCode}/{groupCode}", method = RequestMethod.POST)
    public ResponseModel<String> copyASIColumns(
    		@PathVariable String agencyCode,
    		@PathVariable String groupCode,
    		@RequestBody List<Map<String,String>> templates) throws Exception{
		groupColumnService.copyFromTemplate(agencyCode, groupCode,templates);
        Redis.removeByPrefix(ASIConstants.ASIVALUE_CACHEKEY_PREFIX);
        return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
    }
	
    @FreeapisOperation(name = "isGroupColumnCodeAvailable",ApiLevel = APILevel.AGENCY, description = "判断自定义列编码是否可用")
    @RequestMapping(value = "/custom/{agencyCode}/{groupCode}/{columnCode}/available", method = RequestMethod.GET)
    public ResponseModel<Boolean> isGroupColumnCodeAvailable(
    		@PathVariable String agencyCode,
    		@PathVariable String groupCode,
    		@PathVariable String columnCode) throws Exception{
        return ResponseHelper.buildResponseModel(groupColumnService.isGroupColumnCodeAvailable(agencyCode, groupCode, columnCode));
    }
}

/*
*$Log: av-env.bat,v $
*/