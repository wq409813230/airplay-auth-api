package net.freeapis.agency.service;

import net.freeapis.agency.dao.AgencyDAO;
import net.freeapis.agency.face.AgencyService;
import net.freeapis.agency.face.constants.AgencyConstants;
import net.freeapis.agency.face.entity.Agency;
import net.freeapis.agency.face.model.AgencyModel;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.exceptions.DataValidateException;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.BaseServiceImpl;
import net.freeapis.systemctl.face.LocationInfoService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AgencyServiceImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:商家接口业务逻辑实现
 *  TODO
 *
 *  Notes:
 *  $Id: AgencyServiceImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年07月18日		framework		Initial.
 *
 *  @author gaoyuanteng@zhaotai.ren
 *
 * </pre>
 */
@Service(value = "agencyService")
public class AgencyServiceImpl extends BaseServiceImpl<AgencyModel, Agency>implements AgencyService {

	@Autowired
	private AgencyDAO agencyDAO;

	@Autowired
	private LocationInfoService locationInfoSerevice;

	@Override
	public AgencyModel createAgency(AgencyModel agencyModel) throws Exception {
		Agency newAgency = this.prepareEntity(agencyModel);
		if (ValidationUtil.isEmpty(newAgency.getCoordinate())) {
			newAgency.setCoordinate(AgencyConstants.DEFAULT_AGENCY_COORDINATE);
		}
		this.setLocationNames(newAgency);
		newAgency.setLockStatus(CoreConstants.COMMON_N);
		newAgency.setLockDate(new Date());
		newAgency.setLockUserId(RequestContext.getExeUserId());
		newAgency.setIsApproved(CoreConstants.COMMON_Y);
		newAgency.setIsLoginable(CoreConstants.COMMON_Y);
		newAgency.setIsPublished(CoreConstants.COMMON_Y);
		agencyDAO.insert(newAgency);
		return Bean.toModel(newAgency, agencyModel);
	}

	/**
	 * 地址汉化
	 * @param currentAgency 商家PO
	 * @throws Exception
	 */
	private void setLocationNames(Agency currentAgency) throws Exception {
		//根据省市区编码 获取对应汉字名称数组
		List<String> locationNames = locationInfoSerevice.getLocationSummary(
				currentAgency.getProvince(), currentAgency.getCity(), currentAgency.getRegion());
		if (!ValidationUtil.isEmpty(locationNames) && locationNames.size() == 3) {
			currentAgency.setAddressDetail(StringUtils.join(locationNames, " ") + " " + currentAgency.getAgencyAddress());
			currentAgency.setExtend1(locationNames.get(0));
			currentAgency.setExtend2(locationNames.get(1));
			currentAgency.setExtend3(locationNames.get(2));
		}
	}

	@Override
	public AgencyModel updateAgency(AgencyModel agencyModel) throws Exception {
		Agency currentAgency = agencyDAO.findByAgencyCode(agencyModel.getAgencyCode());
		if(ValidationUtil.isEmpty(currentAgency)){
			throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
		}
		Bean.copyExistPropertis(agencyModel, currentAgency);
		this.setLocationNames(currentAgency);
		agencyDAO.update(currentAgency);

		return Bean.toModel(currentAgency, agencyModel);
	}

	@Override
	public AgencyModel updateLockStatus(String agencyCode) throws Exception {
		Agency currentAgency = agencyDAO.findByAgencyCode(agencyCode);
		if(ValidationUtil.isEmpty(currentAgency)){
			throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
		}
		
		String lockStatus = CoreConstants.COMMON_Y.equals(currentAgency.getLockStatus()) ? CoreConstants.COMMON_N : CoreConstants.COMMON_Y;
		currentAgency.setRecDate(new Date());
		currentAgency.setLockStatus(lockStatus);
		if(CoreConstants.COMMON_Y.equals(lockStatus)){
			currentAgency.setLockDate(new Date());
			currentAgency.setLockUserId(RequestContext.getExeUserId());
		}
		agencyDAO.update(currentAgency);
		return Bean.toModel(currentAgency, new AgencyModel());
	}

	@Override
	public AgencyModel getAgencyByCode(String agencyCode) throws Exception {
		AgencyModel agencyModel = Bean.toModel(agencyDAO.findByAgencyCode(agencyCode), new AgencyModel());
		return agencyModel;
	}
	
	@Override
	public Page getAgencyByPage(String agencyCode, String agencyName, String province, String city, String region,
			Page page, String orderBy, String order) throws Exception {
		List<AgencyModel> agencyModels = 
				Bean.toModels(agencyDAO.findAgencyByPage(agencyCode, agencyName, province, city, region, page, orderBy, order),AgencyModel.class);
		page.setList(agencyModels);
		return page;
	}

	@Override
	public boolean isAgencyNameAvailable(String agencyName, Long id) throws Exception {
		return agencyDAO.isAgencyNameAvailable(agencyName, id);
	}

	@Override
	public boolean isAgencyCodeAvailable(String agencyCode, Long id) throws Exception {
		return agencyDAO.isAgencyCodeAvailable(agencyCode, id);
	}

	@Override
	public Long getMaxAgencyCode() throws Exception {
		return agencyDAO.findMaxAgencyCode();
	}
}
