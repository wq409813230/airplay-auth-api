package net.freeapis.asi.face.entity.pk;

import java.io.Serializable;

/**
 * &lt;pre&gt;
 * <p/>
 * freeapis File: ASIGroupPK PROJECT: build-generator
 * <p/>
 * freeapis, Inc. Copyright (C): 2015
 * <p/>
 * Description: ${todo}
 * <p/>
 * Notes: $$Id: ASIGroupPK 31101200-9 2014-10-14 16:43:51Z freeapis\ Tony.Li $$
 * <p/>
 * Revision History &amp;lt;Date&amp;gt;, &amp;lt;Who&amp;gt;,
 * &amp;lt;What&amp;gt; 2015/11/10 Tony.Li Initial.
 * <p/>
 * &lt;/pre&gt;
 */
public class GroupPK implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String agencyCode;

	private String groupCode;

	public String getGroupCode() {
		return groupCode;
	}

	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}

	public String getAgencyCode() {
		return agencyCode;
	}

	public void setAgencyCode(String agencyCode) {
		this.agencyCode = agencyCode;
	}
}
