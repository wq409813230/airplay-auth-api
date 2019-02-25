package net.freeapis.asi.face.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: GroupModel.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: GroupModel.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
public class GroupModel implements Serializable {
	private static final long serialVersionUID = 1L;
	private String agencyCode;
	private String groupCode;
	private String parentGroupCode;
	private String groupType;
	private Integer groupOrder;
	private String groupName;
	private Integer nodeLevel;
	private String displayMeta;
	private Date recDate;
	private String recStatus;
	private String recUserId;
	private String extend1;
	private String extend2;
	private String extend3;
	private String description;
	private String lockStatus;
	private String dataSort;

	private boolean hasChildren;
	private List<GroupModel> children;
	private List<GroupColumnModel> columns;
	private Object values;

	public String getAgencyCode() {
		return agencyCode;
	}

	public void setAgencyCode(String agencyCode) {
		this.agencyCode = agencyCode;
	}

	public String getGroupCode() {
		return groupCode;
	}

	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}

	public String getParentGroupCode() {
		return parentGroupCode;
	}

	public void setParentGroupCode(String parentGroupCode) {
		this.parentGroupCode = parentGroupCode;
	}

	public String getGroupType() {
		return groupType;
	}

	public void setGroupType(String groupType) {
		this.groupType = groupType;
	}

	public Integer getGroupOrder() {
		return groupOrder;
	}

	public void setGroupOrder(Integer groupOrder) {
		this.groupOrder = groupOrder;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public Integer getNodeLevel() {
		return nodeLevel;
	}

	public void setNodeLevel(Integer nodeLevel) {
		this.nodeLevel = nodeLevel;
	}

	public String getDisplayMeta() {
		return displayMeta;
	}

	public void setDisplayMeta(String displayMeta) {
		this.displayMeta = displayMeta;
	}

	public Date getRecDate() {
		return recDate;
	}

	public void setRecDate(Date recDate) {
		this.recDate = recDate;
	}

	public String getRecStatus() {
		return recStatus;
	}

	public void setRecStatus(String recStatus) {
		this.recStatus = recStatus;
	}

	public String getRecUserId() {
		return recUserId;
	}

	public void setRecUserId(String recUserId) {
		this.recUserId = recUserId;
	}

	public String getExtend1() {
		return this.extend1;
	}

	public void setExtend1(String extend1) {
		this.extend1 = extend1;
	}

	public String getExtend2() {
		return this.extend2;
	}

	public void setExtend2(String extend2) {
		this.extend2 = extend2;
	}

	public String getExtend3() {
		return this.extend3;
	}

	public void setExtend3(String extend3) {
		this.extend3 = extend3;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean isHasChildren() {
		return hasChildren;
	}

	public void setHasChildren(boolean hasChildren) {
		this.hasChildren = hasChildren;
	}

	public List<GroupModel> getChildren() {
		return children;
	}

	public void setChildren(List<GroupModel> children) {
		this.children = children;
	}

	public List<GroupColumnModel> getColumns() {
		return columns;
	}

	public void setColumns(List<GroupColumnModel> columns) {
		this.columns = columns;
	}

	public Object getValues() {
		return values;
	}

	public void setValues(Object values) {
		this.values = values;
	}

	public String getLockStatus() {
		return lockStatus;
	}

	public void setLockStatus(String lockStatus) {
		this.lockStatus = lockStatus;
	}

	public String getDataSort() {
		return dataSort;
	}

	public void setDataSort(String dataSort) {
		this.dataSort = dataSort;
	}
}
