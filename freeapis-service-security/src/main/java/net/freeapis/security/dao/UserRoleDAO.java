package net.freeapis.security.dao;

import java.util.List;
import java.util.Map;

import net.freeapis.core.foundation.exceptions.DAOException;
import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.security.face.entity.UserRole;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AgUserRoleDao.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AgUserRoleDao.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月21日		freeapis		Initial.
 *
 * </pre>
 */
public interface UserRoleDAO extends GenericDAO<UserRole> {
	
	/**
	 * 查询用户角色信息
	 * @param agencyCode
	 * @param userId
	 * @return
	 * @throws Exception
	 */
    List<UserRole> findUserRoles(String agencyCode, Long userId) throws Exception;
	
	/**
	 * 删除用户角色信息
	 * @param agencyCode
	 * @param userId
	 * @return
	 * @throws Exception
	 */
    void deleteUserRoles(String agencyCode, Long userId) throws Exception;

	/**
	 * 根据锁定状态获取用户角色信息
	 * @param agencyCode
	 * @param userId
	 * @param lockStatus 为空表示也获取锁定的角色
	 * @return
	 * @throws DAOException
	 * @throws Exception 
	 */
    List<UserRole> findByLockStatus(String agencyCode, Long userId, String lockStatus)throws Exception;

	/**
	 * 查找用户角色详细信息
	 * @param agencyCode
	 * @param userId
	 * @return
	 * @throws Exception
	 */
    List<Map<String, Object>> findUserRolesInfo(String agencyCode, Long userId) throws Exception;


	/**
	 * 查找角色用户信息
	 */
	List<UserRole> findByRoleCode(String agencyCode,String roleCode) throws Exception;

	/**
	 * 查询用户时候拥有某个角色
	 * @param agencyCode
	 * @param userId
	 * @param roleCode
	 * @return
	 */
	boolean findIfUserHasRole(String agencyCode,Long userId,String roleCode) throws Exception;

	/**
	 * 获取角色关联userId
	 * @param agencyCode
	 * @param roleCode
	 * @return
	 * @throws Exception
	 */
	List<Map<String,Object>> findRoleRelevanceUserId(String agencyCode,String roleCode) throws Exception;

}

/*
 * $Log: av-env.bat,v $
 */