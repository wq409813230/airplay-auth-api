package net.freeapis.asi.face.entity.pk;

import java.io.Serializable;

/**
 * &lt;pre&gt;
 * <p/>
 * freeapis File: ASIColumnPK PROJECT: build-generator
 * <p/>
 * freeapis, Inc. Copyright (C): 2015
 * <p/>
 * Description: ${todo}
 * <p/>
 * Notes: $$Id: ASIColumnPK 31101200-9 2014-10-14 16:43:51Z freeapis\ Tony.Li $$
 * <p/>
 * Revision History &amp;lt;Date&amp;gt;, &amp;lt;Who&amp;gt;,
 * &amp;lt;What&amp;gt; 2015/11/10 Tony.Li Initial.
 * <p/>
 * &lt;/pre&gt;
 */
public class ColumnTemplatePK implements Serializable {
	private static final long serialVersionUID = 869807748949837944L;

	private String agencyCode;

	private String columnCode;

	public String getColumnCode() {
		return columnCode;
	}

	public void setColumnCode(String columnCode) {
		this.columnCode = columnCode;
	}

	public String getAgencyCode() {
		return agencyCode;
	}

	public void setAgencyCode(String agencyCode) {
		this.agencyCode = agencyCode;
	}
}
