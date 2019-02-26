package net.freeapis.airplayauth.face.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import lombok.Data;

import net.freeapis.core.foundation.orm.BaseEntity;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AuthInfo.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthInfo.java 31101200-9 2014-10-14 16:43:51Z freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
@Data
@Entity
@Table(name = "airplayauth_auth_info")
public class AuthInfo extends BaseEntity
{
	private static final long serialVersionUID = 1L;
	private String companyCode;
	private String machineModel;
	private String deviceMac;
	private String authCode;
}

