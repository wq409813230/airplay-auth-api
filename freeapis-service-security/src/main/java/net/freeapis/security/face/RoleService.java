package net.freeapis.security.face;

import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.orm.BaseService;
import net.freeapis.security.face.entity.Role;
import net.freeapis.security.face.model.RoleModel;
import net.freeapis.security.face.model.UserRoleModel;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AgRoleService.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AgRoleService.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月21日		freeapis		Initial.
 *
 * </pre>
 */
public interface RoleService extends BaseService<RoleModel, Role> {

	/**
	 * 根据角色编号获取角色信息
	 * 
	 * @param agencyCode
	 *            机构代码
	 * @param roleCode
	 *            角色编号
	 */
    RoleModel getRoleByCode(String agencyCode, String roleCode) throws Exception;

	/**
	 * 查询该机构所有没有禁用的角色
	 * 
	 * @param agencyCode
	 *            机构代码
	 */
    List<RoleModel> getAllRoles(String agencyCode, String roleCode, String roleName, String lockStatus)
			throws Exception;

	/**
	 * 创建角色
	 * 
	 * @param agencyCode
	 *            机构代码
	 * @param roleModel
	 *            角色实体
	 */
    RoleModel createRole(String agencyCode, RoleModel roleModel) throws Exception;

	/**
	 * 
	 * 分页查询角色
	 *
	 * @param agencyCode
	 * @param roleCode
	 * @param roleName
	 * @param lockStatus
	 * @param page
	 * @param order
	 * @param orderBy
	 * @return
	 * @throws Exception
	 */
    Page getByPage(String agencyCode, String roleCode, String roleName, String lockStatus, Page page,
                   String orderBy, String order) throws Exception;

	/**
	 * 
	 * 更新系統角色
	 *
	 * @param roleModel
	 * @return
	 * @throws Exception
	 */
    RoleModel updateRole(RoleModel roleModel) throws Exception;

	String[]  deleteRole(String agencyCode, String[] roleCode) throws Exception;
	
	/**
	 * 启用/禁用角色
	 * @param roleCode
	 * @return
	 * @throws Exception
	 */
    RoleModel updateLockStatus(String roleCode) throws Exception;

	/**
	 * 判断角色名称是否可用
	 * @param roleName
	 * @param id
	 * @return
	 */
	boolean isRoleNameAvailable(String roleName, Long id) throws Exception;

	/**
	 * 判断角色编号是否可用
	 * @param roleCode
	 * @param id
	 * @return
	 */
	boolean isRoleCodeAvailable(String roleCode, Long id) throws Exception;

	/**
	 * 获取角色关联userId
	 * @param agencyCode
	 * @param roleCode
	 * @return
	 * @throws Exception
	 */
	List<Map<String,Object>> getRoleRelevanceUserId(String agencyCode, String roleCode) throws Exception;

	/**
	 * 根据用户userId获取关联角色
	 * @return
	 * @throws Exception
	 */
	List<UserRoleModel> getRoleRelevanceRoleCode()throws Exception;

	/**
	 * 获取角色可操作的商品库
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	Set<String> getSpuPoolsByUserId(Long userId) throws Exception;

	/**
	 * 获取角色可操作的采购记录类型
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	Set<String> getProduceRecordTypeByUserId(Long userId) throws Exception;

}

/*
 * $Log: av-env.bat,v $
 */