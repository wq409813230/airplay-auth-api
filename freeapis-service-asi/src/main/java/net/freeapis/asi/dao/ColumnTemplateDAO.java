package net.freeapis.asi.dao;

import java.util.List;

import net.freeapis.asi.face.entity.ColumnTemplate;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.mysql.GenericDAO;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: ColumnTemplateDao.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: ColumnTemplateDao.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
public interface ColumnTemplateDAO extends GenericDAO<ColumnTemplate> {
	
	void insertWithCache(ColumnTemplate columnTemplate) throws Exception;

	void deleteWithCache(String agencyCode, String columnCode) throws Exception;

	void updateWithCache(ColumnTemplate columnTemplate) throws Exception;

	ColumnTemplate getWithCache(String agencyCode, String columnCode) throws Exception;

	List<ColumnTemplate> findColumnTemplateByPage(String agencyCode, String columnCode, String columnName,
			Page page,String orderBy,String order) throws Exception;
}
