package net.freeapis.systemctl.dao;

import java.util.List;
import java.util.Map;

import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.systemctl.face.entity.LocationInfo;

/**
 * <pre>
 * 
 *  freeapis
 *  File: AgMemCardTypeDao.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  <p>位置信息服务,提供位置信息DAO层接口
 * 
 *  Notes:
 * 	$Id: AgMemCardTypeDao.java 72642 2015年1月9日 freeapis\zhaoqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年1月9日		zhaoqiang		Initial.
 *  
 * </pre>
 */
public interface LocationInfoDAO extends GenericDAO<LocationInfo> 
{
	/**
	 * 获取位置信息的简要字段
	 * @param parentCode 父编码
	 * @return 以List<Map>的形式返回,形如:
	 * <code>
	 *     [
	 *     {
	 *         "key1":"value1",
	 *         "key2":"value2"
	 *     },
	 *     {
	 *         "key1":"value1",
	 *         "key2":"value2"
	 *     }
	 *     ]
	 * </code>
	 * @throws Exception
	 */
	List<Map<String,Object>> findSimpleByParentCode(String parentCode) throws Exception;

	/**
	 * TODO.根据父级位置编码获取子位置列表
	 * @param parentCode 父编码
	 * @return 子位置列表
	 * @throws Exception
	 */
	List<LocationInfo> findByParentCode(String parentCode) throws Exception;
	/**
	 * TODO.根据位置编码获取位置信息
	 * @param locationCode 位置编码
	 * @return LocationInfo
	 * @throws Exception
	 */
	LocationInfo findByCode(String locationCode) throws Exception;
	/**
	 * TODO.查询位置的省市区信息
	 * @param provinceCode 省位置编码
	 * @param cityCode  市位置编码
	 * @param regionCode 县/区位置编码
	 * @return
	 * @throws Exception 
	 */
	List<String> findLocationSummary(String provinceCode, String cityCode, String regionCode) throws Exception;
}

/*
*$Log: av-env.bat,v $
*/