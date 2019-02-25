package net.freeapis.agency.face.model;

import java.util.Date;

import net.freeapis.core.foundation.orm.BaseModel;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: RcSupplierSnptModel.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: RcSupplierSnptModel.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2017-08-16 19:56:26		freeapis		Initial.
 *
 * </pre>
 */
public class RcSupplierSnptModel extends BaseModel
{
	private static final long serialVersionUID = 1L;
	private Long supplierCode;
	private String supplierSnpt;

	public Long getSupplierCode() {
		return this.supplierCode;
	}
	public void setSupplierCode(Long supplierCode) {
		this.supplierCode = supplierCode;
	}
	
	public String getSupplierSnpt() {
		return this.supplierSnpt;
	}
	public void setSupplierSnpt(String supplierSnpt) {
		this.supplierSnpt = supplierSnpt;
	}
	
}

