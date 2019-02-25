package net.freeapis.agency.face.model;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * Created by Qukun on 2017/7/27.
 * 用于展示的资源中心商品model
 */
public class RcSupplierModel implements Serializable {

	private String supplierCode;
	private String supplierTag;
	private String intro;
	private List<String> workImages;
	private List<Map<String,Object>> supplierCategoryModels;


	public String getSupplierCode() {
		return supplierCode;
	}

	public void setSupplierCode(String supplierCode) {
		this.supplierCode = supplierCode;
	}

	public String getSupplierTag() {
		return supplierTag;
	}

	public void setSupplierTag(String supplierTag) {
		this.supplierTag = supplierTag;
	}

	public List<String> getWorkImages() {
		return workImages;
	}

	public void setWorkImages(List<String> workImages) {
		this.workImages = workImages;
	}

	public List<Map<String, Object>> getSupplierCategoryModels() {
		return supplierCategoryModels;
	}

	public void setSupplierCategoryModels(List<Map<String, Object>> supplierCategoryModels) {
		this.supplierCategoryModels = supplierCategoryModels;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}
}
