package net.freeapis.asi.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import net.freeapis.core.foundation.exceptions.DataValidateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.freeapis.asi.dao.ColumnTemplateDAO;
import net.freeapis.asi.dao.GroupColumnDAO;
import net.freeapis.asi.face.model.GroupColumnModel;
import net.freeapis.asi.face.entity.ColumnTemplate;
import net.freeapis.asi.face.entity.GroupColumn;
import net.freeapis.asi.face.GroupColumnService;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.exceptions.BusinessException;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.BaseServiceImpl;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: GroupColumnServiceImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: GroupColumnServiceImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
@Service(value="groupColumnService")
public class GroupColumnServiceImpl extends BaseServiceImpl<GroupColumnModel, GroupColumn> implements GroupColumnService
{
	@Autowired
	private GroupColumnDAO groupColumnDAO;
	
	@Autowired
	private ColumnTemplateDAO columnTemplateDAO;

	@Override
	public GroupColumnModel createGroupColumn(GroupColumnModel groupColumnModel) throws Exception {
		if(ValidationUtil.isEmpty(groupColumnModel)){
			throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
		}
		GroupColumn groupColumn = groupColumnDAO.findGroupColumn(groupColumnModel.getAgencyCode(), groupColumnModel.getGroupCode(), groupColumnModel.getColumnCode());
		if(!ValidationUtil.isEmpty(groupColumn)){
			Bean.copyExistPropertis(groupColumnModel, groupColumn);
			groupColumn.setRecDate(new Date());
			groupColumn.setRecUserId(RequestContext.getExeUserId());
			groupColumnDAO.updateWithCache(groupColumn);
		}else{
			groupColumn = Bean.toPo(groupColumnModel, new GroupColumn());
			groupColumn.setRecDate(new Date());
			groupColumn.setRecStatus(CoreConstants.COMMON_ACTIVE);
			groupColumn.setRecUserId(RequestContext.getExeUserId());
			groupColumnDAO.insertWithCache(groupColumn);
		}
		return Bean.toModel(groupColumn, groupColumnModel);
	}

	@Override
	public String deleteGroupColumn(String agencyCode, String groupCode, String columnCode)
			throws Exception {
		groupColumnDAO.deleteWithCache(agencyCode, groupCode,columnCode);
		return null;
	}

	@Override
	public GroupColumnModel updateGroupColumn(GroupColumnModel groupColumnModel) throws Exception {
		GroupColumn currentField = groupColumnDAO.findGroupColumn(groupColumnModel.getAgencyCode(), groupColumnModel.getGroupCode(),groupColumnModel.getColumnCode());
		if(ValidationUtil.isEmpty(currentField)){
			throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
		}
		Bean.copyExistPropertis(groupColumnModel, currentField);
		currentField.setRecDate(new Date());
		currentField.setRecUserId(RequestContext.getExeUserId());
		groupColumnDAO.updateWithCache(currentField);
		return Bean.toModel(currentField, groupColumnModel);
	}

	@Override
	public void copyFromTemplate(String agencyCode, String groupCode, List<Map<String, String>> columnTemplates)
			throws Exception {
		if(!ValidationUtil.isEmpty(columnTemplates)){
			ColumnTemplate currentColumnTemplate = null;
			GroupColumn currentColumn = null;
			for(Map<String,String> template : columnTemplates){
				currentColumnTemplate = columnTemplateDAO.getWithCache(template.get("agencyCode"), template.get("columnCode"));
				currentColumn = groupColumnDAO.findGroupColumn(agencyCode, groupCode, template.get("columnCode"));
				//只有当模板列存在,并且自定义列中没有该模板列时,才进行复制
				if(!ValidationUtil.isEmpty(currentColumnTemplate) && ValidationUtil.isEmpty(currentColumn)){
					currentColumn = new GroupColumn();
					currentColumn.setAgencyCode(agencyCode);
					currentColumn.setGroupCode(groupCode);
					currentColumn.setColumnCode(currentColumnTemplate.getColumnCode());
					currentColumn.setColumnName(currentColumnTemplate.getColumnName());
					currentColumn.setDataType(currentColumnTemplate.getDataType());
					currentColumn.setMaxLength(currentColumnTemplate.getMaxLength());
					currentColumn.setDisplayOrder(currentColumnTemplate.getDisplayOrder());
					currentColumn.setIsDisplay(CoreConstants.COMMON_Y);
					currentColumn.setIsRequired(currentColumnTemplate.getIsRequired());
					currentColumn.setRecDate(new Date());
					currentColumn.setRecStatus(CoreConstants.COMMON_ACTIVE);
					currentColumn.setRecUserId(RequestContext.getExeUserId());
					groupColumnDAO.insertWithCache(currentColumn);
				}
			}
		}
	}

	@Override
	public List<GroupColumnModel> getGroupColumns(String agencyCode, String groupCode) throws Exception {
		List<GroupColumn> result = groupColumnDAO.findGroupColumns(agencyCode, groupCode);
		return Bean.toModels(result,GroupColumnModel.class);
	}

	@Override
	public GroupColumnModel getGroupColumn(String agencyCode, String groupCode, String columnCode) throws Exception {
		return Bean.toModel(groupColumnDAO.findGroupColumn(agencyCode, groupCode,columnCode), new GroupColumnModel());
	}

	@Override
	public boolean isGroupColumnCodeAvailable(String agencyCode, String groupCode, String columnCode) throws Exception {
		return ValidationUtil.isEmpty(groupColumnDAO.findGroupColumn(agencyCode, groupCode,columnCode));
	}

	@Override
	public Map<String, GroupColumn> findGroupColumnsMap(String agencyCode, String groupCode) throws Exception {
		return groupColumnDAO.findGroupColumnsMap(agencyCode,groupCode);
	}

}
