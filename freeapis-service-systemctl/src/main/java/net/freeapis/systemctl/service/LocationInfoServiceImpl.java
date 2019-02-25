package net.freeapis.systemctl.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.ParamConstants;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.BaseServiceImpl;
import net.freeapis.systemctl.dao.LocationInfoDAO;
import net.freeapis.systemctl.face.constants.SystemConstants;
import net.freeapis.systemctl.face.model.LocationInfoModel;
import net.freeapis.systemctl.face.entity.LocationInfo;
import net.freeapis.systemctl.face.LocationInfoService;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: LocationInfoServiceImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  <p>位置信息服务,提供对位置信息Service层的实现接口
 * 
 *  Notes:
 *  $Id: LocationInfoServiceImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年07月14日		framework		Initial.
 *
 * </pre>
 */
@Service(value = "locationInfoService")
public class LocationInfoServiceImpl extends BaseServiceImpl<LocationInfoModel, LocationInfo>
		implements LocationInfoService {
	@Autowired
	private LocationInfoDAO locationInfoDAO;

	@Override
	public List<Map<String, Object>> buildLocationTree() throws Exception {
		//#1 从缓存中查询所有位置信息
		List<Map<String, Object>> allLocations = Redis.get(SystemConstants.CACHE_KEY_PREFIX_ALL_LOCATIONS);
		//#2 当缓存中不存在从数据库查询，否则直接返回
		if(ValidationUtil.isEmpty(allLocations)){
			allLocations = locationInfoDAO.findSimpleByParentCode(ParamConstants.ROOT_LOCATION_CODE);
			if(!ValidationUtil.isEmpty(allLocations)){
				for(Map<String,Object> location : allLocations){
					this.buildChildLocations(location);
				}
				//将查询的数据放入缓存
				Redis.set(allLocations,SystemConstants.CACHE_KEY_PREFIX_ALL_LOCATIONS);
			}
		}
		return allLocations;
	}

	/**
	 * 递归查找下一级位置信息
	 * @param currentLocation 位置信息
	 * @throws Exception
	 */
	private void buildChildLocations(Map<String,Object> currentLocation) throws Exception{
		List<Map<String, Object>> childLocations =
				locationInfoDAO.findSimpleByParentCode((String)currentLocation.get("locationCode"));
		if(!ValidationUtil.isEmpty(childLocations)){
			currentLocation.put("children",childLocations);
			for(Map<String,Object> location : childLocations){
				this.buildChildLocations(location);
			}
		}
	}

	@Override
	public LocationInfoModel getByCode(String locationCode) throws Exception {
		return Bean.toModel(locationInfoDAO.findByCode(locationCode), new LocationInfoModel());
	}

	@Override
	public List<LocationInfoModel> getProvinces() throws Exception {
		//#1 从缓存中查询省位置信息
		List<LocationInfoModel> result = Redis.get(SystemConstants.CACHE_KEY_PREFIX_PROVINCE);
		//#2 当缓存中不存在从数据库查询，否则直接返回
		if (ValidationUtil.isEmpty(result)) {
			result = Bean.toModels(locationInfoDAO.findByParentCode(
					ParamConstants.ROOT_LOCATION_CODE),LocationInfoModel.class);
			if (!ValidationUtil.isEmpty(result)) {
				//将查到的数据放入缓存
				Redis.set(result, SystemConstants.CACHE_KEY_PREFIX_PROVINCE);
			}
		}
		return result;
	}

	@Override
	public List<LocationInfoModel> getCitiesByProvince(String provinceCode) throws Exception {
		//#1 从缓存中查询市位置信息
		List<LocationInfoModel> result = Redis.get(SystemConstants.CACHE_KEY_PREFIX_PROVINCE, provinceCode,
				SystemConstants.CACHE_KEY_PREFIX_CITY);
		//#2 当缓存中不存在从数据库查询，否则直接返回
		if (ValidationUtil.isEmpty(result)) {
			result = Bean.toModels(locationInfoDAO.findByParentCode(provinceCode),LocationInfoModel.class);
			if (!ValidationUtil.isEmpty(result)) {
				Redis.set(result, SystemConstants.CACHE_KEY_PREFIX_PROVINCE, provinceCode,
						SystemConstants.CACHE_KEY_PREFIX_CITY);
			}
		}
		return result;
	}

	@Override
	public List<LocationInfoModel> getRegionsByCity(String cityCode) throws Exception {
		//#1 从缓存中查询县/区位置信息
		List<LocationInfoModel> result = Redis.get(SystemConstants.CACHE_KEY_PREFIX_CITY, cityCode,
				SystemConstants.CACHE_KEY_PREFIX_REGION);
		//#2 当缓存中不存在从数据库查询，否则直接返回
		if (ValidationUtil.isEmpty(result)) {
			result = Bean.toModels(locationInfoDAO.findByParentCode(cityCode),LocationInfoModel.class);
			if (!ValidationUtil.isEmpty(result)) {
				Redis.set(result, SystemConstants.CACHE_KEY_PREFIX_CITY, cityCode,
						SystemConstants.CACHE_KEY_PREFIX_REGION);
			}
		}
		return result;
	}

	@Override
	public List<String> getLocationSummary(String provinceCode, String cityCode, String regionCode) throws Exception {
		return locationInfoDAO.findLocationSummary(provinceCode,cityCode,regionCode);
	}
}
