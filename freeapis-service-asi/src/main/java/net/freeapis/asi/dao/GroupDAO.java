package net.freeapis.asi.dao;

import java.util.List;

import net.freeapis.asi.face.entity.Group;
import net.freeapis.core.mysql.GenericDAO;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: GroupDao.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: GroupDao.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
public interface GroupDAO extends GenericDAO<Group> {
	
	void insertWithCache(Group group) throws Exception;

	void deleteWithCache(String agencyCode, String groupCode) throws Exception;

	void updateWithCache(Group group) throws Exception;

	Group findGroup(String agencyCode, String groupCode) throws Exception;

	List<Group> findGroupByParentCode(String agencyCode,String parentCode) throws Exception;
	
	boolean hasChildrenGroup(String agencyCode,String parentCode) throws Exception;

    int findLockStatusCount(Integer nodeLevel, String parentGroupCode)throws Exception;

	List<Group> findByParentCode(String groupCode)throws Exception;
}
