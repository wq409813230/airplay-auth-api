package net.freeapis.common.sso;

import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.enumeration.UserType;
import net.freeapis.core.foundation.exceptions.ResourceForbiddenException;
import net.freeapis.core.foundation.exceptions.UnauthorizedException;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.rest.constants.RestConstants;
import net.freeapis.core.rest.containers.FreeapisOperation;
import net.freeapis.security.face.SecurityService;
import net.freeapis.security.face.constants.SecurityConstants;
import net.freeapis.security.face.model.UserSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * <pre>
 *
 *  freeapis
 *  File: AuthInterceptor.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:微服务单点登录拦截器
 *
 *  Notes:
 *  $Id: AuthInterceptor.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月21日		freeapis		Initial.
 *
 * </pre>
 */
@Component
public class AuthInterceptor extends HandlerInterceptorAdapter {
    private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);

    @Autowired
    private SecurityService securityService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HandlerMethod handlerMethod = (HandlerMethod) handler;
        if (!doAuth(handlerMethod)){
            throw new ResourceForbiddenException(RestConstants.MESSAGE_RESOURCE_FOBBIDEN);
        }
        return true;
    }

    private boolean doAuth(HandlerMethod handlerMethod) throws Exception {
        String token = RequestContext.getSessionId();
        String appKey = RequestContext.getAppKey();
        String product = RequestContext.getProduct();
        FreeapisOperation freeapisOperation = handlerMethod.getMethodAnnotation(FreeapisOperation.class);
        //如果资源不需要验证直接放行
        if(!freeapisOperation.needAuth()){
            return true;
        }
        if(ValidationUtil.isEmpty(token) || ValidationUtil.isEmpty(product)){
            throw new UnauthorizedException(SecurityConstants.MESSAGE_TOKEN_REQUIRED);
        }
        UserSession session = securityService.authToken(token,product);

        RequestContext.setExeUserId(session.getUserId().toString());
        RequestContext.setExeUserName(session.getUserName());
        RequestContext.setAgencyCode(session.getAgencyCode());
        RequestContext.setUserType(UserType.getUserType(session.getUserType()));
        RequestContext.setLoginId(session.getLoginId());
        return AuthAdapter.getAuthAdapter(
                UserType.getUserType(session.getUserType())).doAuth(handlerMethod, session);
    }
}