package net.freeapis.security.service.authentication;

import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.enumeration.UserType;
import net.freeapis.core.foundation.exceptions.UserIdOrPasswordNotValidException;
import net.freeapis.core.foundation.exceptions.UserStatusException;
import net.freeapis.core.foundation.utils.HashKit;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.security.face.SecurityService;
import net.freeapis.security.face.constants.SecurityConstants;
import net.freeapis.security.face.enums.IdType;
import net.freeapis.security.face.model.AuthRequestModel;
import net.freeapis.security.face.model.PrincipalModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * <pre>
 * 
 *  freeapis
 *  File: PasswordAuthenticator.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:本地普通的用户名密码登录认证器
 *  TODO
 * 
 *  Notes:
 * 	$Id: PasswordAuthenticator.java 72642 2009-01-01 20:01:57Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年9月7日		wuqiang		Initial.
 * 
 * </pre>
 */
@Component(value = "userNamePasswordAuthenticator")
public class UsernamePasswordAuthenticator extends Authenticator {

	@Autowired
	private SecurityService securityService;

	@Override
	protected PrincipalModel doAuthenticate(IdType idType, UserType userType, AuthRequestModel authModel)throws Exception {

		String agencyCode = authModel.getAgency();
		String loginId = authModel.getLoginId();
		String password = authModel.getPassword();

		if (ValidationUtil.isEmpty(idType) 
				|| ValidationUtil.isEmpty(userType)
				|| ValidationUtil.isEmpty(agencyCode) 
				|| ValidationUtil.isEmpty(loginId)
				|| ValidationUtil.isEmpty(password)) {
			throw new UserIdOrPasswordNotValidException(SecurityConstants.MESSAGE_AUTHINFO_NOT_VALID);
		}
		
		PrincipalModel currentPrincipal = securityService.getSecurityInfo(agencyCode, loginId, userType, idType);
		
		if (ValidationUtil.isEmpty(currentPrincipal)) {
			throw new UserIdOrPasswordNotValidException(SecurityConstants.MESSAGE_USER_NOT_FOUND);
		} else if (!CoreConstants.COMMON_N.equals(currentPrincipal.getLockStatus())) {
			throw new UserStatusException(SecurityConstants.MESSAGE_USER_LOCKED);
		} else if (!currentPrincipal.getPassword().equals(HashKit.md5(password, currentPrincipal.getSalt()))) {
			throw new UserIdOrPasswordNotValidException(SecurityConstants.MESSAGE_PASSWORD_ERROR);
		}
		return currentPrincipal;
	}

}

/*
 * $Log: av-env.bat,v $
 */