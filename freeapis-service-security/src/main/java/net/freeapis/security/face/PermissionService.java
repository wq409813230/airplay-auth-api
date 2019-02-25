package net.freeapis.security.face;

import net.freeapis.security.face.model.ModuleModel;
import net.freeapis.security.face.model.PrimarySecurityModel;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 *
 * <pre>
 *
 *  freeapis
 *  File: PermissionService.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: PermissionService.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年10月21日		freeapis		Initial.
 *
 * </pre>
 */
public interface PermissionService{

	/**
	 * 获取当前登录用户的模块树
	 * @return
	 * @throws Exception
	 */
	ModuleModel getCurrentUserModuleTree() throws Exception;

	/**
	 * 获取系统所有的资源模块权限树
	 * @param agencyCode
	 * @return
	 * @throws Exception
	 */
	List<ModuleModel> getModelOperations(String agencyCode) throws Exception;

	/**
	 * 获取指定角色的资源模块树
	 * @param agencyCode
	 * @param primaryType
	 * @param primaryCode
	 * @return
	 * @throws Exception
	 */
	List<Object> getPrimaryPermissions(String agencyCode, String primaryType, String primaryCode) throws Exception;

	/**
	 * 创建角色权限信息
	 * @param rolePrivilegeModel
	 * @return
	 * @throws Exception
	 */
	PrimarySecurityModel createPermission(PrimarySecurityModel rolePrivilegeModel) throws Exception;

	/**
	 * 获取当前用户指定模块的所有按钮信息
	 * @return
	 * @throws Exception
	 */
	Map<String,Set<String>> getCurrentUserModuleButtons() throws Exception;


	/**
	 * 清除主体权限对应的权限缓存
	 * @param agencyCode
	 * @param primaryType
	 * @param primaryCode
	 * @throws Exception
	 */
	void clearPrimaryPermissionCache(String agencyCode,String primaryType,String primaryCode) throws Exception;

	/**
	 * 清除用户对应的权限缓存
	 * @param agencyCode
	 * @param userId
	 * @throws Exception
	 */
	void clearUserPermissionCache(String agencyCode,Long userId) throws Exception;

}

/*
 * $Log: av-env.bat,v $
 */