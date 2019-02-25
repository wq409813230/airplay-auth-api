package net.freeapis.systemctl.face.model;

import net.freeapis.core.foundation.orm.BaseModel;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: DictionaryModel.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: DictionaryModel.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年07月12日		framework		Initial.
 *
 * </pre>
 */
public class DictionaryModel extends BaseModel
{
	private static final long serialVersionUID = 1L;
	
	private String dictCode;
	private String dictName;
	private String agencyCode;

	public String getDictCode() {
		return this.dictCode;
	}
	public void setDictCode(String dictCode) {
		this.dictCode = dictCode;
	}
	
	public String getDictName() {
		return this.dictName;
	}
	public void setDictName(String dictName) {
		this.dictName = dictName;
	}

	public String getAgencyCode() {
		return this.agencyCode;
	}
	public void setAgencyCode(String agencyCode) {
		this.agencyCode = agencyCode;
	}
	
}

