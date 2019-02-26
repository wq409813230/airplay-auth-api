package net.freeapis.airplayauth.face;

import net.freeapis.core.foundation.model.Page;
import net.freeapis.airplayauth.face.entity.AuthHistory;
import net.freeapis.core.foundation.orm.BaseService;
import net.freeapis.airplayauth.face.model.AuthHistoryModel;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AuthHistoryService.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthHistoryService.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
public interface AuthHistoryService extends BaseService<AuthHistoryModel,AuthHistory>
{
        AuthHistoryModel createAuthHistory(AuthHistoryModel authHistoryModel) throws Exception;
        AuthHistoryModel updateAuthHistory(AuthHistoryModel authHistoryModel) throws Exception;
        Page getByPage(Page page) throws Exception;
}
