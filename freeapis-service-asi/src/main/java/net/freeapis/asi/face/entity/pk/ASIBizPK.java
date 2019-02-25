package net.freeapis.asi.face.entity.pk;

import java.io.Serializable;

/**
 * &lt;pre&gt;
 * <p/>
 * freeapis File: ASIBizPK PROJECT: build-generator
 * <p/>
 * freeapis, Inc. Copyright (C): 2015
 * <p/>
 * Description: ${todo}
 * <p/>
 * Notes: $$Id: ASIBizPK 31101200-9 2014-10-14 16:43:51Z freeapis\ Tony.Li $$
 * <p/>
 * Revision History &amp;lt;Date&amp;gt;, &amp;lt;Who&amp;gt;,
 * &amp;lt;What&amp;gt; 2015/11/18 Tony.Li Initial.
 * <p/>
 * &lt;/pre&gt;
 */
public class ASIBizPK implements Serializable {

	private static final long serialVersionUID = 1L;

	private String agencyCode;

	private String entityType;

	private String groupCode;

	public ASIBizPK() {
	}

	public ASIBizPK(String groupCode, String entityType, String agencyCode) {
		this.groupCode = groupCode;
		this.entityType = entityType;
		this.agencyCode = agencyCode;
	}

	public String getGroupCode() {
		return groupCode;
	}

	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}

	public String getEntityType() {
		return entityType;
	}

	public void setEntityType(String entityType) {
		this.entityType = entityType;
	}

	public String getAgencyCode() {
		return agencyCode;
	}

	public void setAgencyCode(String agencyCode) {
		this.agencyCode = agencyCode;
	}
}
