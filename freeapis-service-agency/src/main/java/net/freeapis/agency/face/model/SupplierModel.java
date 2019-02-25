package net.freeapis.agency.face.model;

import net.freeapis.core.foundation.orm.BaseModel;

import java.util.List;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: SupplierModel.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: SupplierModel.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2017-05-08 19:47:47		freeapis		Initial.
 *
 * </pre>
 */
public class SupplierModel extends BaseModel
{

	private static final long serialVersionUID = 1L;
	private String name;
	private String code;
	private String intro;
	private String tags;
	private String crafts;
	private String materials;
	private List<String> workImages;
	private List<SupplierCategoryModel> supplierCategoryModels;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public List<String> getWorkImages() {
		return workImages;
	}

	public void setWorkImages(List<String> workImages) {
		this.workImages = workImages;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public String getCrafts() {
		return crafts;
	}

	public void setCrafts(String crafts) {
		this.crafts = crafts;
	}

	public String getMaterials() {
		return materials;
	}

	public void setMaterials(String materials) {
		this.materials = materials;
	}

	public List<SupplierCategoryModel> getSupplierCategoryModels() {
		return supplierCategoryModels;
	}

	public void setSupplierCategoryModels(List<SupplierCategoryModel> supplierCategoryModels) {
		this.supplierCategoryModels = supplierCategoryModels;
	}
}

