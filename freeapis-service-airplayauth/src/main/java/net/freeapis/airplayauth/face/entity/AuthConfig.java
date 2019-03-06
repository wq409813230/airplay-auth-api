package net.freeapis.airplayauth.face.entity;

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
 *  File: AuthConfig.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthConfig.java 31101200-9 2014-10-14 16:43:51Z freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:37		freeapis		Initial.
 *
 * </pre>
 */
@Entity
@Table(name = "airplayauth_auth_config")
@Data
public class AuthConfig extends BaseEntity
{
	private static final long serialVersionUID = 1L;
	private String machineModel;
	private String companyName;
	private String companyCode;
	private String privateKey;
	private Integer maxAuthCount;
	private Date createTime;
}

