package net.freeapis.security.dao;

import net.freeapis.core.foundation.enumeration.UserType;
import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.security.face.entity.LoginInfo;
import net.freeapis.security.face.enums.IdType;

import java.util.List;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: LoginInfoDAO.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: LoginInfoDAO.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月21日		freeapis		Initial.
 *
 * </pre>
 */
public interface LoginInfoDAO extends GenericDAO<LoginInfo>
{
	
	void deleteByLoginId(String agencyCode,String loginId) throws Exception;
	
	LoginInfo findLoginInfo(String agencyCode,String loginId) throws Exception;
	/**
	 * TODO.通过登录账号获取登录信息
	 * @param agencyCode
	 * @param loginId
	 * @param userType
	 * @return
	 * @throws Exception
	 */
	LoginInfo findLoginInfoForLogin(String agencyCode,String loginId,UserType userType,IdType idType) throws Exception;
	/**
	 * TODO.通过系统用户ID获取登录信息,一个系统用户可能有多个登录账号
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	List<LoginInfo> findLoginInfos(Long userId) throws Exception;
	/**
	 * TODO.验证登录账号是否可用的通用方法,如验证公网用户手机号 ,后台用户登录ID
	 * @param agencyCode
	 * @param loginId
	 * @return
	 * @throws Exception
	 */
	boolean isLoginIdAvailable(String agencyCode,String loginId) throws Exception;

	/**
	 * 主要作用：获取loginId，便于用户来源设置
	 * @param userId
	 * @param IdType
	 * @return
	 * @throws Exception
	 */
	LoginInfo findLoginInfoByUserIdAndIdType(Long userId,String IdType)throws Exception;

	List<String> findByUserIds(List<String> userIds,String IdType)throws Exception;

}

/*
*$Log: av-env.bat,v $
*/