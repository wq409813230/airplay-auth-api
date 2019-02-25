package net.freeapis.systemctl.face;

import net.freeapis.core.foundation.orm.BaseService;
import net.freeapis.systemctl.face.entity.LocationInfo;
import net.freeapis.systemctl.face.model.LocationInfoModel;

import java.util.List;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: LocationInfoService.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  <p>位置信息服务,提供基础的位置信息Service层接口
 * 
 *  Notes:
 *  $Id: LocationInfoService.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年10月28日		freeapis		Initial.
 *
 * </pre>
 */
public interface LocationInfoService extends BaseService<LocationInfoModel, LocationInfo> {

	/**
	 * 构建位置信息树,APP端展示位置信息时为了减少接口调用次数,会一次性将位置信息返回
	 * @return 以List<Map>的形式返回,形如:
	 * <code>
	 *   [
	 *     {
	 *     "key1": "value1",
	 *     "key2": "value2"
	 *     },
	 *     {
	 *     "kay1": "value1",
	 *     "key2": "value2"
	 *     }
	 *   ]
	 * </code>
	 * @throws Exception
	 */
	List<Map<String,Object>> buildLocationTree() throws Exception;

	/**
	 * TODO. 通过code获得具体的位置信息
	 * @param locationCode 位置编码
	 * @return LocationInfoModel
	 * @throws Exception
	 */
	 LocationInfoModel getByCode(String locationCode) throws Exception;
	 /**
	  * TODO.获取所有的省
	  * @return 省位置列表
	  * @throws Exception
	  */
	 List<LocationInfoModel> getProvinces() throws Exception;
	 /**
	  * TODO.根据省获取所有的市
	  * @param provinceCode 省位置编码，即父编码(parentCode)
	  * @return 市位置列表
	  * @throws Exception
	  */
	 List<LocationInfoModel> getCitiesByProvince(String provinceCode) throws Exception;
	 /**
	  * TODO.根据市获取所有的县/区
	  * @param cityCode 市位置编码，即父编码(parentCode)
	  * @return 县/区位置列表
	  * @throws Exception
	  */
	 List<LocationInfoModel> getRegionsByCity(String cityCode) throws Exception;
	 /**
	  * TODO.获取省市区名称
	  * @param provinceCode 省位置编码
	  * @param cityCode 市位置编码
	  * @param regionCode 县/区位置编码
	  * @return
	  * @throws Exception 获取省市区名称异常
	  */
	 List<String> getLocationSummary(String provinceCode, String cityCode, String regionCode) throws Exception;
}

/*
 * $Log: av-env.bat,v $
 */