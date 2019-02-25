package net.freeapis.security.dao;

import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.security.face.entity.Principal;

import java.util.List;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: PublicUserDAO.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: PublicUserDAO.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月21日		freeapis		Initial.
 *
 * </pre>
 */
public interface PrincipalDAO extends GenericDAO<Principal> {
	
	void deleteByUserId(Long userId) throws Exception;

	Principal findByUserId(Long userId) throws Exception;

	void cleanTestData(Long userId,String cleanType) throws Exception;

    List<Principal> findBrieflyEmployee(String agencyCode, Integer userType) throws Exception;

	List<Map<String, Object>> findUserNameByUserIds(List<Long> userIds) throws Exception;

	/**
	 * 查询用户简要信息
	 * @param roleCode
	 * @param agencyCode
	 * @param userType
	 * @return
	 * @throws Exception
	 */
	List<Map<String,Object>> findBrieflyEmployeeByRoleCode(String roleCode,String agencyCode, Integer userType) throws Exception;

	Principal findByMobile(String mobile) throws Exception;
}

/*
 * $Log: av-env.bat,v $
 */