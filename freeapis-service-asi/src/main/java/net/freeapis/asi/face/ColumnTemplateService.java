package net.freeapis.asi.face;

import net.freeapis.asi.face.entity.ColumnTemplate;
import net.freeapis.asi.face.model.ColumnTemplateModel;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.orm.BaseService;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: ColumnTemplateService.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: ColumnTemplateService.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
public interface ColumnTemplateService extends BaseService<ColumnTemplateModel,ColumnTemplate>
{
	/**
	 * TODO.创建列定义模板
	 * @param columnTemplateModel
	 * @throws Exception
	 */
	ColumnTemplateModel createColumnTemplate(ColumnTemplateModel columnTemplateModel) throws Exception;
	/**
	 * TODO.删除列定义模板
	 * @param agencyCode
	 * @param columnCode
	 * @throws Exception
	 */
	String deleteColumnTemplate(String agencyCode,String columnCode) throws Exception;
	/**
	 * TODO.更新列定义模板
	 * @param columnTemplateModel
	 * @throws Exception
	 */
	ColumnTemplateModel updateColumnTemplate(ColumnTemplateModel columnTemplateModel) throws Exception;
	/**
	 * TODO.获取列定义模板详情
	 * @param agencyCode
	 * @param columnCode
	 * @return
	 * @throws Exception
	 */
	ColumnTemplateModel getColumnTemplate(String agencyCode,String columnCode) throws Exception;
	/**
	 * TODO.获取列定义模板列表
	 * @param agencyCode
	 * @param columnCode
	 * @param page
	 * @return
	 * @throws Exception
	 */
	Page getColumnTemplateByPage(String agencyCode,String columnCode,String columnName,Page page,String orderBy,String order) throws Exception;
	/**
	 * TODO.判断字段编码是否可用
	 * @param agencyCode
	 * @param columnCode
	 * @return
	 * @throws Exception
	 */
	boolean isColumnCodeAvailable(String agencyCode,String columnCode) throws Exception;
}
