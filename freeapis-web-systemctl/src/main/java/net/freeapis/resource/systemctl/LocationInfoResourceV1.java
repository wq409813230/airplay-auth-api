package net.freeapis.resource.systemctl;


import net.freeapis.core.rest.BaseResources;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.core.rest.containers.FreeapisOperation;
import net.freeapis.core.rest.containers.FreeapisResource;
import net.freeapis.core.rest.utils.ResponseHelper;
import net.freeapis.core.rest.utils.ResponseModel;
import net.freeapis.systemctl.face.LocationInfoService;
import net.freeapis.systemctl.face.model.LocationInfoModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: LocationInfoResourceV1.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: LocationInfoResourceV1.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年10月15日		freeapis		Initial.
 *
 * </pre>
 */
@RestController
@RequestMapping(value = "/1/location")
@FreeapisResource(module = "systemctl",value = "LocationInfoResourceV1", description = "位置信息管理")
public class LocationInfoResourceV1 extends BaseResources {

	@Autowired
	private LocationInfoService locationService;

	@FreeapisOperation(name = "getAllLocations", ApiLevel = APILevel.ALL,  description = "同步获取所有位置信息(树形结构)")
	@RequestMapping(value = "/all", method = RequestMethod.GET)
	public ResponseModel<List<Map<String,Object>>> getAllLocations() throws Exception {
		return ResponseHelper.buildResponseModel(locationService.buildLocationTree());
	}
	
	@FreeapisOperation(name = "getProvince", ApiLevel = APILevel.ALL,  description = "获取所有省份列表")
	@RequestMapping(value = "/provinces", method = RequestMethod.GET)
	public ResponseModel<List<LocationInfoModel>> getProvince() throws Exception {
		return ResponseHelper.buildResponseModel(locationService.getProvinces());
	}

	@FreeapisOperation(name = "getCitiesByProvince", ApiLevel = APILevel.ALL,  description = "根据省份获取城市列表")
	@RequestMapping(value = "/{provinceCode}/cities", method = RequestMethod.GET)
	public ResponseModel<List<LocationInfoModel>> getCitiesByProvince(
			@PathVariable String provinceCode) throws Exception {
		return ResponseHelper.buildResponseModel(locationService.getCitiesByProvince(provinceCode));
	}
	
	@FreeapisOperation(name = "getRegionsByCity", ApiLevel = APILevel.ALL,  description = "根据市获取县/区列表")
	@RequestMapping(value = "/{cityCode}/regions", method = RequestMethod.GET)
	public ResponseModel<List<LocationInfoModel>> getRegionsByCity(
			@PathVariable String cityCode) throws Exception {
		return ResponseHelper.buildResponseModel(locationService.getRegionsByCity(cityCode));
	}

	@FreeapisOperation(name = "getByCode", ApiLevel = APILevel.ALL,  description = "根据位置编码获取位置信息")
	@RequestMapping(value = "/{locationCode}", method = RequestMethod.GET)
	public ResponseModel<LocationInfoModel> getByCode(@PathVariable String locationCode)
			throws Exception {
		return ResponseHelper.buildResponseModel(locationService.getByCode(locationCode));
	}

}

/*
 * $Log: av-env.bat,v $
 */