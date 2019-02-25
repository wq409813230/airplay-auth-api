package net.freeapis.asi.dao;

import java.util.List;
import java.util.Map;

import net.freeapis.asi.face.entity.GroupColumn;
import net.freeapis.core.mysql.GenericDAO;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: GroupColumnDao.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: GroupColumnDao.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
public interface GroupColumnDAO extends GenericDAO<GroupColumn> {
	
	Map<String, GroupColumn> findGroupColumnsMap(String agencyCode, String groupCode)
			throws Exception;

	void insertWithCache(GroupColumn groupColumn) throws Exception;

	void deleteWithCache(String agencyCode, String groupCode,String columnCode) throws Exception;

	void updateWithCache(GroupColumn groupColumn) throws Exception;

	GroupColumn findGroupColumn(String agencyCode, String groupCode, String columnCode)
			throws Exception;

	List<GroupColumn> findGroupColumns(String agencyCode, String groupCode) throws Exception;
}
