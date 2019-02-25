package net.freeapis.asi.face;

import net.freeapis.asi.face.entity.Group;
import net.freeapis.asi.face.model.GroupModel;
import net.freeapis.core.foundation.orm.BaseService;

import java.util.List;
/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: GroupService.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: GroupService.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
public interface GroupService extends BaseService<GroupModel,Group>
{
	/**
     * 创建动态表单组
     * @param groupModel
     * @throws Exception
     */
    GroupModel createGroup(GroupModel groupModel) throws Exception;
    /**
     * 删除动态表单组
     * @param groupCode
     * @throws Exception
     */
    String deleteGroup(String agencyCode,String groupCode) throws Exception;
    /**
     * 更新动态表单组
     * @param groupModel
     * @throws Exception
     */
    GroupModel updateGroup(GroupModel groupModel) throws Exception;
    /**
     * TODO.获取组定义详情
     * @param agencyCode
     * @param groupCode
     * @return
     * @throws Exception
     */
    GroupModel getGroup(String agencyCode,String groupCode) throws Exception;
    /**
     * 根据父分组编码获取动态表单组定义列表
     * @param agencyCode
     * @param parentCode
     * @return
     * @throws Exception
     */
	List<GroupModel> getGroupsByParentCode(String agencyCode,String parentCode) throws Exception;
	/**
	 * TODO.判断分组编码是否可用
	 * @param agencyCode
	 * @param groupCode
	 * @return
	 * @throws Exception
	 */
	boolean isGroupCodeAvailable(String agencyCode,String groupCode) throws Exception;
	/**
	 * TODO.同步获取分组树
	 * @param agencyCode
	 * @return
	 * @throws Exception
	 */
	GroupModel buildGruopTree(String agencyCode,String parentCode) throws Exception;

	/**
	 * 设置是否显示
	 * @param agencyCode
	 * @param groupCode
	 * @throws Exception
	 */
	GroupModel updateLockStatus(String agencyCode, String groupCode)throws Exception;

	/**
	 * 获取显示条数
	 * @param nodeLevel
	 * @param parentGroupCode
	 * @throws Exception
	 */
	int getLockStatusCount(Integer nodeLevel, String parentGroupCode)throws Exception;

	/**
	 * 门户端获取板块显示树
	 * @param agencyCode
	 * @param parentCode
	 * @return
	 * @throws Exception
	 */
	GroupModel buildEnableTree(String agencyCode, String parentCode)throws Exception;

	/**
	 * 根据groupCode删除组定义
	 * @param agencyCode
	 * @param groupCode
	 * @return
	 * @throws Exception
	 */
    void deleteGroupByGroupCode(String agencyCode, String groupCode)throws Exception;
}
