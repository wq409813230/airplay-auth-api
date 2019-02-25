package net.freeapis.agency.face.model;

import java.util.Date;

import net.freeapis.core.foundation.orm.BaseModel;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: SupplierCategoryModel.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: SupplierCategoryModel.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2017-08-16 19:56:26		freeapis		Initial.
 *
 * </pre>
 */
public class SupplierCategoryModel extends BaseModel
{
	private static final long serialVersionUID = 1L;
	private Long supplierId;
	private String categoryCode;
	private String categoryName;

	public Long getSupplierId() {
		return this.supplierId;
	}
	public void setSupplierId(Long supplierId) {
		this.supplierId = supplierId;
	}
	
	public String getCategoryCode() {
		return this.categoryCode;
	}
	public void setCategoryCode(String categoryCode) {
		this.categoryCode = categoryCode;
	}
	
	public String getCategoryName() {
		return this.categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
}

