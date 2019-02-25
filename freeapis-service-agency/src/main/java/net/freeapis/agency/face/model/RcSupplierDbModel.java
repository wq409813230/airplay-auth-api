package net.freeapis.agency.face.model;

import net.freeapis.core.foundation.orm.BaseModel;

/**
 * Created by Qukun on 2017/7/27.
 * 用于和数据库保持一致的商品model（类似于entity）
 */
public class RcSupplierDbModel extends BaseModel{

	private Long sequenceNbr;
	private String supplierCode;
	private String supplierTag;
	private String syncInfo;

	public Long getSequenceNbr() {
		return sequenceNbr;
	}

	public void setSequenceNbr(Long sequenceNbr) {
		this.sequenceNbr = sequenceNbr;
	}

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

	public String getSyncInfo() {
		return syncInfo;
	}

	public void setSyncInfo(String syncInfo) {
		this.syncInfo = syncInfo;
	}
}
