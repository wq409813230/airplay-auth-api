package net.freeapis.security.face.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import net.freeapis.core.foundation.orm.BaseEntity;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: ModuleOperation.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: ModuleOperation.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016-09-09 14:25:41		freeapis		Initial.
 *
 * </pre>
 */
@Entity
@Table(name = "security_module_operation")
public class ModuleOperation extends BaseEntity
{
	private static final long serialVersionUID = 1L;
	private String moduleCode;
	private String funcId;
	private String reqMode;
	private String buttonCode;
	private String buttonStyle;
	private String buttonType;
	private String buttonName;
	private String agencyCode;

	@Column(name = "MODULE_CODE", nullable = false)
	public String getModuleCode() {
		return this.moduleCode;
	}
	public void setModuleCode(String moduleCode) {
		this.moduleCode = moduleCode;
	}
	
	@Column(name = "FUNC_ID")
	public String getFuncId() {
		return this.funcId;
	}
	public void setFuncId(String funcId) {
		this.funcId = funcId;
	}
	
	@Column(name = "REQ_MODE")
	public String getReqMode() {
		return this.reqMode;
	}
	public void setReqMode(String reqMode) {
		this.reqMode = reqMode;
	}

	@Column(name = "AGENCY_CODE")
	public String getAgencyCode() {
		return agencyCode;
	}

	public void setAgencyCode(String agencyCode) {
		this.agencyCode = agencyCode;
	}

	@Column(name = "BUTTON_CODE")
	public String getButtonCode() {
		return buttonCode;
	}

	public void setButtonCode(String buttonCode) {
		this.buttonCode = buttonCode;
	}

	@Column(name = "BUTTON_STYLE")
	public String getButtonStyle() {
		return buttonStyle;
	}

	public void setButtonStyle(String buttonStyle) {
		this.buttonStyle = buttonStyle;
	}

	@Column(name = "BUTTON_TYPE")
	public String getButtonType() {
		return buttonType;
	}

	public void setButtonType(String buttonType) {
		this.buttonType = buttonType;
	}

	@Column(name = "BUTTON_NAME")
	public String getButtonName() {
		return buttonName;
	}

	public void setButtonName(String buttonName) {
		this.buttonName = buttonName;
	}
}

