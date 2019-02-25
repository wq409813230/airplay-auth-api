package net.freeapis.resource.asi;


import net.freeapis.asi.face.ASIService;
import net.freeapis.asi.face.constants.ASIConstants;
import net.freeapis.asi.face.enums.ASIType;
import net.freeapis.asi.face.enums.Operator;
import net.freeapis.asi.face.model.ASIBizModel;
import net.freeapis.asi.face.model.GroupModel;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.ParamConstants;
import net.freeapis.core.foundation.exceptions.BusinessException;
import net.freeapis.core.foundation.model.Page;
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
import java.util.Map;

/**
 * &lt;pre&gt;
 * <p/>
 * freeapis
 * File: ASIResourceV1
 * PROJECT: build-generator
 * <p/>
 * freeapis, Inc.
 * Copyright (C): 2015
 * <p/>
 * Description:
 * ${todo}
 * <p/>
 * Notes:
 * $$Id: ASIResourceV1 31101200-9 2014-10-14 16:43:51Z freeapis\ Tony.Li $$
 * <p/>
 * Revision History
 * &amp;lt;Date&amp;gt;,			&amp;lt;Who&amp;gt;,			&amp;lt;What&amp;gt;
 * 2015/11/16		Tony.Li		Initial.
 * <p/>
 * &lt;/pre&gt;
 */
@RestController
@RequestMapping(value = "/1/asi")
@FreeapisResource(module = "asi",value = "ASIResourcesV1", description = "动态表单")
public class ASIResourceV1 extends BaseResources {

    @Autowired
    private ASIService asiService;

    @FreeapisOperation(name = "upsertASIBiz",ApiLevel = APILevel.AGENCY, description = "将具体的业务类型和动态表单关联")
    @RequestMapping(value = "", method = RequestMethod.PUT)
    public ResponseModel<ASIBizModel> upsertASIBiz(@RequestBody ASIBizModel asiBizModel) throws Exception
    {
        return ResponseHelper.buildResponseModel(asiService.upsertASIBiz(asiBizModel));
    }

    @FreeapisOperation(name = "updateASIForm",ApiLevel = APILevel.AGENCY, description = "更新表单类型数据")
    @RequestMapping(value = "/{agencyCode}/{entityType}/{entityId}/form", method = RequestMethod.PUT)
    public ResponseModel<Map> updateASIForm(
            @PathVariable(value = "agencyCode" )  String agencyCode,
            @PathVariable(value = "entityType") String entityType,
            @PathVariable(value = "entityId") String entityId,
            @RequestBody Map<String,Map<String, String>> formValues) throws Exception
    {
        Redis.removeByPrefix(ASIConstants.ASIVALUE_CACHEKEY_PREFIX);
        return ResponseHelper.buildResponseModel(
                asiService.updateASIData(agencyCode, entityType, entityId,null,formValues,ASIType.FORM));
    }

    @FreeapisOperation(name = "updateASITable",ApiLevel = APILevel.AGENCY, description = "更新表格类型数据")
    @RequestMapping(value = "/{agencyCode}/{entityType}/{entityId}/table", method = RequestMethod.PUT)
    public ResponseModel<Map> updateASITable(
            @PathVariable(value = "agencyCode") String agencyCode,
            @PathVariable(value = "entityType") String entityType,
            @PathVariable(value = "entityId") String entityId,
            @RequestBody Map<String, List<Map<String, String>>> tableValues) throws Exception
    {
        Redis.removeByPrefix(ASIConstants.ASIVALUE_CACHEKEY_PREFIX);
        return ResponseHelper.buildResponseModel(
                asiService.updateASIData(agencyCode, entityType, entityId,tableValues,null,ASIType.TABLE));
    }

    @FreeapisOperation(name = "getValuesForGroup",ApiLevel = APILevel.ALL,description = "获取某个具体的子分组的元数据和数据(异步根据子分组获取)")
    @RequestMapping(value = "/{agencyCode}/{groupCode}/{entityType}/{entityId}/values", method = RequestMethod.GET)
    public ResponseModel<GroupModel> getValuesForGroup(
            @PathVariable(value = "agencyCode") String agencyCode,
            @PathVariable(value = "groupCode") String groupCode,
            @PathVariable(value = "entityType") String entityType,
            @PathVariable(value = "entityId") String entityId) throws Exception
    {
        return ResponseHelper.buildResponseModel(asiService.getASIData(agencyCode, groupCode, entityType, entityId));
    }

    @FreeapisOperation(name = "getValues",ApiLevel = APILevel.ALL,description = "获取实体的动态表单数据(同步获取所有数据)")
    @RequestMapping(value = "/{agencyCode}/{groupCode}/{entityType}/{entityId}/allvalues", method = RequestMethod.GET)
    public ResponseModel<GroupModel> getValues(
            @PathVariable(value = "agencyCode") String agencyCode,
            @PathVariable(value = "groupCode") String groupCode,
            @PathVariable(value = "entityType") String entityType,
            @PathVariable(value = "entityId") String entityId) throws Exception
    {
        return ResponseHelper.buildResponseModel(asiService.getValues(agencyCode,groupCode,entityType, entityId));
    }

