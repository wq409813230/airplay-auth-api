package net.freeapis.security.face.model;

import java.util.Date;

import lombok.Data;
import net.freeapis.core.foundation.orm.BaseModel;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: RoleModel.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: RoleModel.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016-09-09 14:25:42		freeapis		Initial.
 *
 * </pre>
 */
@Data
public class RoleModel extends BaseModel
{
	private static final long serialVersionUID = 1L;
	private String roleCode;
	private String roleName;
	private String agencyCode;
	private String lockStatus;
	private Date lockDate;
	private String lockUserId;
}