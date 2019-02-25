package net.freeapis.agency.face;

import net.freeapis.agency.face.entity.Agency;
import net.freeapis.agency.face.model.AgencyModel;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.orm.BaseService;

/**
 * <pre>
 * 
 *  freeapis
 *  File: AgencyService.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:商家服务，提供基础商家service层接口
 *  TODO
 * 
 *  Notes:
 *  $Id: AgencyService.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年7月18日		wuqiang		Initial.
 *
 * 	@author gaoyuanteng@zhaotai.ren
 * </pre>
 */
public interface AgencyService extends BaseService<AgencyModel, Agency> {
	/**
	 * 创建商家信息
	 * @param agencyModel 商家model
	 * @return AgencyModel
	 * @throws Exception
	 */
	AgencyModel createAgency(AgencyModel agencyModel) throws Exception;

	/**
	 * 编辑商家信息
	 * @param agencyModel 商家model
	 * @return AgencyModel
	 * @throws Exception
	 */
	AgencyModel updateAgency(AgencyModel agencyModel) throws Exception;

	/**
	 * 启用禁用商家信息
	 * @param agencyCode 商家编码
	 * @return AgencyModel
	 * @throws Exception
	 */
	AgencyModel updateLockStatus(String agencyCode) throws Exception;

	/**
	 * 根据商家编码获取商家详情
	 * @param agencyCode 商家编码
	 * @return AgencyModel
	 * @throws Exception
	 */
	AgencyModel getAgencyByCode(String agencyCode) throws Exception;

	/**
	 * 分页获取商家列表
	 * @param agencyCode 商家编码
	 * @param agencyName 商家名称
	 * @param province 省编码
	 * @param city 市编码
	 * @param region 区编码
	 * @param page 分页对象{@link net.freeapis.core.foundation.model.Page}
	 * @param orderBy 排序字段
	 * @param order 排序方式
	 * @return page
	 * @throws Exception
	 */
	Page getAgencyByPage(String agencyCode, String agencyName, String province, String city, String region,
			Page page, String orderBy, String order) throws Exception;

	/**
	 * 判断商家名称是否可用
	 * @param agencyName 商家名称
	 * @param id 主键sequenceNBR
	 * @return 如果名称可以使用返回{@code true} 否则 返回{@code false}
	 * @throws Exception
	 */
	boolean isAgencyNameAvailable(String agencyName, Long id) throws Exception;

	/**
	 * 判断商家编码是否可用
	 * @param agencyCode 商家编码
	 * @param id 主键sequenceNBR
	 * @return 如果agencyCode可以使用返回{@code true} 否则 返回{@code false}
	 * @throws Exception
	 */
	boolean isAgencyCodeAvailable(String agencyCode, Long id) throws Exception;

	/**
	 * 获取商家编码的最大值
	 * @return
	 */
    Long getMaxAgencyCode() throws Exception;
}

/*
 * $Log: av-env.bat,v $
 */