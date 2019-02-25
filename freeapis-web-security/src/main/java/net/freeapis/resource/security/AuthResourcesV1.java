package net.freeapis.resource.security;


import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.enumeration.UserType;
import net.freeapis.core.rest.BaseResources;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.core.rest.containers.FreeapisOperation;
import net.freeapis.core.rest.containers.FreeapisResource;
import net.freeapis.core.rest.utils.ResponseHelper;
import net.freeapis.core.rest.utils.ResponseModel;
import net.freeapis.security.face.SecurityService;
import net.freeapis.security.face.enums.AuthType;
import net.freeapis.security.face.enums.IdType;
import net.freeapis.security.face.model.AuthRequestModel;
import net.freeapis.security.face.model.UserSession;
import net.freeapis.systemctl.face.DictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * <pre>
 *
 *  freeapis
 *  File: AuthResourcesV1.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: AuthResourcesV1.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月21日		freeapis		Initial.
 *
 * </pre>
 */
@RestController
@RequestMapping(value = "/1/authentication")
@FreeapisResource(module = "security", value = "AuthResourcesV1", description = "系统用户认证")
public class AuthResourcesV1 extends BaseResources {
    @Autowired
    private SecurityService securityService;

    @Autowired
    private DictionaryService dictionaryService;

    @FreeapisOperation(name = "authAnonymous", ApiLevel = APILevel.ALL, description = "匿名用户登录", needAuth = false)
    @RequestMapping(value = "/anonymous", method = RequestMethod.POST)
    public ResponseModel<Map<String, Object>> authAnonymous(@RequestBody AuthRequestModel authModel) throws Exception {
        authModel.setAgency(CoreConstants.CODE_SUPER_ADMIN);
        return createSession(IdType.mobile, AuthType.userNamePassword, UserType.ANONYMOUS, authModel);
    }

    @FreeapisOperation(name = "authSuperAdmin", ApiLevel = APILevel.SUPERADMIN, description = "超级管理员登录。", needAuth = false)
    @RequestMapping(value = "/superadmin", method = RequestMethod.POST)
    public ResponseModel<Map<String, Object>> authSuperAdmin(@RequestBody AuthRequestModel authModel) throws Exception {
        return createSession(IdType.employeeCode, AuthType.userNamePassword, UserType.SUPER_ADMIN, authModel);
    }

    private ResponseModel<Map<String, Object>> createSession(
            IdType idType, AuthType authType, UserType userType, AuthRequestModel authModel) throws Exception {
        UserSession userSession = securityService.createSession(idType, authType, userType, authModel);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put(CoreConstants.TOKEN, userSession.getSessionId());
        result.put(CoreConstants.EXPIRE, userSession.getExpiration());
        result.put(CoreConstants.USERID, userSession.getUserId());
        result.put(CoreConstants.LOGINID, userSession.getLoginId());
        result.put(CoreConstants.USERNAME, userSession.getUserName());
        return ResponseHelper.buildResponseModel(result);
    }
}