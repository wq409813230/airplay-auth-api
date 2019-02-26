package net.freeapis.airplayauth.face;

import net.freeapis.core.foundation.model.Page;
import net.freeapis.airplayauth.face.entity.AuthInfo;
import net.freeapis.core.foundation.orm.BaseService;
import net.freeapis.airplayauth.face.model.AuthInfoModel;

import java.util.Map;

/**
 * <pre>
 *
 *  freeapis
 *  File: AuthInfoService.java
 *
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: AuthInfoService.java 31101200-9 2014-10-14 16:43:51Z freeapis $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
public interface AuthInfoService extends BaseService<AuthInfoModel, AuthInfo> {

    /**
     * 设备认证核心接口
     * @param authRequest
     * @return
     * @throws Exception
     */
    String createAuthInfo(Map<String,String> authRequest) throws Exception;
}
