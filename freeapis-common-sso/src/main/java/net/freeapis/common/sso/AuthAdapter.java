package net.freeapis.common.sso;

import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.enumeration.UserType;
import net.freeapis.core.foundation.support.SpringContextHelper;
import net.freeapis.core.foundation.utils.HashKit;
import net.freeapis.core.foundation.utils.PropKit;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.core.rest.containers.FreeapisOperation;
import net.freeapis.core.rest.containers.FreeapisResource;
import net.freeapis.security.face.constants.SecurityConstants;
import net.freeapis.security.face.model.UserSession;
import org.springframework.web.method.HandlerMethod;

import java.util.Set;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AuthAdapter.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthAdapter.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月21日		freeapis		Initial.
 *
 * </pre>
 */
public abstract class AuthAdapter {

	public static final String BEAN_NAME_PUBLIC_AUTH_ADAPTER = "publicAuthAdapter";
	public static final String BEAN_NAME_AGENCY_AUTH_ADAPTER = "agencyAuthAdapter";
	public static final String BEAN_NAME_SUPER_AUTH_ADAPTER = "superAuthAdapter";
	public static final String BEAN_NAME_ANONYMOUS_AUTH_ADAPTER = "anonymousAuthAdapter";

	/**
	 * AuthAdapter ganerator
	 * 
	 * @param userType
	 * @return
	 */
	public static AuthAdapter getAuthAdapter(UserType userType) {
		AuthAdapter adaptor = null;
		switch (userType) {
		case PUBLIC_USER:
			adaptor = SpringContextHelper.getBean(BEAN_NAME_PUBLIC_AUTH_ADAPTER);
			break;
		case AGENCY_USER:
			adaptor = SpringContextHelper.getBean(BEAN_NAME_AGENCY_AUTH_ADAPTER);
			break;
		case SUPER_ADMIN:
			adaptor = SpringContextHelper.getBean(BEAN_NAME_SUPER_AUTH_ADAPTER);
			break;
		case ANONYMOUS:
			adaptor = SpringContextHelper.getBean(BEAN_NAME_ANONYMOUS_AUTH_ADAPTER);
			break;
		default:
			break;
		}
		return adaptor;
	}

	/**
	 * 提供给authInterceptor调用,登陆和基本权限校验
	 * 
	 * @param handlerMethod
	 * @param session
	 * @return
	 * @throws Exception
	 */
	public boolean doAuth(HandlerMethod handlerMethod, UserSession session) throws Exception {
		boolean result = false;
		// 获取方法头上的注解
		FreeapisResource freeapisResource = handlerMethod.getBeanType().getAnnotation(FreeapisResource.class);
		FreeapisOperation freeapisOperation = handlerMethod.getMethodAnnotation(FreeapisOperation.class);
		// 调用方法操作的模块
		String module = freeapisResource.module();
		// 调用的方法所操作的资源
		String resource = freeapisResource.value();
		// 调用的方法对资源的操作
		String operation = freeapisOperation.name();
		// 获得API 级别
		APILevel apiLevel = freeapisOperation.ApiLevel();

		result = doSubAuth(module, resource, operation, apiLevel,session);

		return result;
	}

	protected abstract boolean doSubAuth(String module, String resource, String operation,
                                         APILevel apiLevel, UserSession session) throws Exception;

	/**
	 * 通过调用的方法签名判断当前用户有无权限
	 * @param module
	 * @param resource
	 * @param operation
	 * @param session
	 * @return
	 * @throws Exception
	 */
	protected boolean hasPermission(
            String module, String resource, String operation, UserSession session) throws Exception {
		if(!CoreConstants.COMMON_Y.equals(PropKit.get("freeapis.enableAuth"))) return true;

		String currentFunId = HashKit.md5(module + resource + operation);
		//此接口是给缓存中存放登录用户所拥有的funcId
		if(currentFunId.equals(SecurityConstants.FID_GET_CURRENT_USER_MODULE_FIDS)){
			return true;
		}
		Set<String> funcIds = Redis.get(SecurityConstants.CACHE_KEY_USER_FUNC_IDS,
				session.getAgencyCode(),session.getUserId().toString());
		if(ValidationUtil.isEmpty(funcIds)) return false;
		if(!ValidationUtil.isEmpty(funcIds) && funcIds.contains(currentFunId)) return true;
		return false;
	}
}

/*
 * $Log: av-env.bat,v $
 */