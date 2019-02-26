package net.freeapis.resource.airplayauth;

import net.freeapis.core.foundation.constants.ParamConstants;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.rest.BaseResources;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.core.rest.containers.FreeapisOperation;
import net.freeapis.core.rest.containers.FreeapisResource;
import net.freeapis.core.rest.utils.ResponseHelper;
import net.freeapis.core.rest.utils.ResponseModel;
import net.freeapis.airplayauth.face.AuthHistoryService;
import net.freeapis.airplayauth.face.model.AuthHistoryModel;
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
@FreeapisResource(module = "airplayauth", value = "AuthHistoryResourcesV1", description = "[AuthHistory]管理")
public class AuthHistoryResourcesV1 extends BaseResources {

    @Autowired
    private AuthHistoryService authHistoryService;

    @FreeapisOperation(name = "createAuthHistory", ApiLevel = APILevel.SUPERADMIN, description = "创建[AuthHistory]", beanValidation = true)
    @RequestMapping(value = "", method = RequestMethod.POST)
    public ResponseModel<AuthHistoryModel> createAuthHistory(
            @RequestBody AuthHistoryModel authHistoryModel) throws Exception {
        return ResponseHelper.buildResponseModel(authHistoryService.createAuthHistory(authHistoryModel));
    }

    @FreeapisOperation(name = "deleteAuthHistory", ApiLevel = APILevel.SUPERADMIN, description = "删除$[AuthHistory]")
    @RequestMapping(value = "", method = RequestMethod.DELETE)
    public ResponseModel<String> deleteAuthHistory(
            @RequestBody Long[] ids) throws Exception {
        return ResponseHelper.buildResponseModel(authHistoryService.delete(ids));
    }

    @FreeapisOperation(name = "updateAuthHistory", ApiLevel = APILevel.SUPERADMIN, description = "修改[AuthHistory]",beanValidation = true)
    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    public ResponseModel<AuthHistoryModel> updateAuthHistory(
            @PathVariable Long id,
            @RequestBody AuthHistoryModel authHistoryModel) throws Exception {
        authHistoryModel.setSequenceNBR(id);
        return ResponseHelper.buildResponseModel(authHistoryService.updateAuthHistory(authHistoryModel));
    }

    @FreeapisOperation(name = "getAuthHistoryById", ApiLevel = APILevel.SUPERADMIN, description = "后台根据ID查询$[AuthHistory]")
    @RequestMapping(value = "/manage/{id}", method = RequestMethod.GET)
    public ResponseModel<AuthHistoryModel> getAuthHistoryById(
            @PathVariable Long id) throws Exception {
        return ResponseHelper.buildResponseModel(authHistoryService.get(id));
    }

    @FreeapisOperation(name = "getProfileById", ApiLevel = APILevel.ALL, description = "根据ID查询$[AuthHistory]简要信息")
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ResponseModel<AuthHistoryModel> getProfileById(
            @PathVariable Long id) throws Exception {
        return ResponseHelper.buildResponseModel(authHistoryService.get(id));
    }

    @FreeapisOperation(name = "getAuthHistoryByPage", ApiLevel = APILevel.SUPERADMIN, description = "后台分页获取$[AuthHistory]信息")
    @RequestMapping(value = "/manage/page", method = RequestMethod.GET)
    public ResponseModel<Page> getAuthHistoryByPage(
            @RequestParam(value = ParamConstants.OFFSET,defaultValue = "0") int start,
            @RequestParam(value = ParamConstants.LENGTH,defaultValue  ="10") int length) throws Exception
    {
        Page page = new Page(length, start);
        return ResponseHelper.buildResponseModel(authHistoryService.getByPage(page));
    }
}