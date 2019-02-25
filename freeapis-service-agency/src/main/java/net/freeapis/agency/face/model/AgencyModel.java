package net.freeapis.agency.face.model;

import java.util.Date;

import net.freeapis.core.foundation.orm.BaseModel;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AgencyModel.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AgencyModel.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016-12-26 17:48:46		freeapis		Initial.
 *
 * </pre>
 */
public class AgencyModel extends BaseModel
{
	private static final long serialVersionUID = 1L;
	private String agencyCode;
	private String agencyName;
	private String agencyAlias;
	private String agencyDesc;
	private String avatar;
	private String banner;
	private String agencyLevel;
	private String parentCode;
	private String coordinate;
	private String country;
	private String province;
	private String city;
	private String region;
	private String addressDetail;
	private String agencyAddress;
	private String phone;
	private String agencyFax;
	private String legalPerson;
	private String legalMobil;
	private String businessHoursStart;
	private String businessHoursEnd;
	private String agencyLicense;
	private String isApproved;
	private String isPublished;
	private String isLoginable;
	private String lockStatus;
	private Date lockDate;
	private String lockUserId;

	public String getAgencyCode() {
		return this.agencyCode;
	}
	public void setAgencyCode(String agencyCode) {
		this.agencyCode = agencyCode;
	}
	
	public String getAgencyName() {
		return this.agencyName;
	}
	public void setAgencyName(String agencyName) {
		this.agencyName = agencyName;
	}
	
	public String getAgencyAlias() {
		return this.agencyAlias;
	}
	public void setAgencyAlias(String agencyAlias) {
		this.agencyAlias = agencyAlias;
	}
	
	public String getAgencyDesc() {
		return this.agencyDesc;
	}
	public void setAgencyDesc(String agencyDesc) {
		this.agencyDesc = agencyDesc;
	}
	
	public String getAvatar() {
		return this.avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	
	public String getBanner() {
		return this.banner;
	}
	public void setBanner(String banner) {
		this.banner = banner;
	}
	
	public String getAgencyLevel() {
		return this.agencyLevel;
	}
	public void setAgencyLevel(String agencyLevel) {
		this.agencyLevel = agencyLevel;
	}
	
	public String getParentCode() {
		return this.parentCode;
	}
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}
	
	public String getCoordinate() {
		return this.coordinate;
	}
	public void setCoordinate(String coordinate) {
		this.coordinate = coordinate;
	}
	
	public String getCountry() {
		return this.country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	
	public String getProvince() {
		return this.province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	
	public String getCity() {
		return this.city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	
	public String getRegion() {
		return this.region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	
	public String getAddressDetail() {
		return this.addressDetail;
	}
	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}
	
	public String getAgencyAddress() {
		return this.agencyAddress;
	}
	public void setAgencyAddress(String agencyAddress) {
		this.agencyAddress = agencyAddress;
	}
	
	public String getPhone() {
		return this.phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getAgencyFax() {
		return this.agencyFax;
	}
	public void setAgencyFax(String agencyFax) {
		this.agencyFax = agencyFax;
	}
	
	public String getLegalPerson() {
		return this.legalPerson;
	}
	public void setLegalPerson(String legalPerson) {
		this.legalPerson = legalPerson;
	}
	
	public String getLegalMobil() {
		return this.legalMobil;
	}
	public void setLegalMobil(String legalMobil) {
		this.legalMobil = legalMobil;
	}
	
	public String getBusinessHoursStart() {
		return this.businessHoursStart;
	}
	public void setBusinessHoursStart(String businessHoursStart) {
		this.businessHoursStart = businessHoursStart;
	}
	
	public String getBusinessHoursEnd() {
		return this.businessHoursEnd;
	}
	public void setBusinessHoursEnd(String businessHoursEnd) {
		this.businessHoursEnd = businessHoursEnd;
	}
	
	public String getAgencyLicense() {
		return this.agencyLicense;
	}
	public void setAgencyLicense(String agencyLicense) {
		this.agencyLicense = agencyLicense;
	}
	
	public String getIsApproved() {
		return this.isApproved;
	}
	public void setIsApproved(String isApproved) {
		this.isApproved = isApproved;
	}
	
	public String getIsPublished() {
		return this.isPublished;
	}
	public void setIsPublished(String isPublished) {
		this.isPublished = isPublished;
	}
	
	public String getIsLoginable() {
		return this.isLoginable;
	}
	public void setIsLoginable(String isLoginable) {
		this.isLoginable = isLoginable;
	}
	
	public String getLockStatus() {
		return this.lockStatus;
	}
	public void setLockStatus(String lockStatus) {
		this.lockStatus = lockStatus;
	}
	
	public Date getLockDate() {
		return this.lockDate;
	}
	public void setLockDate(Date lockDate) {
		this.lockDate = lockDate;
	}
	
	public String getLockUserId() {
		return this.lockUserId;
	}
	public void setLockUserId(String lockUserId) {
		this.lockUserId = lockUserId;
	}
	
}

