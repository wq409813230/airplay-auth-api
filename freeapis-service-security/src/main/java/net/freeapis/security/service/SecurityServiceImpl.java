package net.freeapis.security.service;

import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.constants.ErrorCodeConstants;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.enumeration.UserType;
import net.freeapis.core.foundation.exceptions.DataNotFoundException;
import net.freeapis.core.foundation.exceptions.DataValidateException;
import net.freeapis.core.foundation.exceptions.UnauthorizedException;
import net.freeapis.core.foundation.exceptions.UserStatusException;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.HashKit;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.BaseServiceImpl;
import net.freeapis.security.dao.*;
import net.freeapis.security.face.SecurityService;
import net.freeapis.security.face.constants.SecurityConstants;
import net.freeapis.security.face.entity.*;
import net.freeapis.security.face.enums.AuthType;
import net.freeapis.security.face.enums.IdType;
import net.freeapis.security.face.model.AuthRequestModel;
import net.freeapis.security.face.model.PrincipalModel;
import net.freeapis.security.face.model.UserSession;
import net.freeapis.security.service.authentication.Authenticator;
import net.freeapis.systemctl.face.DictionaryService;
import net.freeapis.systemctl.face.constants.DictionaryConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * <pre>
 *
 *  freeapis
 *  File: SecurityServiceImpl.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2016
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 * 	$Id: SecurityServiceImpl.java 72642 2009-01-01 20:01:57Z freeapis\wuqiang $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年9月12日		wuqiang		Initial.
 *
 * </pre>
 */
@Service(value = "securityService")
public class SecurityServiceImpl extends BaseServiceImpl<PrincipalModel, Principal> implements SecurityService {

    @Autowired
    private LoginInfoDAO loginInfoDAO;

    @Autowired
    private PrincipalDAO principalDAO;

    @Autowired
    private LoginHistoryDAO loginHistoryDAO;

    @Autowired
    private SessionDAO sessionDAO;

    @Autowired
    private Authenticator authenticator;

    @Autowired
    private UserRoleDAO userRoleDAO;

    @Autowired
    private DictionaryService dictionaryService;

    @Override
    public PrincipalModel createSecurityInfoIfNotExist(String agencyCode, String loginId, UserType userType, IdType idType) throws Exception {
        LoginInfo currentLoginInfo = loginInfoDAO.findLoginInfoForLogin(agencyCode, loginId, userType, idType);
        Long currentUserId = sequenceGenerator.getNextValue();
        if (ValidationUtil.isEmpty(currentLoginInfo)) {
            currentLoginInfo = new LoginInfo();
            currentLoginInfo.setSequenceNBR(sequenceGenerator.getNextValue());
            currentLoginInfo.setUserId(currentUserId);
            currentLoginInfo.setLoginId(loginId);
            currentLoginInfo.setIdType(idType.name());
            currentLoginInfo.setAgencyCode(agencyCode);
            currentLoginInfo.setRecDate(new Date());
            currentLoginInfo.setRecStatus(CoreConstants.COMMON_ACTIVE);
            currentLoginInfo.setRecUserId(CoreConstants.SYSTEM.toString());
            currentLoginInfo.setLockStatus(CoreConstants.COMMON_N);
            loginInfoDAO.insert(currentLoginInfo);
        }
        Principal currentPrincipal = principalDAO.findByUserId(currentLoginInfo.getUserId());
        if (ValidationUtil.isEmpty(currentPrincipal)) {
            currentPrincipal = new Principal();
            currentPrincipal.setSequenceNBR(currentUserId);
            currentPrincipal.setUserId(currentUserId);
            currentPrincipal.setUserName(currentLoginInfo.getLoginId());
            currentPrincipal.setMobile(currentLoginInfo.getLoginId());
            currentPrincipal.setAgencyCode(agencyCode);
            currentPrincipal.setRecDate(new Date());
            if (IdType.dingTalk.equals(idType)){
                currentPrincipal.setRecStatus(CoreConstants.COMMON_INACTIVE);
            }else{
                currentPrincipal.setRecStatus(CoreConstants.COMMON_ACTIVE);
            }
            currentPrincipal.setRecUserId(CoreConstants.SYSTEM.toString());
            currentPrincipal.setRegisterDate(new Date());
            currentPrincipal.setUserType(userType.getValue());
            currentPrincipal.setLockStatus(CoreConstants.COMMON_N);
            currentPrincipal.setSalt(HashKit.generateSalt(10));
            currentPrincipal.setPassword(HashKit.md5(SecurityConstants.DEFAULT_USER_PASSWORD, currentPrincipal.getSalt()));
            principalDAO.insert(currentPrincipal);
        }
        return beSafe(Bean.toModel(currentPrincipal, new PrincipalModel())).withLoginId(loginId);
    }

