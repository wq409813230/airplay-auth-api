package net.freeapis.asi.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.freeapis.asi.face.constants.ASIConstants;
import net.freeapis.core.foundation.constants.CoreConstants;
import org.springframework.stereotype.Repository;

import net.freeapis.asi.dao.GroupDAO;
import net.freeapis.asi.face.entity.Group;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.GenericDAOImpl;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: GroupDaoImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: GroupDaoImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
@Repository(value="groupDAO")
public class GroupDAOImpl extends GenericDAOImpl<Group> implements GroupDAO
{

	@Override
	public void insertWithCache(Group group) throws Exception {
		this.insert(group);
		Redis.setSingle(group,group.getAgencyCode(),group.getGroupCode());
		Redis.remove(ASIConstants.CACHE_KEY_ALL_LOCK_STATUS);
	}

	@Override
	public void deleteWithCache(String agencyCode, String groupCode) throws Exception {
		Group currentGroup = this.findGroup(agencyCode, groupCode);
		if(!ValidationUtil.isEmpty(currentGroup)){
			StringBuilder deleteSql = new StringBuilder(" DELETE FROM "+ this.tableName() +" WHERE 1=1 ")
					.append(" AND GROUP_CODE = :GROUP_CODE AND AGENCY_CODE = :AGENCY_CODE ");
			Map<String , Object> params = new HashMap<String , Object>();
	        params.put("GROUP_CODE",groupCode);
	        params.put("AGENCY_CODE",agencyCode);
	        this.update(deleteSql.toString(), params);
	        Redis.removeSingle(this.getEntityClass(), agencyCode,groupCode);
		}
	}

	@Override
	public void updateWithCache(Group group) throws Exception {
		this.update(group);
		Redis.setSingle(group,group.getAgencyCode(),group.getGroupCode());
		Redis.remove(ASIConstants.CACHE_KEY_ALL_LOCK_STATUS);
	}

	@Override
	public Group findGroup(String agencyCode, String groupCode) throws Exception {
		Group result = Redis.getSingle(this.getEntityClass(), agencyCode,groupCode);
    	if(ValidationUtil.isEmpty(result)){
    		StringBuilder sql = new StringBuilder(" AND GROUP_CODE = :GROUP_CODE AND AGENCY_CODE = :AGENCY_CODE ");
    		Map<String , Object> params = new HashMap<String , Object>();
            params.put("GROUP_CODE",groupCode);
            params.put("AGENCY_CODE",agencyCode);
            result = this.findFirst(sql.toString(),params);
            if(!ValidationUtil.isEmpty(result)){
            	Redis.setSingle(result,result.getAgencyCode(),result.getGroupCode());
            }
    	}
        return result;
	}

	@Override
	public List<Group> findGroupByParentCode(String agencyCode, String parentCode) throws Exception {
		StringBuilder sql = new StringBuilder()
				.append(" AND AGENCY_CODE = :AGENCY_CODE ")
				.append(" AND PARENT_GROUP_CODE = :PARENT_GROUP_CODE ");
		Map<String , Object> params = new HashMap<String , Object>();
		params.put("AGENCY_CODE",agencyCode);
		params.put("PARENT_GROUP_CODE",parentCode);
		return this.find(sql.toString(), params, "groupOrder", "asc");
	}

	@Override
	public boolean hasChildrenGroup(String agencyCode, String parentCode) throws Exception {
		StringBuilder sql = new StringBuilder()
				.append(" AND AGENCY_CODE = :AGENCY_CODE ")
				.append(" AND PARENT_GROUP_CODE = :PARENT_GROUP_CODE ");
		Map<String , Object> params = new HashMap<String , Object>();
		params.put("AGENCY_CODE",agencyCode);
		params.put("PARENT_GROUP_CODE",parentCode);
		return this.findCount(sql.toString(), params) > 0;
	}

	@Override
	public int findLockStatusCount(Integer nodeLevel, String parentGroupCode) throws Exception {
		StringBuilder sql = new StringBuilder(" AND PARENT_GROUP_CODE = :GROUP_CODE AND LOCK_STATUS = :LOCK_STATUS AND NODE_LEVEL = :NODE_LEVEL");
		Map<String,Object> params = new HashMap<>();
		params.put("GROUP_CODE",parentGroupCode);
		params.put("NODE_LEVEL",nodeLevel);
		params.put("LOCK_STATUS", CoreConstants.COMMON_Y);
		return this.findCount(sql.toString(), params).intValue();
	}

	@Override
	public List<Group> findByParentCode(String groupCode) throws Exception {
		StringBuilder sql = new StringBuilder(" AND PARENT_GROUP_CODE = :PARENT_GROUP_CODE AND LOCK_STATUS = :LOCK_STATUS");
		Map<String , Object> params = new HashMap<>();
		params.put("PARENT_GROUP_CODE",groupCode);
		params.put("LOCK_STATUS",CoreConstants.COMMON_Y);
		return this.find(sql.toString(), params, "groupOrder", "asc");
	}

}
