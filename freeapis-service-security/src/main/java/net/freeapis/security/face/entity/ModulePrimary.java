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
 *  File: ModuleRole.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: ModuleRole.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016-09-09 14:25:41		freeapis		Initial.
 *
 * </pre>
 */
@Entity
@Table(name = "security_module_primary")
public class ModulePrimary extends BaseEntity
{
	private static final long serialVersionUID = 1L;
	private String primaryType;
	private String primaryCode;
	private String agencyCode;
	private String moduleCode;

	@Column(name = "AGENCY_CODE", nullable = false)
	public String getAgencyCode() {
		return this.agencyCode;
	}
	public void setAgencyCode(String agencyCode) {
		this.agencyCode = agencyCode;
	}
	
	@Column(name = "MODULE_CODE", nullable = false)
	public String getModuleCode() {
		return this.moduleCode;
	}
	public void setModuleCode(String moduleCode) {
		this.moduleCode = moduleCode;
	}


	@Column(name = "PRIMARY_TYPE", nullable = false)
	public String getPrimaryType() {
		return primaryType;
	}

	public void setPrimaryType(String primaryType) {
		this.primaryType = primaryType;
	}

	@Column(name = "PRIMARY_CODE", nullable = false)
	public String getPrimaryCode() {
		return primaryCode;
	}

	public void setPrimaryCode(String primaryCode) {
		this.primaryCode = primaryCode;
	}
}

