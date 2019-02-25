package net.freeapis.systemctl.dao.impl;

import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.GenericDAOImpl;
import net.freeapis.systemctl.dao.LocationInfoDAO;
import net.freeapis.systemctl.face.entity.LocationInfo;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: LocationInfoDaoImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  <p>位置信息服务,提供对位置信息DAO层的实现接口
 * 
 *  Notes:
 *  $Id: LocationInfoDaoImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年07月14日		framework		Initial.
 *
 * </pre>
 */
@Repository(value="locationInfoDAO")
public class LocationInfoDAOImpl extends GenericDAOImpl<LocationInfo> implements LocationInfoDAO
{

	@Override
	public List<Map<String, Object>> findSimpleByParentCode(String parentCode) throws Exception {
		StringBuilder sql = new StringBuilder()
				.append("SELECT S.LOCATION_NAME AS locationName,")
				.append("S.LOCATION_CODE AS locationCode,")
				.append("S.LOCATION_TYPE AS locationType ")
				.append(" FROM ").append(this.tableName()).append(" S ")
				.append("WHERE S.PARENT_CODE = :PARENT_CODE ORDER BY S.LOCATION_CODE ASC");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("PARENT_CODE", parentCode);
		return this.findMaps(sql.toString(),params);
	}

	@Override
	public List<LocationInfo> findByParentCode(String parentCode) throws Exception {
		StringBuilder sqlSufix = new StringBuilder();
		Map<String, Object> params = new HashMap<String, Object>();
		if (!ValidationUtil.isEmpty(parentCode)) {
			sqlSufix.append(" AND PARENT_CODE = :PARENT_CODE ");
			params.put("PARENT_CODE", parentCode);
		}
		return this.find(sqlSufix.toString(), params, "locationCode","asc");
	}

	@Override
	public LocationInfo findByCode(String locationCode) throws Exception {
		StringBuilder sqlSufix = new StringBuilder(" AND LOCATION_CODE = :LOCATION_CODE ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("LOCATION_CODE", locationCode);
		return this.findFirst(sqlSufix.toString(), params);
	}

	@Override
	public List<String> findLocationSummary(String provinceCode, String cityCode, String regionCode) throws Exception {
		StringBuilder sql = new StringBuilder(" SELECT LOCATION_NAME FROM SYSTEMCTL_LOCATION_INFO WHERE LOCATION_CODE = :PROVINCE_CODE ")
											.append(" UNION ")
											.append(" SELECT LOCATION_NAME FROM SYSTEMCTL_LOCATION_INFO WHERE LOCATION_CODE = :CITY_CODE ")
											.append(" UNION ")
											.append(" SELECT LOCATION_NAME FROM SYSTEMCTL_LOCATION_INFO WHERE LOCATION_CODE = :REGION_CODE ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("PROVINCE_CODE", provinceCode);
		params.put("CITY_CODE", cityCode);
		params.put("REGION_CODE", regionCode);
		return this.findObjects(sql.toString(), params);
	}
}
