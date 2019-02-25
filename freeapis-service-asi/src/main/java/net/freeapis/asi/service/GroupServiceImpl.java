package net.freeapis.asi.service;

import net.freeapis.asi.dao.GroupColumnDAO;
import net.freeapis.asi.dao.GroupDAO;
import net.freeapis.asi.face.ASIService;
import net.freeapis.asi.face.GroupService;
import net.freeapis.asi.face.constants.ASIConstants;
import net.freeapis.asi.face.entity.Group;
import net.freeapis.asi.face.model.GroupModel;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.exceptions.DataValidateException;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: GroupServiceImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: GroupServiceImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
@Service(value="groupService")
public class GroupServiceImpl extends BaseServiceImpl<GroupModel, Group> implements GroupService
{
	@Autowired
	private GroupDAO groupDAO;
	
	@Autowired
	private GroupColumnDAO groupColumnDAO;

	@Autowired
	private ASIService asiService;
	
	@Override
	public GroupModel createGroup(GroupModel groupModel) throws Exception {
		if (ValidationUtil.isEmpty(groupModel)) {
			throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
		}
		Group newGroup = Bean.toPo(groupModel, new Group());
		if(ValidationUtil.isEmpty(newGroup.getDisplayMeta())){
			newGroup.setDisplayMeta(CoreConstants.COMMON_Y);
		}
		if(ValidationUtil.isEmpty(newGroup.getParentGroupCode())){
			newGroup.setParentGroupCode(ASIConstants.ROOT_GROUP_CODE);
		}
		if(ValidationUtil.isEmpty(groupModel.getGroupCode())){
			newGroup.setGroupCode(String.valueOf(sequenceGenerator.getNextValue()));
		}
		newGroup.setAgencyCode(RequestContext.getAgencyCode());
		newGroup.setRecDate(new Date());
		newGroup.setRecStatus(CoreConstants.COMMON_ACTIVE);
		newGroup.setRecUserId(RequestContext.getExeUserId());
		newGroup.setLockStatus(CoreConstants.COMMON_N);
		groupDAO.insertWithCache(newGroup);
		return Bean.toModel(newGroup, groupModel);
	}

	@Override
	public String deleteGroup(String agencyCode, String groupCode) throws Exception {
		List<String> error = new ArrayList<String>();
		if(groupDAO.hasChildrenGroup(agencyCode, groupCode)){
			error.add("该分组存在子分组,不能删除.");
		}
		if(!ValidationUtil.isEmpty(groupColumnDAO.findGroupColumns(agencyCode, groupCode))){
			error.add("该分组存在列定义,不能删除.");
		}
		if(!ValidationUtil.isEmpty(error)){
			return Arrays.toString(error.toArray(new String[]{}));
		}
		groupDAO.deleteWithCache(agencyCode, groupCode);
		return null;
	}

	@Override
	public GroupModel updateGroup(GroupModel groupModel) throws Exception {
		Group currentGroup = groupDAO.findGroup(groupModel.getAgencyCode(), groupModel.getGroupCode());
		if (ValidationUtil.isEmpty(currentGroup)) {
			throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
		}
		Bean.copyExistPropertis(groupModel,currentGroup);
		currentGroup.setGroupOrder(groupModel.getGroupOrder());
		currentGroup.setGroupName(groupModel.getGroupName());
		currentGroup.setDisplayMeta(groupModel.getDisplayMeta());
		if(ValidationUtil.isEmpty(currentGroup.getDisplayMeta())){
			currentGroup.setDisplayMeta(CoreConstants.COMMON_Y);
		}
		currentGroup.setRecDate(new Date());
		currentGroup.setRecUserId(RequestContext.getExeUserId());
		groupDAO.updateWithCache(currentGroup);
		return Bean.toModel(currentGroup, groupModel);
	}

	@Override
	public GroupModel getGroup(String agencyCode, String groupCode) throws Exception {
		GroupModel result = Bean.toModel(groupDAO.findGroup(agencyCode, groupCode), new GroupModel());
		if(!ValidationUtil.isEmpty(result)) this.setHasChildren(result);
		return result;
	}

	@Override
	public List<GroupModel> getGroupsByParentCode(String agencyCode, String parentCode) throws Exception {
		List<GroupModel> result = Bean.toModels(groupDAO.findGroupByParentCode(agencyCode, parentCode),GroupModel.class);
		for(GroupModel currentGroup : result){
			this.setHasChildren(currentGroup);
		}
		return result;
	}
	
