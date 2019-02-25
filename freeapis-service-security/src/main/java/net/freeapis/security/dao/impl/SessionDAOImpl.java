package net.freeapis.security.dao.impl;

import net.freeapis.core.mysql.GenericDAOImpl;
import net.freeapis.security.dao.SessionDAO;
import net.freeapis.security.face.entity.Session;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
@Repository("sessionDAO")
public class SessionDAOImpl extends GenericDAOImpl<Session> implements SessionDAO{
	/**
     * 根据登录账号和登录设备获取所有session
	 * @param agencyCode
     * @param loginId
     * @param product
     * @return
     * @throws Exception
	 */
	public List<Session> findSessions(String agencyCode, String loginId, String product) throws Exception{
		StringBuilder sql = new StringBuilder(
				" AND AGENCY_CODE =:AGENCY_CODE AND LOGIN_ID = :LOGIN_ID  AND PRODUCT = :PRODUCT ORDER BY CREATE_TIME DESC");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("AGENCY_CODE", agencyCode);
		params.put("LOGIN_ID", loginId);
		params.put("PRODUCT", product);
		return find(sql.toString(), params,null,null);
	}

	/**
	 * TODO.查询指定用户的所有session
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public List<Session> findSessionsByUserId(Long userId) throws Exception{
		String sql = " AND USER_ID = :USER_ID ";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("USER_ID", userId);
		return this.find(sql, params, null, null);
	}
	/**
	 * TODO.根据sessionId获取session
	 * @param sessionId
	 * @param product
	 * @return
	 * @throws Exception
	 */
	public Session findBySessionId(String sessionId, String product) throws Exception{
		StringBuilder sql = new StringBuilder(
				" AND SESSION_ID = :SESSION_ID AND PRODUCT = :PRODUCT ORDER BY CREATE_TIME DESC");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("SESSION_ID", sessionId);
		params.put("PRODUCT", product);
		return findFirst(sql.toString(), params);
	}
}
