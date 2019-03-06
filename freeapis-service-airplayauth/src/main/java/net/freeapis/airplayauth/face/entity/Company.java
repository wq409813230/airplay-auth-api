package net.freeapis.airplayauth.face.entity;

import lombok.Data;
import net.freeapis.core.foundation.orm.BaseEntity;

import javax.persistence.Entity;
import javax.persistence.Table;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: Company.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: Company.java 31101200-9 2014-10-14 16:43:51Z freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
@Data
@Entity
@Table(name = "airplayauth_company")
public class Company extends BaseEntity
{
	private static final long serialVersionUID = 1L;
	private String name;
	private String code;
}