    @Override
    public PrincipalModel getSecurityInfo(String agencyCode, String loginId, UserType userType, IdType idType)
            throws Exception {
        LoginInfo currentLoginInfo = loginInfoDAO.findLoginInfoForLogin(agencyCode, loginId, userType, idType);
        if (!ValidationUtil.isEmpty(currentLoginInfo)) {
            return Bean.toModel(principalDAO.findByUserId(currentLoginInfo.getUserId()), new PrincipalModel()).withLoginId(loginId);
        }
        return null;
    }

    @Override
    public PrincipalModel createPrincipal(PrincipalModel principalModel, IdType idType)
            throws Exception {
        // #1.添加登录信息
        String lockStatus = ValidationUtil.isEmpty(principalModel.getLockStatus()) ? CoreConstants.COMMON_N : principalModel.getLockStatus();
        String currentAgencyCode = !ValidationUtil.isEmpty(principalModel.getAgencyCode())
                ? principalModel.getAgencyCode() : RequestContext.getAgencyCode();
        Long currentUserId = sequenceGenerator.getNextValue();
        LoginInfo loginInfo = new LoginInfo();
        loginInfo.setSequenceNBR(sequenceGenerator.getNextValue());
        loginInfo.setUserId(currentUserId);
        loginInfo.setLoginId(principalModel.getLoginId());
        loginInfo.setIdType(idType.name());
        loginInfo.setAgencyCode(currentAgencyCode);
        loginInfo.setRecDate(new Date());
        loginInfo.setRecStatus(CoreConstants.COMMON_ACTIVE);
        loginInfo.setRecUserId(CoreConstants.SYSTEM.toString());
        loginInfo.setLockStatus(lockStatus);
        loginInfoDAO.insert(loginInfo);
        //#2.添加认证主体信息
        Principal principal = Bean.toPo(principalModel, new Principal());
        principal.setSequenceNBR(currentUserId);
        principal.setUserId(currentUserId);
        if (ValidationUtil.isEmpty(principal.getUserName())) {
            principal.setUserName(loginInfo.getLoginId());
        }
        principal.setAgencyCode(currentAgencyCode);
        principal.setRecDate(new Date());
        principal.setRecStatus(CoreConstants.COMMON_ACTIVE);
        principal.setRecUserId(CoreConstants.SYSTEM.toString());
        principal.setRegisterDate(new Date());
        principal.setUserType(principalModel.getUserType());
        principal.setLockStatus(lockStatus);
        principal.setSalt(HashKit.generateSalt(10));
        principal.setPassword(HashKit.md5(principal.getPassword(), principal.getSalt()));
        principalDAO.insert(principal);
        //#3.添加角色信息
        if (!ValidationUtil.isEmpty(principalModel.getRoleCodes())) {
            String[] roleCodes = principalModel.getRoleCodes().split(",");
            saveUserRoles(roleCodes, currentUserId, principal.getAgencyCode());
        }
        return beSafe(Bean.toModel(principal, principalModel));
    }

    @Override
    public void deletePrincipal(Long userId) throws Exception {
        Principal currentPrincipal = principalDAO.findByUserId(userId);
        if (!ValidationUtil.isEmpty(currentPrincipal)) {
            principalDAO.deleteByUserId(userId);
            userRoleDAO.deleteUserRoles(currentPrincipal.getAgencyCode(), userId);
        }
    }

    @Override
    public PrincipalModel updatePrincipal(PrincipalModel principalModel) throws Exception {
        Principal currentPrincipal = principalDAO.findByUserId(principalModel.getUserId());
        if (ValidationUtil.isEmpty(currentPrincipal)) {
            throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
        }
        //#1更新主体的基础信息
        principalModel.setPassword(currentPrincipal.getPassword());
        principalModel.setSalt(currentPrincipal.getSalt());
        Bean.copyExistPropertis(principalModel, currentPrincipal);
        principalDAO.update(currentPrincipal);
        //#2更新主体的角色信息
        userRoleDAO.deleteUserRoles(currentPrincipal.getAgencyCode(), currentPrincipal.getUserId());
        if (!ValidationUtil.isEmpty(principalModel.getRoleCodes())) {
            String[] roleCodes = principalModel.getRoleCodes().split(",");
            saveUserRoles(roleCodes, currentPrincipal.getUserId(), currentPrincipal.getAgencyCode());
        }
        return beSafe(Bean.toModel(currentPrincipal, principalModel));
    }

