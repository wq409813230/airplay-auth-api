package net.freeapis.airplayauth.face;

import net.freeapis.core.foundation.model.Page;
import net.freeapis.airplayauth.face.entity.Company;
import net.freeapis.core.foundation.orm.BaseService;
import net.freeapis.airplayauth.face.model.CompanyModel;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: CompanyService.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: CompanyService.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
public interface CompanyService extends BaseService<CompanyModel,Company>
{
        CompanyModel createCompany(CompanyModel companyModel) throws Exception;
        CompanyModel updateCompany(CompanyModel companyModel) throws Exception;
        Page getByPage(Page page) throws Exception;
}
