package net.freeapis.airplayauth.dao.impl;

import org.springframework.stereotype.Repository;
import net.freeapis.core.mysql.GenericDAOImpl;
import net.freeapis.airplayauth.dao.AuthHistoryDAO;
import net.freeapis.airplayauth.face.entity.AuthHistory;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AuthHistoryDAOImpl.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthHistoryDAOImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
@Repository(value="authHistoryDAO")
public class AuthHistoryDAOImpl extends GenericDAOImpl<AuthHistory> implements AuthHistoryDAO
{

}
