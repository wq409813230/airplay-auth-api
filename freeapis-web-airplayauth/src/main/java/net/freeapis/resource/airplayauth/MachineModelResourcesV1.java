package net.freeapis.resource.airplayauth;

import net.freeapis.airplayauth.face.constants.AirplayauthConstants;
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
import net.freeapis.systemctl.face.DictionaryService;
import net.freeapis.systemctl.face.model.DictionaryEntryModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <pre>
 *
 *  freeapis
 *  File: MachineModelResourcesV1.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: MachineModelResourcesV1.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
@RestController
@RequestMapping(value = "/1/machineModel")
@FreeapisResource(module = "airplayauth", value = "MachineModelResourcesV1", description = "机型管理")
public class MachineModelResourcesV1 extends BaseResources {

    @Autowired
    private DictionaryService dictionaryService;

    @FreeapisOperation(name = "createMachineModel", ApiLevel = APILevel.SUPERADMIN, description = "创建机型")
    @RequestMapping(value = "", method = RequestMethod.POST)
    public ResponseModel<DictionaryEntryModel> createMachineModel(
            @RequestBody DictionaryEntryModel dictionaryEntryModel) throws Exception {
        return ResponseHelper.buildResponseModel(dictionaryService.createEntry(dictionaryEntryModel));
    }

    @FreeapisOperation(name = "deleteMachineModel", ApiLevel = APILevel.SUPERADMIN, description = "删除机型")
    @RequestMapping(value = "", method = RequestMethod.DELETE)
    public ResponseModel<String> deleteMachineModel(
            @RequestParam String modelCode) throws Exception {
        dictionaryService.deleteEntry(
                RequestContext.getAgencyCode(),AirplayauthConstants.DICT_CODE_MACHINE_MODEL,modelCode);
        return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
    }

    @FreeapisOperation(name = "getMachineModelById", ApiLevel = APILevel.SUPERADMIN, description = "后台根据编码查询机型")
    @RequestMapping(value = "", method = RequestMethod.GET)
    public ResponseModel<DictionaryEntryModel> getMachineModelById(
            @RequestParam String modelCode) throws Exception {
        return ResponseHelper.buildResponseModel(
                dictionaryService.getEntry(
                        RequestContext.getAgencyCode(),AirplayauthConstants.DICT_CODE_MACHINE_MODEL,modelCode)
        );
    }

    @FreeapisOperation(name = "getMachineModelByPage", ApiLevel = APILevel.SUPERADMIN, description = "后台分页获取机型信息")
    @RequestMapping(value = "/page", method = RequestMethod.GET)
    public ResponseModel<Page> getMachineModelByPage(
            @RequestParam(required = false) String modelCode,
            @RequestParam(value = ParamConstants.OFFSET,defaultValue = "0") int start,
            @RequestParam(value = ParamConstants.LENGTH,defaultValue  ="10") int length) throws Exception
    {
        Page page = new Page(length, start);
        return ResponseHelper.buildResponseModel(
                dictionaryService.queryEntryByPage(
                        RequestContext.getAgencyCode(),
                        AirplayauthConstants.DICT_CODE_MACHINE_MODEL,modelCode,page,"entryKey","asc")
        );
    }
}