package net.freeapis.security.face.entity;

import net.freeapis.core.foundation.orm.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: Module.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: Module.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016-09-09 14:25:41		freeapis		Initial.
 *
 * </pre>
 */
@Entity
@Table(name = "security_module")
public class Module extends BaseEntity
{
	private static final long serialVersionUID = 1L;
	private String agencyCode;
	private String moduleType;
	private String moduleCode;
	private String moduleName;
	private String parentCode;
	private String childContentType;
	private String direction;
	private Integer orderNum;
	private Integer levelNum;
	private String lockStatus;
	private Date lockDate;
	private String lockUserId;
	private String isAgencyTemplate;

	@Column(name = "MODULE_CODE", nullable = false)
	public String getModuleCode() {
		return this.moduleCode;
	}
	public void setModuleCode(String moduleCode) {
		this.moduleCode = moduleCode;
	}
	
	@Column(name = "MODULE_NAME", nullable = false)
	public String getModuleName() {
		return this.moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	
	@Column(name = "PARENT_CODE", nullable = false)
	public String getParentCode() {
		return this.parentCode;
	}
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}
	
	@Column(name = "DIRECTION")
	public String getDirection() {
		return this.direction;
	}
	public void setDirection(String direction) {
		this.direction = direction;
	}
	
	@Column(name = "LOCK_STATUS", nullable = false)
	public String getLockStatus() {
		return this.lockStatus;
	}

	@Column(name = "ORDER_NUM")
	public Integer getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}
	public void setLockStatus(String lockStatus) {
		this.lockStatus = lockStatus;
	}
	
	@Column(name = "LOCK_DATE")
	public Date getLockDate() {
		return this.lockDate;
	}
	public void setLockDate(Date lockDate) {
		this.lockDate = lockDate;
	}
	
	@Column(name = "LOCK_USER_ID")
	public String getLockUserId() {
		return this.lockUserId;
	}
	public void setLockUserId(String lockUserId) {
		this.lockUserId = lockUserId;
	}

	@Column(name = "AGENCY_CODE")
	public String getAgencyCode() {
		return agencyCode;
	}

	public void setAgencyCode(String agencyCode) {
		this.agencyCode = agencyCode;
	}

	@Column(name = "MODULE_TYPE")
	public String getModuleType() {
		return moduleType;
	}

	public void setModuleType(String moduleType) {
		this.moduleType = moduleType;
	}

	@Column(name = "LEVEL_NUM")
	public Integer getLevelNum() {
		return levelNum;
	}

	public void setLevelNum(Integer levelNum) {
		this.levelNum = levelNum;
	}

	@Column(name = "CHILD_CONTENT_TYPE")
	public String getChildContentType() {
		return childContentType;
	}

	public void setChildContentType(String childContentType) {
		this.childContentType = childContentType;
	}

	@Column(name = "IS_AGENCY_TEMPLATE")
	public String getIsAgencyTemplate() {
		return isAgencyTemplate;
	}

	public void setIsAgencyTemplate(String isAgencyTemplate) {
		this.isAgencyTemplate = isAgencyTemplate;
	}
}

