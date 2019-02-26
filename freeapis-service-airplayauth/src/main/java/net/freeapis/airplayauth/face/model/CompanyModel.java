package net.freeapis.airplayauth.face.model;

import java.util.Date;

import net.freeapis.core.foundation.orm.BaseModel;
import lombok.Data;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: CompanyModel.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: CompanyModel.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
@Data
public class CompanyModel extends BaseModel
{
	private static final long serialVersionUID = 1L;
	private String name;
	private String code;
}

