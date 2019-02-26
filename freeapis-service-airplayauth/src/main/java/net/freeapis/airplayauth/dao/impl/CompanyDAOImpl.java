package net.freeapis.airplayauth.dao.impl;

import org.springframework.stereotype.Repository;
import net.freeapis.core.mysql.GenericDAOImpl;
import net.freeapis.airplayauth.dao.CompanyDAO;
import net.freeapis.airplayauth.face.entity.Company;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: CompanyDAOImpl.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: CompanyDAOImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
@Repository(value="companyDAO")
public class CompanyDAOImpl extends GenericDAOImpl<Company> implements CompanyDAO
{

}
