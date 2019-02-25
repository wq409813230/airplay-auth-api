package net.freeapis.asi.service;

import java.util.Date;

import net.freeapis.core.foundation.exceptions.DataValidateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.freeapis.asi.dao.ColumnTemplateDAO;
import net.freeapis.asi.face.model.ColumnTemplateModel;
import net.freeapis.asi.face.entity.ColumnTemplate;
import net.freeapis.asi.face.ColumnTemplateService;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.exceptions.BusinessException;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.BaseServiceImpl;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: ColumnTemplateServiceImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: ColumnTemplateServiceImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
@Service(value="columnTemplateService")
public class ColumnTemplateServiceImpl extends BaseServiceImpl<ColumnTemplateModel, ColumnTemplate> implements ColumnTemplateService
{
	@Autowired
	private ColumnTemplateDAO columnTemplateDAO;

	@Override
	public ColumnTemplateModel createColumnTemplate(ColumnTemplateModel columnTemplateModel) throws Exception {
		if(ValidationUtil.isEmpty(columnTemplateModel)){
			throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
		}
		ColumnTemplate newColumn = Bean.toPo(columnTemplateModel, new ColumnTemplate());
		newColumn.setRecDate(new Date());
		newColumn.setRecStatus(CoreConstants.COMMON_ACTIVE);
		newColumn.setRecUserId(RequestContext.getExeUserId());
		columnTemplateDAO.insertWithCache(newColumn);
		return Bean.toModel(newColumn, columnTemplateModel);
	}

	@Override
	public String deleteColumnTemplate(String agencyCode, String columnCode) throws Exception {
		columnTemplateDAO.deleteWithCache(agencyCode, columnCode);
		return null;
	}

	@Override
	public ColumnTemplateModel updateColumnTemplate(ColumnTemplateModel columnTemplateModel) throws Exception {
		ColumnTemplate currentColumn = columnTemplateDAO.getWithCache(columnTemplateModel.getAgencyCode(), columnTemplateModel.getColumnCode());
		if(ValidationUtil.isEmpty(currentColumn)){
			throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
		}
		Bean.copyExistPropertis(columnTemplateModel, currentColumn);
		currentColumn.setRecDate(new Date());
		currentColumn.setRecUserId(RequestContext.getExeUserId());
		columnTemplateDAO.updateWithCache(currentColumn);
		return Bean.toModel(currentColumn, columnTemplateModel);
	}

	@Override
	public ColumnTemplateModel getColumnTemplate(String agencyCode, String columnCode) throws Exception {
		return Bean.toModel(columnTemplateDAO.getWithCache(agencyCode, columnCode), new ColumnTemplateModel());
	}

	@Override
	public Page getColumnTemplateByPage(String agencyCode, String columnCode, String columnName,
			Page page,String orderBy,String order) throws Exception {
		page.setList(Bean.toModels(columnTemplateDAO.findColumnTemplateByPage(agencyCode, columnCode,columnName,page,orderBy,order),ColumnTemplateModel.class));
		return page;
	}

	@Override
	public boolean isColumnCodeAvailable(String agencyCode, String columnCode) throws Exception {
		return ValidationUtil.isEmpty(columnTemplateDAO.getWithCache(agencyCode, columnCode));
	}

}
