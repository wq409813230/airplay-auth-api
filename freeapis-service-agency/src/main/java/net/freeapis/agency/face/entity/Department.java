package net.freeapis.agency.face.entity;

import lombok.Data;
import net.freeapis.core.foundation.orm.BaseEntity;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: Department.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: Department.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016-09-09 14:48:04		freeapis		Initial.
 *
 * </pre>
 */
@Data
@Entity
@Table(name = "agency_department")
public class Department extends BaseEntity
{
	private static final long serialVersionUID = 1L;
	private String departmentCode;
	private String departmentName;
	private String agencyCode;
	private String parentCode;
	private String lockStatus;
	private Date lockDate;
	private String lockUserId;
}

