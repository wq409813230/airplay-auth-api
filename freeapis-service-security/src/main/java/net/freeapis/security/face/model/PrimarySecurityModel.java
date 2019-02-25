package net.freeapis.security.face.model;

import java.io.Serializable;
import java.util.List;

public class PrimarySecurityModel implements Serializable {
	private static final long serialVersionUID = 1L;
	private String primaryType;
	private String primaryCode;
	private String agencyCode;
	/**
	 * 该角色对应的权限
	 * 主要传入：moduleCode 和 funcId属性
	 */
	private List<ModuleOperationModel> privilege;

	public String getPrimaryType() {
		return primaryType;
	}

	public void setPrimaryType(String primaryType) {
		this.primaryType = primaryType;
	}

	public String getPrimaryCode() {
		return primaryCode;
	}

	public void setPrimaryCode(String primaryCode) {
		this.primaryCode = primaryCode;
	}

	public String getAgencyCode() {
		return agencyCode;
	}
	public void setAgencyCode(String agencyCode) {
		this.agencyCode = agencyCode;
	}
	public List<ModuleOperationModel> getPrivilege() {
		return privilege;
	}
	public void setPrivilege(List<ModuleOperationModel> privilege) {
		this.privilege = privilege;
	}
	

}
