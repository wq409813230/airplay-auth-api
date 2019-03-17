package net.freeapis.airplayauth.face;

import net.freeapis.core.foundation.model.Page;
import net.freeapis.airplayauth.face.entity.AuthConfig;
import net.freeapis.core.foundation.orm.BaseService;
import net.freeapis.airplayauth.face.model.AuthConfigModel;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AuthConfigService.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthConfigService.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:37		freeapis		Initial.
 *
 * </pre>
 */
public interface AuthConfigService extends BaseService<AuthConfigModel,AuthConfig>
{
        AuthConfigModel createAuthConfig(AuthConfigModel authConfigModel) throws Exception;
        void deleteAuthConfig(Long id) throws Exception;
        AuthConfigModel updateAuthConfig(AuthConfigModel authConfigModel) throws Exception;
        Page getByPage(String company,String machineModel,Page page) throws Exception;
        void createRSAKeyPair() throws Exception;
}