    /**
     * 保存员工角色信息
     *
     * @param roleCodes
     * @param userId
     * @param agencyCode
     * @throws Exception
     */
    private void saveUserRoles(String[] roleCodes, Long userId, String agencyCode) throws Exception {
        for (String roleCode : roleCodes) {
            UserRole userRole = new UserRole();
            userRole.setSequenceNBR(sequenceGenerator.getNextValue());
            userRole.setRecDate(new Date());
            userRole.setRecStatus(CoreConstants.COMMON_ACTIVE);
            userRole.setRecUserId(RequestContext.getExeUserId());
            userRole.setUserId(userId);
            userRole.setRoleCode(roleCode);
            userRole.setAgencyCode(agencyCode);
            userRole.setLockStatus(CoreConstants.COMMON_N);
            userRoleDAO.insert(userRole);
        }
    }

    //屏蔽密码属性，让主体向外暴露的更加安全
    private PrincipalModel beSafe(PrincipalModel principalModel) {
        if (!ValidationUtil.isEmpty(principalModel)) {
            principalModel.setPassword(null);
            principalModel.setSalt(null);
        }
        return principalModel;
    }

    @Override
    public PrincipalModel getPrincipal(Long userId) throws Exception {
        if(ValidationUtil.isEmpty(userId)){
            return null;
        }
        return beSafe(Bean.toModel(principalDAO.findByUserId(userId), new PrincipalModel()));
    }

    @Override
    public PrincipalModel updateLockStatus(Long userId) throws Exception {
        // #1启用/禁用用户的基础信息
        Principal currentPrincipal = principalDAO.findByUserId(userId);
        if (ValidationUtil.isEmpty(currentPrincipal)) {
            throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
        }
        String lockStatus = CoreConstants.COMMON_Y.equals(currentPrincipal.getLockStatus())
                ? CoreConstants.COMMON_N : CoreConstants.COMMON_Y;
        currentPrincipal.setLockStatus(lockStatus);
        principalDAO.update(currentPrincipal);

        // #2.启用/禁用登录信息，一个用户可能对应多个账号信息
        List<LoginInfo> loginInfos = loginInfoDAO.findLoginInfos(currentPrincipal.getUserId());
        for (LoginInfo loginInfo : loginInfos) {
            loginInfo.setLockStatus(lockStatus);
            loginInfoDAO.update(loginInfo);
        }
        // #3启用/禁用后清除用户的session
        this.cleanLoginCache(userId);
        return beSafe(Bean.toModel(currentPrincipal, new PrincipalModel()));
    }

    /**
     * TODO.清除用户的登录缓存,如登录信息,session信息等
     *
     * @param userId
     * @throws Exception
     */
    @Override
    public void cleanLoginCache(Long userId) throws Exception {
        List<Session> sessions = sessionDAO.findSessionsByUserId(userId);
        if (!ValidationUtil.isEmpty(sessions)) {
            for (Session e : sessions) {
                Redis.remove(SecurityConstants.CACHE_KEY_PREFIX_SESSION, e.getSessionId(), e.getProduct());
            }
        }
        Redis.removeSingle(Principal.class, userId.toString());

        List<LoginInfo> loginInfos = loginInfoDAO.findLoginInfos(userId);
        if (!ValidationUtil.isEmpty(loginInfos)) {
            for (LoginInfo loginInfo : loginInfos) {
                Redis.removeSingle(LoginInfo.class, loginInfo.getAgencyCode(), loginInfo.getLoginId());
            }
        }
    }

    @Override
    public void updatePassword(Long userId, String password, String oldPassword) throws Exception {
        // 重置员工的密码,要修改该员工对应的所有账号的密码
        Principal principal = principalDAO.findByUserId(userId);
        if (ValidationUtil.isEmpty(principal)) {
            throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
        }
        oldPassword = HashKit.md5(oldPassword, principal.getSalt());
        if (!oldPassword.equals(principal.getPassword())) {
            throw new DataValidateException(SecurityConstants.MESSAGE_OLD_PASSWORD_ERROR);
        }
        principal.setPassword(HashKit.md5(password, principal.getSalt()));
        principalDAO.update(principal);
        // 清除员工登录缓存
        this.cleanLoginCache(userId);
    }

