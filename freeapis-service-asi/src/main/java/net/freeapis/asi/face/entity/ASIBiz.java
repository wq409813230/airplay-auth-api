package net.freeapis.asi.face.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

import net.freeapis.asi.face.entity.pk.ASIBizPK;

/**
 * <pre>
 * 
 *  freeapis
 *  File: ASIBiz.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 * 	$Id: ASIBiz.java 72642 2009-01-01 20:01:57Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年8月30日		wuqiang		Initial.
 * 
 * </pre>
 */
@Entity
@Table(name = "asi_biz")
@IdClass(ASIBizPK.class)
public class ASIBiz implements Serializable {

	private static final long serialVersionUID = 7509889443203707462L;

	@Id
	private String agencyCode;
	@Id
	private String entityType;
	@Id
	private String groupCode;
	private Date recDate;
	private String recUserId;
	private String recStatus;

	public String getAgencyCode() {
		return agencyCode;
	}

	public void setAgencyCode(String agencyCode) {
		this.agencyCode = agencyCode;
	}

	public String getEntityType() {
		return entityType;
	}

	public void setEntityType(String entityType) {
		this.entityType = entityType;
	}

	public String getGroupCode() {
		return groupCode;
	}

	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}

	public Date getRecDate() {
		return recDate;
	}

	public void setRecDate(Date recDate) {
		this.recDate = recDate;
	}

	public String getRecUserId() {
		return recUserId;
	}

	public void setRecUserId(String recUserId) {
		this.recUserId = recUserId;
	}

	public String getRecStatus() {
		return recStatus;
	}

	public void setRecStatus(String recStatus) {
		this.recStatus = recStatus;
	}

}

/*
 * $Log: av-env.bat,v $
 */