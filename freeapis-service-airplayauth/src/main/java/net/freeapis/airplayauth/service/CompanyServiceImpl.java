package net.freeapis.airplayauth.service;

import org.springframework.stereotype.Service;

import net.freeapis.airplayauth.dao.CompanyDAO;
import net.freeapis.airplayauth.face.entity.Company;
import net.freeapis.core.mysql.BaseServiceImpl;
import net.freeapis.airplayauth.face.CompanyService;
import net.freeapis.airplayauth.face.model.CompanyModel;
import net.freeapis.core.foundation.model.Page;
import org.springframework.beans.factory.annotation.Autowired;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: CompanyServiceImpl.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: CompanyServiceImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
@Service(value="companyService")
public class CompanyServiceImpl extends BaseServiceImpl<CompanyModel, Company> implements CompanyService
{
    @Autowired
    private CompanyDAO companyDAO;

    @Override
    public CompanyModel createCompany(CompanyModel companyModel) throws Exception {
        return super.create(companyModel);
    }

    @Override
    public CompanyModel updateCompany(CompanyModel companyModel) throws Exception {
        return null;
    }

    @Override
    public Page getByPage(Page page) throws Exception {
        return page;
    }
}