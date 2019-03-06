package net.freeapis.airplayauth.service;

import net.freeapis.airplayauth.dao.AuthHistoryDAO;
import net.freeapis.airplayauth.face.AuthHistoryService;
import net.freeapis.airplayauth.face.entity.AuthHistory;
import net.freeapis.airplayauth.face.model.AuthHistoryModel;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.mysql.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    public Page getByPage(String machineModel, String companyName, Page page) throws Exception {
        page.setList(authHistoryDAO.findByPage(machineModel,companyName,page));
        return page;
    }
}