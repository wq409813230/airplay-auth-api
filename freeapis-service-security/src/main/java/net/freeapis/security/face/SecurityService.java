package net.freeapis.security.face;

import net.freeapis.core.foundation.enumeration.UserType;
import net.freeapis.core.foundation.orm.BaseService;
import net.freeapis.security.face.entity.Principal;
import net.freeapis.security.face.enums.AuthType;
import net.freeapis.security.face.enums.IdType;
import net.freeapis.security.face.model.AuthRequestModel;
import net.freeapis.security.face.model.PrincipalModel;
import net.freeapis.security.face.model.UserSession;

/**
 * <pre>
 * 
 *  freeapis
 *  File: PrincipalService.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:用户认证体系中的安全服务，提供主体的查询，信息修改，密码修改，创建安全信息等服务
 *  TODO
 * 
 *  Notes:
 * 	$Id: PrincipalService.java 72642 2009-01-01 20:01:57Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年9月9日		wuqiang		Initial.
 *  
 * </pre>
 */
public interface SecurityService extends BaseService<PrincipalModel, Principal>{
	/**
	 * TODO.当用户认证信息不存在时才创建，如果存在则直接返回,
	 * 此业务适用于短信认证或者第三方认证时的账号安全信息的创建,
	 * 相当于注册业务
	 * @param agencyCode
	 * @param loginId
	 * @param userType
	 * @param idType
	 * @return
	 * @throws Exception
	 */
	PrincipalModel createSecurityInfoIfNotExist(String agencyCode,String loginId,UserType userType,IdType idType) throws Exception;
	/**
	 * TODO.获取用户的认证信息,包含密码等安全属性
	 * @param agencyCode
	 * @param loginId
	 * @param userType
	 * @param idType
	 * @return
	 * @throws Exception
	 */
	PrincipalModel getSecurityInfo(String agencyCode,String loginId,UserType userType,IdType idType) throws Exception;
	
	/**
	 * TODO.创建用户认证信息
	 * @param principalModel
	 * @param idType
	 * @return
	 * @throws Exception
	 */
	PrincipalModel createPrincipal(PrincipalModel principalModel,IdType idType) throws Exception;
	/**
	 * TODO.删除用户的主体信息
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	void deletePrincipal(Long userId) throws Exception;
	/**
	 * TODO.更新主体信息.此方法只更新主体信息的普通非安全属性，
	 * 如用户名，昵称，性别等，主体的安全属性使用专门的业务方法更新
	 * @param principalModel
	 * @return
	 * @throws Exception
	 */
	PrincipalModel updatePrincipal(PrincipalModel principalModel) throws Exception;
	/**
	 * TODO.获取账号的主体信息，不包含密码等安全字段
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	PrincipalModel getPrincipal(Long userId) throws Exception;
	/**
	 * TODO.锁定／解锁主体的账号信息
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	PrincipalModel updateLockStatus(Long userId) throws Exception;
	/**
	 * TODO.充值主体账号的密码信息
	 * @param userId
	 * @throws Exception
	 */
	void resetPassword(Long userId) throws Exception;

	/**
	 * TODO.获取或者刷新token,加入refreshToken的机制是为了方便client端,免去了无意义的登录,毕竟登录需要验证很多资源
	 * 
	 * @param token
	 * @param product
	 * @return
	 * @throws Exception
	 */
	UserSession getOrRefreshSession(String token, String product) throws Exception;

	/**
	 * 验证token的有效性,
	 * @param token
	 * @param product
	 * @return
	 * @throws Exception token失效或者用户被禁用都抛出异常
	 */
	UserSession authToken(String token, String product) throws Exception;

	/**
	 * TODO.创建session,相当于真正的登录认证,认证成功后创建会话
	 * 
	 * @param idType
	 * @param authType
	 * @param userType
	 * @param authModel
	 * @return
	 * @throws Exception
	 */
	UserSession createSession(IdType idType, AuthType authType, UserType userType, AuthRequestModel authModel) throws Exception;

	/**
	 * 清除用户登录缓存
	 * @param userId
	 * @throws Exception
	 */
	void cleanLoginCache(Long userId) throws Exception;

	/**
	 * 修改员工密码
	 * @param userId
	 * @param Password
	 * @param oldPassword
	 * @throws Exception
	 */
	void updatePassword(Long userId,String Password,String oldPassword) throws Exception;


	void updatePassword(String newPassword, String oldPassword)throws Exception;

	void updateNewPassword(String newPassword)throws Exception;

	/**
	 * TODO.验证登录账号是否可用的通用方法,如验证公网用户手机号 ,后台用户登录ID
	 * @param agencyCode
	 * @param loginId
	 * @return
	 * @throws Exception
	 */
	boolean isLoginIdAvailable(String agencyCode,String loginId) throws Exception;

	PrincipalModel getByMobile(String mobile) throws Exception;

	/**
	 * 创建登录账号信息
	 * @param userId
	 * @param loginId
	 * @param idType
	 * @throws Exception
	 */
	void createLoginInfo(Long userId,String loginId,IdType idType) throws Exception;
}