	private void setHasChildren(GroupModel currentGroup) throws Exception{
		currentGroup.setHasChildren(groupDAO.hasChildrenGroup(currentGroup.getAgencyCode(),currentGroup.getGroupCode()));
	}

	@Override
	public boolean isGroupCodeAvailable(String agencyCode, String groupCode) throws Exception {
		return ValidationUtil.isEmpty(groupDAO.findGroup(agencyCode, groupCode));
	}

	@Override
	public GroupModel buildGruopTree(String agencyCode,String parentCode) throws Exception {
		GroupModel result;
		if(ASIConstants.ROOT_GROUP_CODE.equals(parentCode)){
			result = new GroupModel();
			result.setNodeLevel(ASIConstants.ROOT_GROUP_LEVEL);
			result.setGroupCode(ASIConstants.ROOT_GROUP_CODE);
			result.setGroupName(ASIConstants.ROOT_GROUP_NAME);
		}else{
			result = Bean.toModel(groupDAO.findGroup(agencyCode,parentCode),new GroupModel());
		}

		this.buildChildGroup(agencyCode, result);
		return result;
	}

	@Override
	public GroupModel updateLockStatus(String agencyCode, String groupCode) throws Exception {
		Group group = groupDAO.findGroup(agencyCode, groupCode);
		if(!ValidationUtil.isEmpty(group)){
			group.setLockStatus(group.getLockStatus().equals(CoreConstants.COMMON_N) ? CoreConstants.COMMON_Y : CoreConstants.COMMON_N);
			group.setRecUserId(RequestContext.getExeUserId());
			group.setRecDate(new Date());
			groupDAO.updateWithCache(group);
		}
		return Bean.toModel(group,new GroupModel());
	}

	@Override
	public int getLockStatusCount(Integer nodeLevel, String parentGroupCode) throws Exception {
		return groupDAO.findLockStatusCount(nodeLevel,parentGroupCode);
	}

	@Override
	public GroupModel buildEnableTree(String agencyCode, String parentCode) throws Exception {
		GroupModel groupModel = Redis.get(ASIConstants.CACHE_KEY_ALL_LOCK_STATUS);
		if(ValidationUtil.isEmpty(groupModel)){
			Group group = groupDAO.findGroup(agencyCode, parentCode);
			if(!ValidationUtil.isEmpty(group)){
				groupModel = Bean.toModel(group, new GroupModel());
			}
			if(!ValidationUtil.isEmpty(groupModel)) {
				buildChildEnable(groupModel);
			}
			Redis.set(groupModel,ASIConstants.CACHE_KEY_ALL_LOCK_STATUS);
		}
		return groupModel;
	}

	@Override
	public void deleteGroupByGroupCode(String agencyCode, String groupCode) throws Exception {
		if(groupDAO.hasChildrenGroup(agencyCode, groupCode)){
			throw new DataValidateException("该分组存在子分组,不能删除.");
		}
		groupDAO.deleteWithCache(agencyCode, groupCode);
		asiService.deleteByGroupCode(agencyCode,groupCode);
		Redis.removeByPrefix(ASIConstants.ASIVALUE_CACHEKEY_PREFIX);
	}

	private void buildChildGroup(String agencyCode, GroupModel parentGroup) throws Exception {
		List<GroupModel> children = Bean.toModels(groupDAO.findGroupByParentCode(agencyCode,parentGroup.getGroupCode()),GroupModel.class);
		if (!ValidationUtil.isEmpty(children)) {
			parentGroup.setHasChildren(true);
			parentGroup.setChildren(children);
			for (GroupModel child : children) {
				this.buildChildGroup(agencyCode,child);
			}
		} else {
			parentGroup.setHasChildren(false);
		}
	}

	private void buildChildEnable(GroupModel groupModel) throws Exception{
		List<GroupModel> children = Bean.toModels(groupDAO.findByParentCode(groupModel.getGroupCode()),GroupModel.class);
		if (!ValidationUtil.isEmpty(children)) {
			groupModel.setHasChildren(true);
			groupModel.setChildren(children);
			for (GroupModel model : children) {
				this.buildChildEnable(model);
			}
		} else {
			groupModel.setHasChildren(false);
		}
	}

}