    @Override
    public void resetPassword(Long userId) throws Exception {
        // 重置公网用户的密码,要重置该用户对应的所有账号的密码
        Principal currentPrincipal = principalDAO.findByUserId(userId);
        if (ValidationUtil.isEmpty(currentPrincipal)) {
            throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
        }
        currentPrincipal.setPassword(HashKit.md5(SecurityConstants.DEFAULT_USER_PASSWORD, currentPrincipal.getSalt()));
        principalDAO.update(currentPrincipal);

        // #5清除用户登录缓存
        this.cleanLoginCache(userId);
    }

    @Override
    public void updateCleanTestData(String userName, String cleanType) throws Exception {
        if(!SecurityConstants.USER_DATA_CLEAN_TYPE_ALL.equals(cleanType)
                && !SecurityConstants.USER_DATA_CLEAN_TYPE_BIZ.equals(cleanType))
            throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);

        String mobile = dictionaryService.getValue(
                CoreConstants.CODE_SUPER_ADMIN, DictionaryConstants.DICT_CODE_TEST_MOBILES, userName);
        if(ValidationUtil.isEmpty(mobile))
            throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);

        LoginInfo currentLoginInfo = loginInfoDAO.findLoginInfo(CoreConstants.CODE_SUPER_ADMIN, mobile);
        if (!ValidationUtil.isEmpty(currentLoginInfo)) {
            Long currentUserId = currentLoginInfo.getUserId();
            this.cleanLoginCache(currentUserId);
            Redis.removeSingle(Principal.class,currentUserId.toString());
            principalDAO.cleanTestData(currentUserId,cleanType);
        }
    }

    @Override
    public UserSession getOrRefreshSession(String token, String product)
            throws Exception {
        if (ValidationUtil.isEmpty(token)) {
            throw new UnauthorizedException(SecurityConstants.MESSAGE_TOKEN_REQUIRED);
        }
        if (ValidationUtil.isEmpty(product)) {
            throw new UnauthorizedException(SecurityConstants.MESSAGE_PRODUCT_REQUIRED);
        }

        UserSession userSession = Redis.get(SecurityConstants.CACHE_KEY_PREFIX_SESSION, token, product);

        // 如果缓存中没有session,则去session表中查找session,并刷新session
        if (ValidationUtil.isEmpty(userSession)) {
            userSession = authenticator.refreshSession(token, product);
        }

        if (ValidationUtil.isEmpty(userSession)) {
            throw new UnauthorizedException(ErrorCodeConstants.TOKEN_NOT_FOUND_CODE + SecurityConstants.splitor
                    + SecurityConstants.MESSAGE_TOKEN_NOT_FOUND);
        }
        return userSession;
    }

    @Override
    public UserSession authToken(String token, String product) throws Exception {
        if (ValidationUtil.isEmpty(token)) {
            throw new UnauthorizedException(SecurityConstants.MESSAGE_TOKEN_REQUIRED);
        }
        if (ValidationUtil.isEmpty(product)) {
            throw new UnauthorizedException(SecurityConstants.MESSAGE_PRODUCT_REQUIRED);
        }

        UserSession userSession = Redis.get(SecurityConstants.CACHE_KEY_PREFIX_SESSION, token, product);

        // 如果缓存中没有session,则继续判断是session失效还是用户被冻结
        if (ValidationUtil.isEmpty(userSession)) {
            LoginHistory lastLoginHistory = loginHistoryDAO.findLastLoginHistory(token, product);
            if (ValidationUtil.isEmpty(lastLoginHistory)) {
                throw new UnauthorizedException(SecurityConstants.MESSAGE_TOKEN_NOT_FOUND);
            }
            Principal currentPrincipal = principalDAO.findByUserId(lastLoginHistory.getUserId());
            if (ValidationUtil.isEmpty(currentPrincipal)) {
                throw new UnauthorizedException(SecurityConstants.MESSAGE_TOKEN_NOT_FOUND);
            }
            if (CoreConstants.COMMON_Y.equals(currentPrincipal.getLockStatus())) {
                throw new UserStatusException(SecurityConstants.MESSAGE_USER_LOCKED);
            }
            throw new UnauthorizedException(SecurityConstants.MESSAGE_TOKEN_EXPIRED);
        }
        return userSession;
    }

    @Override
    public UserSession createSession(IdType idType, AuthType authType,
                                     UserType userType, AuthRequestModel authModel) throws Exception {

        //#1登录认证,认证成功后返回会话信息
        UserSession userSession = authenticator.authenticate(idType, authType, userType, authModel);

        //#2清除旧的session信息
        List<Session> oldSessions = sessionDAO.findSessions(
                userSession.getAgencyCode(), userSession.getLoginId(), userSession.getProduct());
        for (Session session : oldSessions) {
            sessionDAO.delete(session.getSequenceNBR());
            Redis.remove(SecurityConstants.CACHE_KEY_PREFIX_SESSION, session.getSessionId(), session.getProduct());
        }
        //#3添加新session
        Session newSession = Bean.copyExistPropertis(userSession, new Session());
        newSession.setSequenceNBR(sequenceGenerator.getNextValue());
        sessionDAO.insert(newSession);

        //#4添加登录记录
        LoginHistory history = new LoginHistory();
        history = Bean.copyExistPropertis(newSession, history);
        history.setSequenceNBR(sequenceGenerator.getNextValue());
        history.setRecStatus(CoreConstants.COMMON_ACTIVE);
        history.setRecUserId(newSession.getUserId().toString());
        history.setRecDate(new Date());
        loginHistoryDAO.insert(history);

        //#5缓存新的session信息
        Redis.setWithExpire(userSession, Long.parseLong(userSession.getExpiration()),
                SecurityConstants.CACHE_KEY_PREFIX_SESSION, userSession.getSessionId(), userSession.getProduct());
        return userSession;
    }

    @Override
    public void updatePassword(String newPassword, String oldPassword) throws Exception {
        Long userId = Long.valueOf(RequestContext.getExeUserId());
        Principal principal = principalDAO.findByUserId(userId);
        if (ValidationUtil.isEmpty(principal)
                || ValidationUtil.isEmpty(oldPassword)
                || ValidationUtil.isEmpty(newPassword)) {
            throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
        }
        oldPassword = HashKit.md5(oldPassword, principal.getSalt());
        if (!oldPassword.equals(principal.getPassword())) {
            throw new DataValidateException(SecurityConstants.MESSAGE_OLD_PASSWORD_ERROR);
        }
        // #修改密码
        principal.setPassword(HashKit.md5(newPassword, principal.getSalt()));
        principalDAO.update(principal);

        // #清除用户登录缓存
        this.cleanLoginCache(principal.getUserId());
    }

    @Override
    public void updateNewPassword(String newPassword) throws Exception {
        Long userId = Long.valueOf(RequestContext.getExeUserId());
        Principal principal = principalDAO.findByUserId(userId);
        if (ValidationUtil.isEmpty(principal)
                || ValidationUtil.isEmpty(newPassword)) {
            throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
        }
        // #设置密码
        principal.setPassword(HashKit.md5(newPassword, principal.getSalt()));
        principalDAO.update(principal);

        // #清除用户登录缓存
        this.cleanLoginCache(principal.getUserId());
    }

    @Override
    public boolean isLoginIdAvailable(String agencyCode, String loginId) throws Exception {
        return loginInfoDAO.isLoginIdAvailable(agencyCode,loginId);
    }

    @Override
    public PrincipalModel getByMobile(String mobile) throws Exception {
        return Bean.toModel(principalDAO.findByMobile(mobile),new PrincipalModel());
    }

    @Override
    public void createLoginInfo(Long userId, String loginId, IdType idType) throws Exception {
        Principal principal = principalDAO.findByUserId(userId);
        if (ValidationUtil.isEmpty(principal)) {
            throw new DataNotFoundException(MessageConstants.DATA_NOT_FOUND);
        }
        LoginInfo targetLoginInfo = new LoginInfo();
        targetLoginInfo.setSequenceNBR(sequenceGenerator.getNextValue());
        targetLoginInfo.setAgencyCode(CoreConstants.CODE_SUPER_ADMIN);
        targetLoginInfo.setIdType(idType.name());
        targetLoginInfo.setUserId(userId);
        targetLoginInfo.setLoginId(loginId);
        targetLoginInfo.setRecUserId(RequestContext.getExeUserId());
        targetLoginInfo.setRecStatus(CoreConstants.COMMON_ACTIVE);
        targetLoginInfo.setRecDate(new Date());
        targetLoginInfo.setLockStatus(CoreConstants.COMMON_N);
        loginInfoDAO.insert(targetLoginInfo);
    }
}