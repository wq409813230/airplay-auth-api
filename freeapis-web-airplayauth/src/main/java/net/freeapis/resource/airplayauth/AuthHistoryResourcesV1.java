package net.freeapis.resource.airplayauth;

import net.freeapis.airplayauth.face.AuthHistoryService;
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

/**
 * <pre>
 *
 *  freeapis
 *  File: AuthHistoryResourcesV1.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: AuthHistoryResourcesV1.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
@RestController
@RequestMapping(value = "/1/authHistory")
@FreeapisResource(module = "airplayauth", value = "AuthHistoryResourcesV1", description = "认证历史记录管理")
public class AuthHistoryResourcesV1 extends BaseResources {

    @Autowired
    private AuthHistoryService authHistoryService;

    @FreeapisOperation(name = "getAuthHistoryByPage", ApiLevel = APILevel.SUPERADMIN, description = "后台分页获取认证历史记录信息")
    @RequestMapping(value = "/manage/page", method = RequestMethod.GET)
    public ResponseModel<Page> getAuthHistoryByPage(
            @RequestParam(required = false) String machineModel,
            @RequestParam(required = false) String companyName,
            @RequestParam(value = ParamConstants.OFFSET,defaultValue = "0") int start,
            @RequestParam(value = ParamConstants.LENGTH,defaultValue  ="10") int length) throws Exception
    {
        Page page = new Page(length, start);
        return ResponseHelper.buildResponseModel(authHistoryService.getByPage(machineModel,companyName,page));
    }

    @FreeapisOperation(name = "deleteByDeviceMac", ApiLevel = APILevel.SUPERADMIN, description = "delete auth history by device mac")
    @RequestMapping(value = "/deviceMac/{deviceMac}", method = RequestMethod.DELETE)
    public ResponseModel<String> deleteByDeviceMac(@PathVariable String deviceMac) throws Exception
    {
        authHistoryService.deleteByDeviceMac(deviceMac);
        return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
    }
}