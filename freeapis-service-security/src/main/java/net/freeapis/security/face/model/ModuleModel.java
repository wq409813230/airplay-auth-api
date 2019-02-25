package net.freeapis.security.face.model;

import net.freeapis.core.foundation.orm.BaseModel;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.security.face.entity.ModuleOperation;

import java.util.Date;
import java.util.List;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: ModuleModel.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: ModuleModel.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016-09-09 14:25:41		freeapis		Initial.
 *
 * </pre>
 */
public class ModuleModel extends BaseModel implements Comparable<ModuleModel>{
	private static final long serialVersionUID = 1L;
	private String agencyCode;
	private String moduleType;
	private String moduleCode;
	private String moduleName;
	private String parentCode;
	private String direction;
	private Integer levelNum;
	private Integer orderNum;
	private String lockStatus;
	private Date lockDate;
	private String lockUserId;
	private boolean hasChildren;
	private String childContentType;
	private String isAgencyTemplate;

	List<ModuleModel> children;

	//模块资源信息
	List<ModuleOperation> operations;

	//模块操作信息
	List<ModuleOperationModel> moduleOperation;

	public String getModuleCode() {
		return this.moduleCode;
	}

	public void setModuleCode(String moduleCode) {
		this.moduleCode = moduleCode;
	}

	public String getModuleName() {
		return this.moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}

	public String getParentCode() {
		return this.parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public String getDirection() {
		return this.direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public Integer getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}

	public String getLockStatus() {
		return this.lockStatus;
	}

	public void setLockStatus(String lockStatus) {
		this.lockStatus = lockStatus;
	}

	public Date getLockDate() {
		return this.lockDate;
	}

	public void setLockDate(Date lockDate) {
		this.lockDate = lockDate;
	}

	public String getLockUserId() {
		return this.lockUserId;
	}

	public void setLockUserId(String lockUserId) {
		this.lockUserId = lockUserId;
	}

	public List<ModuleOperation> getOperations() {
		return operations;
	}

	public void setOperations(List<ModuleOperation> operations) {
		this.operations = operations;
	}

	public boolean isHasChildren() {
		return hasChildren;
	}

	public void setHasChildren(boolean hasChildren) {
		this.hasChildren = hasChildren;
	}

	public String getAgencyCode() {
		return agencyCode;
	}

	public void setAgencyCode(String agencyCode) {
		this.agencyCode = agencyCode;
	}

	public List<ModuleOperationModel> getModuleOperation() {
		return moduleOperation;
	}

	public void setModuleOperation(List<ModuleOperationModel> moduleOperation) {
		this.moduleOperation = moduleOperation;
	}

	public String getModuleType() {
		return moduleType;
	}

	public void setModuleType(String moduleType) {
		this.moduleType = moduleType;
	}

	public Integer getLevelNum() {
		return levelNum;
	}

	public void setLevelNum(Integer levelNum) {
		this.levelNum = levelNum;
	}

	public String getChildContentType() {
		return childContentType;
	}

	public void setChildContentType(String childContentType) {
		this.childContentType = childContentType;
	}

	public String getIsAgencyTemplate() {
		return isAgencyTemplate;
	}

	public void setIsAgencyTemplate(String isAgencyTemplate) {
		this.isAgencyTemplate = isAgencyTemplate;
	}

	public List<ModuleModel> getChildren() {
		return children;
	}

	public void setChildren(List<ModuleModel> children) {
		this.children = children;
	}

	@Override
	public int compareTo(ModuleModel o) {
		int rvalue = 0;
		if(!ValidationUtil.isEmpty(o))
		{
			rvalue = this.getOrderNum() - o.getOrderNum();
		}
		return rvalue;
	}

}
