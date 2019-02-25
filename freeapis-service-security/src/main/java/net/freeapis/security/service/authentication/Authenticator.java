package net.freeapis.security.service.authentication;

import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.enumeration.UserType;
import net.freeapis.core.foundation.exceptions.BusinessException;
import net.freeapis.core.foundation.exceptions.UserIdOrPasswordNotValidException;
import net.freeapis.core.foundation.sequence.SequenceGenerator;
import net.freeapis.core.foundation.support.SpringContextHelper;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.Sequence;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.security.dao.LoginHistoryDAO;
import net.freeapis.security.dao.LoginInfoDAO;
import net.freeapis.security.dao.PrincipalDAO;
import net.freeapis.security.dao.SessionDAO;
import net.freeapis.security.face.constants.SecurityConstants;
import net.freeapis.security.face.entity.LoginInfo;
import net.freeapis.security.face.entity.Principal;
import net.freeapis.security.face.entity.Session;
import net.freeapis.security.face.enums.AuthType;
import net.freeapis.security.face.enums.IdType;
import net.freeapis.security.face.model.AuthRequestModel;
import net.freeapis.security.face.model.PrincipalModel;
import net.freeapis.security.face.model.UserSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * <pre>
 * 
 *  freeapis
 *  File: Authenticator.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 * 	$Id: Authenticator.java 72642 2009-01-01 20:01:57Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年9月7日		wuqiang		Initial.
 * 
 * </pre>
 */
@Component
public class Authenticator {

	private static final Logger logger = LoggerFactory.getLogger(Authenticator.class);
	
	private static final String BEAN_NAME_SUFIX = "Authenticator";
	
	@Autowired
	protected LoginInfoDAO loginInfoDAO;

	@Autowired
	protected PrincipalDAO principalDAO;
	
	@Autowired
	protected LoginHistoryDAO loginHistoryDAO;

	@Autowired
	private SessionDAO sessionDAO;
	
	@Autowired
	private SequenceGenerator sequenceGenerator;

	/**
	 * TODO.登录认证创建会话
	 * @param idType	登录账号类型
	 * @param authType	认证方式
	 * @param userType	用户类型
	 * @param authModel	认证信息
	 * @return
	 * @throws Exception
	 */
	public UserSession authenticate(IdType idType, AuthType authType, UserType userType,
									AuthRequestModel authModel) throws Exception {
		
		String product = RequestContext.getProduct();
		String requestIP = RequestContext.getRequestIP();
		String userAgent = RequestContext.getUserAgent();
		
		if(ValidationUtil.isEmpty(product)
				|| ValidationUtil.isEmpty(requestIP)
				|| ValidationUtil.isEmpty(userAgent)){
			throw new UserIdOrPasswordNotValidException(SecurityConstants.MESSAGE_AUTHINFO_NOT_VALID);
		}
		UserSession session = new UserSession();
		if(UserType.ANONYMOUS.equals(userType)){
			session.setSessionId(Sequence.getUUID());
			session.setAgencyCode(CoreConstants.CODE_SUPER_ADMIN);
			session.setUserId(sequenceGenerator.getNextValue());
			session.setLoginId(UserType.ANONYMOUS.name() + sequenceGenerator.getNextValue());
			session.setUserName(UserType.ANONYMOUS.getLabel());
			session.setStatus(CoreConstants.COMMON_N);
			session.setUserType(UserType.ANONYMOUS.getValue());
			session.setRemoteIp(requestIP);
			session.setUserAgent(userAgent);
			session.setProduct(product);
			session.setCreateTime(new Date());
			session.setExpiration(String.valueOf(userType.getExpireDuration()));
		}else{
			PrincipalModel currentPrincipal = getAuthenticator(authType).doAuthenticate(idType, userType, authModel);
			session.setSessionId(Sequence.getUUID());
			session.setAgencyCode(currentPrincipal.getAgencyCode());
			session.setUserId(currentPrincipal.getUserId());
			session.setLoginId(currentPrincipal.getLoginId());
			session.setUserName(currentPrincipal.getUserName());
			session.setStatus(currentPrincipal.getLockStatus());
			session.setUserType(currentPrincipal.getUserType());
			session.setPassword(currentPrincipal.getPassword());
			session.setSalt(currentPrincipal.getSalt());
			session.setRemoteIp(requestIP);
			session.setUserAgent(userAgent);
			session.setProduct(RequestContext.getProduct());
			session.setCreateTime(new Date());
			session.setExpiration(String.valueOf(userType.getExpireDuration()));
		}
		return session;
	}

	private static Authenticator getAuthenticator(AuthType authType) throws Exception {
		return SpringContextHelper.getBean(authType.name() + BEAN_NAME_SUFIX);
	}

	protected PrincipalModel doAuthenticate(IdType idType, UserType userType, AuthRequestModel authModel) throws Exception{
		logger.error("this method must be implemented by subClass of Authenticator!");
		throw new BusinessException("this method must be implemented by subClass of Authenticator!");
	}
	
	public  UserSession refreshSession(String token,String product) throws Exception{
		UserSession userSession = null;
		Session oldSession = sessionDAO.findBySessionId(token, product);
		boolean canRefresh = false;
		if (!ValidationUtil.isEmpty(oldSession)) {
			UserType currentUserType = UserType.getUserType(oldSession.getUserType());
			//如果是匿名用户,则直接返回刷新后的session
			if(currentUserType.equals(UserType.ANONYMOUS)){
				oldSession.setSessionId(Sequence.getUUID());
				oldSession.setCreateTime(new Date());
				canRefresh = true;
			}else{
				String currentLoginId = oldSession.getLoginId();
				// 获取当前用户的登录账号信息
				LoginInfo currentLoginInfo = loginInfoDAO.findLoginInfo(CoreConstants.CODE_SUPER_ADMIN, currentLoginId);
				Principal currentPrincipal = null;
				if(!ValidationUtil.isEmpty(currentLoginInfo)){
					currentPrincipal = principalDAO.findByUserId(currentLoginInfo.getUserId());
				}
				// 如果登录账号存在,并且登录账号状态正常,才刷新session
				if (!ValidationUtil.isEmpty(currentLoginInfo)
						&& !ValidationUtil.isEmpty(currentPrincipal)
						&& CoreConstants.COMMON_N.equals(currentLoginInfo.getLockStatus())) {
					oldSession.setSessionId(Sequence.getUUID());
					oldSession.setCreateTime(new Date());
					canRefresh = true;
				}
			}
			if(canRefresh){
				sessionDAO.update(oldSession);
				userSession = Bean.toModel(oldSession,new UserSession());
				if (!ValidationUtil.isEmpty(userSession)) {
					Redis.setWithExpire(userSession, Long.parseLong(userSession.getExpiration()),
							SecurityConstants.CACHE_KEY_PREFIX_SESSION, userSession.getSessionId(),userSession.getProduct());
					userSession.setRefresh(true);
				}
			}
		}
		return userSession;
	}
}

/*
 * $Log: av-env.bat,v $
 */