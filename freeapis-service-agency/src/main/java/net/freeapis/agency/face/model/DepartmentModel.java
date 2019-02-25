package net.freeapis.agency.face.model;

import lombok.Data;
import net.freeapis.core.foundation.orm.BaseModel;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: DepartmentModel.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: DepartmentModel.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年07月18日		framework		Initial.
 *
 * </pre>
 */
@Data
public class DepartmentModel extends BaseModel
{
	private static final long serialVersionUID = 1L;
	
	private String departmentCode;
	private String departmentName;
	private String agencyCode;
	private String parentCode;
	private String lockStatus;
	private Date lockDate;
	private String lockUserId;
	private List<DepartmentModel> children;
	private boolean hasChildren;
	private List<Map<String, Object>> employeeInfoList;

}

