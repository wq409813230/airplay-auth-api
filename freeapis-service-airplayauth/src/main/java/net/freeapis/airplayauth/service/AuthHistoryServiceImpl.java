package net.freeapis.airplayauth.service;

import org.springframework.stereotype.Service;

import net.freeapis.airplayauth.dao.AuthHistoryDAO;
import net.freeapis.airplayauth.face.entity.AuthHistory;
import net.freeapis.core.mysql.BaseServiceImpl;
import net.freeapis.airplayauth.face.AuthHistoryService;
import net.freeapis.airplayauth.face.model.AuthHistoryModel;
import net.freeapis.core.foundation.model.Page;
import org.springframework.beans.factory.annotation.Autowired;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AuthHistoryServiceImpl.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthHistoryServiceImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
@Service(value="authHistoryService")
public class AuthHistoryServiceImpl extends BaseServiceImpl<AuthHistoryModel, AuthHistory> implements AuthHistoryService
{
    @Autowired
    private AuthHistoryDAO authHistoryDAO;

    @Override
    public AuthHistoryModel createAuthHistory(AuthHistoryModel authHistoryModel) throws Exception {
        return super.create(authHistoryModel);
    }

    @Override
    public AuthHistoryModel updateAuthHistory(AuthHistoryModel authHistoryModel) throws Exception {
        return null;
    }

    @Override
    public Page getByPage(Page page) throws Exception {
        return page;
    }
}