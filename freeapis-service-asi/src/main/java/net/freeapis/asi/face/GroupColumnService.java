package net.freeapis.asi.face;

import java.util.List;
import java.util.Map;

import net.freeapis.asi.face.entity.GroupColumn;
import net.freeapis.asi.face.model.GroupColumnModel;
import net.freeapis.core.foundation.orm.BaseService;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: GroupColumnService.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: GroupColumnService.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
public interface GroupColumnService extends BaseService<GroupColumnModel,GroupColumn>
{
	/**
	 * TODO.创建自定义列
	 * @param gruopColumnModel
	 * @throws Exception
	 */
	GroupColumnModel createGroupColumn(GroupColumnModel gruopColumnModel) throws Exception;
	/**
	 * TODO.删除自定义列
	 * @param agencyCode
	 * @param groupCode
	 * @param subGroupCode
	 * @param columnCode
	 * @throws Exception
	 */
	String deleteGroupColumn(String agencyCode, String groupCode, String columnCode) throws Exception;
	/**
	 * TODO.更新自定义列
	 * @param gruopColumnModel
	 * @throws Exception
	 */
	GroupColumnModel updateGroupColumn(GroupColumnModel gruopColumnModel) throws Exception;

	/**
	 * TODO.复制模板列到分组自定义列
	 * @param agencyCode
	 * @param groupCode
	 * @param subgroupCode
	 * @param columnTemplates
	 * @throws Exception
	 */
	void copyFromTemplate(String agencyCode, String groupCode,List<Map<String, String>> columnTemplates) throws Exception;

	/**
	 * TODO.获取子分组的列定义,从缓存取
	 * 
	 * @param agencyCode
	 * @param groupCode
	 * @param subgroupCode
	 * @return
	 * @throws Exception
	 */
	List<GroupColumnModel> getGroupColumns(String agencyCode, String groupCode) throws Exception;

	/**
	 * TODO.获取自定义列详情
	 * @param agencyCode
	 * @param groupCode
	 * @param subgroupCode
	 * @param columnCode
	 * @return
	 * @throws Exception
	 */
	GroupColumnModel getGroupColumn(String agencyCode, String groupCode, String columnCode) throws Exception;
	/**
	 * TODO.判断自定义列的列编码是否可用
	 * @param agencyCode
	 * @param groupCode
	 * @param columnCode
	 * @return
	 * @throws Exception
	 */
	boolean isGroupColumnCodeAvailable(String agencyCode,String groupCode,String columnCode) throws Exception;

    Map<String,GroupColumn> findGroupColumnsMap(String agencyCode, String groupCode) throws Exception;
}
