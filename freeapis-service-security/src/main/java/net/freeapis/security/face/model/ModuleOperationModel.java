package net.freeapis.security.face.model;

import net.freeapis.core.foundation.orm.BaseModel;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: ModuleOperationModel.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: ModuleOperationModel.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016-09-09 14:25:41		freeapis		Initial.
 *
 * </pre>
 */
public class ModuleOperationModel extends BaseModel
{
	private static final long serialVersionUID = 1L;
	private String moduleCode;
	private String reqMode;
	private String buttonCode;
	private String buttonStyle;
	private String buttonType;
	private String buttonName;
	private String funcId;
	private String agencyCode;

	public String getModuleCode() {
		return this.moduleCode;
	}
	public void setModuleCode(String moduleCode) {
		this.moduleCode = moduleCode;
	}
	
	public String getFuncId() {
		return this.funcId;
	}
	public void setFuncId(String funcId) {
		this.funcId = funcId;
	}
	
	public String getReqMode() {
		return this.reqMode;
	}
	public void setReqMode(String reqMode) {
		this.reqMode = reqMode;
	}

	public String getAgencyCode() {
		return agencyCode;
	}

	public void setAgencyCode(String agencyCode) {
		this.agencyCode = agencyCode;
	}

	public String getButtonCode() {
		return buttonCode;
	}

	public void setButtonCode(String buttonCode) {
		this.buttonCode = buttonCode;
	}

	public String getButtonStyle() {
		return buttonStyle;
	}

	public void setButtonStyle(String buttonStyle) {
		this.buttonStyle = buttonStyle;
	}

	public String getButtonType() {
		return buttonType;
	}

	public void setButtonType(String buttonType) {
		this.buttonType = buttonType;
	}

	public String getButtonName() {
		return buttonName;
	}

	public void setButtonName(String buttonName) {
		this.buttonName = buttonName;
	}
}

