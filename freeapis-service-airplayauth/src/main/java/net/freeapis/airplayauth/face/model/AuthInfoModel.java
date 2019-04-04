package net.freeapis.airplayauth.face.model;

import lombok.Data;
import net.freeapis.core.foundation.orm.BaseModel;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AuthInfoModel.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthInfoModel.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
@Data
public class AuthInfoModel extends BaseModel
{
	private static final long serialVersionUID = 1L;
    private Long authConfigId;
	private String companyCode;
	private String machineModel;
	private String deviceMac;
	private String authCode;

	private String companyName;
}