    @FreeapisOperation(name = "getASIMeta",ApiLevel = APILevel.ALL, description = "获取实体的元数据定义")
    @RequestMapping(value = "/{agencyCode}/{groupCode}/{entityType}/meta", method = RequestMethod.GET)
    public ResponseModel<GroupModel> getASIMeta(
            @PathVariable(value = "agencyCode") String agencyCode,
            @PathVariable(value = "groupCode") String groupCode,
            @PathVariable(value = "entityType") String entityType) throws Exception
    {
        return ResponseHelper.buildResponseModel(asiService.getASIMeta(agencyCode,groupCode,entityType));
    }

    @FreeapisOperation(name = "getDataById",ApiLevel = APILevel.ALL, description = "根据ID获取实体数据")
    @RequestMapping(value = "/{agencyCode}/{groupCode}/{entityType}/{entityId}/{mongoId}", method = RequestMethod.GET)
    public ResponseModel<GroupModel> getDataById(
            @PathVariable(value = "agencyCode") String agencyCode,
            @PathVariable(value = "groupCode") String groupCode,
            @PathVariable(value = "entityType") String entityType,
            @PathVariable(value = "entityId") String entityId,
            @PathVariable(value = "mongoId")String id)throws Exception{
        return ResponseHelper.buildResponseModel(asiService.getOne(agencyCode,entityType,entityId, groupCode, id));
    }

    @FreeapisOperation(name = "getDataByPage",ApiLevel = APILevel.ALL, description = "分页获取表格数据")
    @RequestMapping(value = "/{agencyCode}/{groupCode}/{entityType}/{entityId}/page", method = RequestMethod.GET)
    public ResponseModel<Page> getDataByPage(
            @PathVariable(value = "agencyCode") String agencyCode,
            @PathVariable(value = "groupCode") String groupCode,
            @PathVariable(value = "entityType") String entityType,
            @PathVariable(value = "entityId") String entityId,
            @RequestParam(required = true,defaultValue = "0")int start,
            @RequestParam(required = true,defaultValue = "10")int length,
            @RequestParam(required = false) String orderBy,
            @RequestParam(required = false) String order)throws Exception{
        return ResponseHelper.buildResponseModel(
                asiService.getByPage(agencyCode,entityType,entityId, groupCode,new Page(length,start),orderBy,order));
    }

    @FreeapisOperation(name = "getByPage",ApiLevel = APILevel.ALL, description = "分页获取数据")
    @RequestMapping(value = "/{agencyCode}/{groupCode}/{entityType}/{entityId}/conditionPage",method = RequestMethod.GET)
    public ResponseModel<Page> getByPage(
            @PathVariable(value = "agencyCode") String agencyCode,
            @PathVariable(value = "groupCode") String groupCode,
            @PathVariable(value = "entityType") String entityType,
            @PathVariable(value = "entityId") String entityId,
            @RequestParam(required = false) String[] fieldNames,
            @RequestParam(required = false) String[] fieldValues,
            @RequestParam(required = false) String[] operators,
            @RequestParam(value = ParamConstants.OFFSET, defaultValue = "0") int start,
            @RequestParam(value = ParamConstants.LENGTH, defaultValue = "10") int length,
            @RequestParam(value = ParamConstants.SIDX, required = false) String orderBy,
            @RequestParam(value = ParamConstants.SORT, required = false) String order)throws Exception{
        return ResponseHelper.buildResponseModel(asiService.getByPage(agencyCode,entityType,entityId, groupCode,fieldNames,
                fieldValues,operators, new Page(length,start),orderBy,order));
    }

    @FreeapisOperation(name = "getByList",ApiLevel = APILevel.ALL, description = "获取数据信息")
    @RequestMapping(value = "/{agencyCode}/{groupCode}/{entityType}/{entityId}/list", method = RequestMethod.GET)
    public ResponseModel<List<Map>> getByList(
            @PathVariable(value = "agencyCode") String agencyCode,
            @PathVariable(value = "groupCode") String groupCode,
            @PathVariable(value = "entityType") String entityType,
            @PathVariable(value = "entityId") String entityId,
            @RequestParam(required = false) String[] fieldNames,
            @RequestParam(required = false) String[] fieldValues,
            @RequestParam(required = false) String[] operators,
            @RequestParam(value = ParamConstants.SIDX, required = false) String orderBy,
            @RequestParam(value = ParamConstants.SORT, required = false) String order)throws Exception{
        return ResponseHelper.buildResponseModel(asiService.getByList(agencyCode,entityType,entityId, groupCode,fieldNames,
                fieldValues,operators,orderBy,order));
    }

    @FreeapisOperation(name = "isValueAvailable",ApiLevel = APILevel.ALL, description="判断值是否可用")
    @RequestMapping(value = "/{agencyCode}/{groupCode}/{entityType}/{entityId}/available", method = RequestMethod.GET)
    public ResponseModel<Boolean> isValueAvailable(
            @PathVariable(value = "agencyCode") String agencyCode,
            @PathVariable(value = "groupCode") String groupCode,
            @PathVariable(value = "entityType") String entityType,
            @PathVariable(value = "entityId") String entityId,
            @RequestParam(required = false) String id,
            @RequestParam String[] fieldNames,
            @RequestParam String[] fieldValues)throws Exception{
        return ResponseHelper.buildResponseModel(asiService.isValueAvailable(agencyCode,entityType,entityId, groupCode,id,fieldNames,
                fieldValues));
    }
}