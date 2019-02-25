package net.freeapis.agency.dao;

import java.util.List;

import net.freeapis.agency.face.entity.Agency;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.mysql.GenericDAO;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AgAgencyDao.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * Description:机构的数据访问接口
 *  Notes:
 *  $Id: AgAgencyDao.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月20日		freeapis		Initial.
 *	@author gaoyuanteng@zhaotai.ren
 * </pre>
 */
public interface AgencyDAO extends GenericDAO<Agency> {
	/**
	 * 根据商家编码获取信息
	 * @param agencyCode 商家编码
	 * @return Agency
	 * @throws Exception
	 */
	Agency findByAgencyCode(String agencyCode) throws Exception;

	/**
	 * 查询商家列表
	 * @param agencyCode 商家编码
	 * @param agencyName 商家名称
	 * @param agencyAlias 商家别名
	 * @param phone1 商家电话
	 * @param adminId 无效参数
	 * @param lockStatus 启禁状态
	 * @return List<Agency>
	 * @throws Exception
	 */
	List<Agency> findAgencies(String agencyCode, String agencyName, String agencyAlias, String phone1,
                              String adminId, String lockStatus) throws Exception;

	/**
	 * 分页查询商家列表
	 * @param agencyCode 商家编码
	 * @param agencyName 商家名称
	 * @param province 省
	 * @param city 市
	 * @param region 区
	 * @param page {@link net.freeapis.core.foundation.model.Page}
	 * @param orderBy 排序字段
	 * @param order 排序方式
	 * @return List<Agency>
	 * @throws Exception
	 */
	List<Agency> findAgencyByPage(String agencyCode, String agencyName, String province, String city,
                                  String region, Page page, String orderBy, String order) throws Exception;

	/**
	 * 验证商家名称是否可用
	 * @param agencyName 商家名称
	 * @param id 主键sequenceNBR
	 * @return 如果名称可以使用返回{@code true} 否则 返回{@code false}
	 * @throws Exception
	 */
	boolean isAgencyNameAvailable(String agencyName, Long id) throws Exception;

	/**
	 * 验证商家编码是否可用
	 * @param agencyCode 商家编码
	 * @param id 主键sequenceNBR
	 * @return 如果名称可以使用返回{@code true} 否则 返回{@code false}
	 * @throws Exception
	 */
	boolean isAgencyCodeAvailable(String agencyCode, Long id) throws Exception;

	/**
	 * 获取最大商家编码
	 * @return long
	 * @throws Exception
	 */
    Long findMaxAgencyCode() throws Exception;
}
/*
 * $Log: av-env.bat,v $
 */