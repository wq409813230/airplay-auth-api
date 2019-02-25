package net.freeapis.security.dao;

import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.security.face.entity.Session;

import java.util.List;

/**
 * <pre>
 * 
 *  freeapis
 *  File: SessionDAO.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:session数据访问接口
 *
 *  Notes:
 *  $Id: SessionDAO.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月7日		freeapis		Initial.
 *
 * </pre>
 */
public interface SessionDAO extends GenericDAO<Session> {
	/**
	 * 根据登录账号和登录设备获取所有session
	 * @param agencyCode
	 * @param loginId
	 * @param product
	 * @return
	 * @throws Exception
	 */
	List<Session> findSessions(String agencyCode,String loginId,String product) throws Exception;

	/**
	 * TODO.查询指定用户的所有session
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	List<Session> findSessionsByUserId(Long userId) throws Exception;
	/**
	 * TODO.根据sessionId获取session
	 * @param sessionId
	 * @param product
	 * @return
	 * @throws Exception
	 */
	Session findBySessionId(String sessionId,String product) throws Exception;
}
