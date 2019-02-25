package net.freeapis.security.dao;

import java.util.List;
import java.util.Map;

import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.security.face.entity.Role;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AgRoleDao.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AgRoleDao.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月21日		freeapis		Initial.
 *
 * </pre>
 */
public interface RoleDAO extends GenericDAO<Role> {
	
	/**
	 * 删除角色
	 * @param agencyCode
	 * @param roleCode
	 * @throws Exception
	 */
    void deleteByRoleCode(String agencyCode, String roleCode) throws Exception;

	/**
	 * 根据编号查找角色
	 * @param agencyCode
	 * @param roleCode
	 * @return
	 * @throws Exception
	 */
    Role findByCode(String agencyCode, String roleCode) throws Exception;

	/**
	 * 查询角色列表
	 * @param agencyCode
	 * @param roleCode
	 * @param roleName
	 * @param lockStatus
	 * @return
	 * @throws Exception
	 */
    List<Role> findRoles(String agencyCode, String roleCode, String roleName, String lockStatus)
			throws Exception;

	/**
	 * 分页查询角色信息
	 * @param agencyCode
	 * @param roleCode
	 * @param roleName
	 * @param lockStatus
	 * @param page
	 * @param orderBy
	 * @param order
	 * @return
	 * @throws Exception
	 */
    List<Role> findByPage(String agencyCode, String roleCode, String roleName, String lockStatus, Page page,
                          String orderBy, String order) throws Exception;


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
	 * 查找用户拥有的商品库
	 * @param userId
	 * @return
	 */
	List<Map<String, Object>> findSpuPoolsByUserId(Long userId) throws Exception;

	/**
	 * 查找用户拥有的采购记录类型
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> findProduceRecordTypeByUserId(Long userId)throws Exception;
}

/*
 * $Log: av-env.bat,v $
 */