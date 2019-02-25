package net.freeapis.security.service;

import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.exceptions.DataNotFoundException;
import net.freeapis.core.foundation.exceptions.DataValidateException;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.BaseServiceImpl;
import net.freeapis.core.mysql.ReferenceModel;
import net.freeapis.security.dao.ModulePrimaryDAO;
import net.freeapis.security.dao.PermissionDAO;
import net.freeapis.security.dao.RoleDAO;
import net.freeapis.security.dao.UserRoleDAO;
import net.freeapis.security.face.PermissionService;
import net.freeapis.security.face.RoleService;
import net.freeapis.security.face.constants.SecurityConstants;
import net.freeapis.security.face.entity.Role;
import net.freeapis.security.face.entity.UserRole;
import net.freeapis.security.face.model.RoleModel;
import net.freeapis.security.face.model.UserRoleModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * <pre>
 *
 *  freeapis
 *  File: RoleServiceImpl.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: RoleServiceImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年07月18日		framework		Initial.
 *
 * </pre>
 */
@Service(value = "roleService")
public class RoleServiceImpl extends BaseServiceImpl<RoleModel, Role> implements RoleService {

    @Autowired
    private RoleDAO roleDao;

    @Autowired
    private UserRoleDAO userRoleDao;

    @Autowired
    private ModulePrimaryDAO moduleRoleDao;

    @Autowired
    private PermissionDAO permissionDAO;

    @Autowired
    private PermissionService permissionService;

    @Override
    public RoleModel getRoleByCode(String agencyCode, String roleCode) throws Exception {
        return Bean.toModel(roleDao.findByCode(agencyCode, roleCode), new RoleModel());
    }


    @Override
    public List<RoleModel> getAllRoles(String agencyCode, String roleCode, String roleName, String lockStatus)
            throws Exception {
        List<RoleModel> models = Bean.toModels(roleDao.findRoles(agencyCode, roleCode, roleName, lockStatus), RoleModel.class);
        return models;
    }

    @Override
    public RoleModel createRole(String agencyCode, RoleModel roleModel) throws Exception {
        Role role = this.prepareEntity(roleModel);
        role.setAgencyCode(RequestContext.getAgencyCode());
        if (ValidationUtil.isEmpty(roleModel.getLockStatus())) {
            role.setLockStatus(CoreConstants.COMMON_N);
        }
        roleDao.insert(role);
        return Bean.toModel(role, roleModel);
    }

    @Override
    public Page getByPage(String agencyCode, String roleCode, String roleName, String lockStatus, Page page,
                          String orderBy, String order) throws Exception {
        List<RoleModel> models = Bean.toModels(roleDao.findByPage(agencyCode, roleCode, roleName, lockStatus, page, orderBy, order), RoleModel.class);
        page.setList(models);
        return page;
    }

    @Override
    public RoleModel updateRole(RoleModel roleModel) throws Exception {
        Role role = roleDao.findByCode(RequestContext.getAgencyCode(), roleModel.getRoleCode());
        if (ValidationUtil.isEmpty(role)) {
            throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
        }
        Bean.copyExistPropertis(roleModel, role);
        role.setRecDate(new Date());
        role.setRecUserId(RequestContext.getExeUserId());
        roleDao.update(role);
        //清除该角色对应的所有缓存
        permissionService.clearPrimaryPermissionCache(role.getAgencyCode(), SecurityConstants.PERMISSION_PRIMARY_ROLE,role.getRoleCode());
        return Bean.toModel(role, roleModel);
    }

    @Override
    public String[] deleteRole(String agencyCode, String[] roleCodes) throws Exception {

        for (String roleCode : roleCodes) {
            Role role = roleDao.findByCode(agencyCode, roleCode);
            if (ValidationUtil.isEmpty(role)) {
                throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
            }
            String msg = userRoleDao.deleteCheck(
                    new ReferenceModel("SECURITY_USER_ROLE", new String[]{"ROLE_CODE"}, new String[]{roleCode}, "商家员工"));
            if (!ValidationUtil.isEmpty(msg)) {
                throw new DataValidateException(msg);
            }
            roleDao.deleteByRoleCode(agencyCode, roleCode);
            //删除角色对应的资源
            moduleRoleDao.deleteByPrimaryInfo(agencyCode,SecurityConstants.PERMISSION_PRIMARY_ROLE, roleCode);
            //删除角色对应的模块
            permissionDAO.deleteByPrimaryInfo(agencyCode,SecurityConstants.PERMISSION_PRIMARY_ROLE, roleCode);
            //清除该角色对应的所有缓存
            permissionService.clearPrimaryPermissionCache(agencyCode,SecurityConstants.PERMISSION_PRIMARY_ROLE, roleCode);

        }
        return roleCodes;
    }

    @Override
    public RoleModel updateLockStatus(String roleCode) throws Exception {
        Role role = roleDao.findByCode(RequestContext.getAgencyCode(), roleCode);
        if (ValidationUtil.isEmpty(role)) {
            throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
        }

        String lockStatus = CoreConstants.COMMON_Y.equals(role.getLockStatus()) ? CoreConstants.COMMON_N : CoreConstants.COMMON_Y;
        role.setRecDate(new Date());
        role.setLockStatus(lockStatus);
        if (CoreConstants.COMMON_Y.equals(lockStatus)) {
            String msg = userRoleDao.deleteCheck(
                    new ReferenceModel("SECURITY_USER_ROLE", new String[]{"ROLE_CODE"}, new String[]{roleCode}, "商家员工"));
            if (!ValidationUtil.isEmpty(msg)) {
                throw new DataValidateException(msg);
            }
            role.setLockDate(new Date());
            role.setLockUserId(RequestContext.getExeUserId());
        }
        roleDao.update(role);
        //清除该角色对应的所有缓存
        permissionService.clearPrimaryPermissionCache(role.getAgencyCode(),SecurityConstants.PERMISSION_PRIMARY_ROLE, roleCode);
        return Bean.toModel(role, new RoleModel());
    }

    public boolean isRoleNameAvailable(String roleName, Long id) throws Exception {
        return roleDao.isRoleNameAvailable(roleName, id);
    }

    public boolean isRoleCodeAvailable(String roleCode, Long id) throws Exception {
        return roleDao.isRoleCodeAvailable(roleCode, id);
    }

    @Override
    public Set<String> getSpuPoolsByUserId(Long userId) throws Exception {
        List<Map<String, Object>> spuPools = roleDao.findSpuPoolsByUserId(userId);
        if(!ValidationUtil.isEmpty(spuPools)){
            //商品库去重并以逗号分割返回
            Set<String> spuPoolSet = new HashSet<>();
            spuPools.forEach(spuPool->{
                String tempPools = (String)spuPool.get("spuPools");
                if(!ValidationUtil.isEmpty(tempPools)){
                    spuPoolSet.addAll(Arrays.asList(tempPools.split(",")));
                }
            });
            return spuPoolSet;
        }
        return new HashSet<>();
    }

    @Override
    public Set<String> getProduceRecordTypeByUserId(Long userId) throws Exception {
        List<Map<String, Object>> spuPools = roleDao.findProduceRecordTypeByUserId(userId);
        if(!ValidationUtil.isEmpty(spuPools)){
            //采购记录类型去重并以逗号分割返回
            Set<String> spuPoolSet = new HashSet<>();
            spuPools.forEach(spuPool->{
                String tempPools = (String)spuPool.get("produceRecordType");
                if(!ValidationUtil.isEmpty(tempPools)){
                    spuPoolSet.addAll(Arrays.asList(tempPools.split(",")));
                }
            });
            return spuPoolSet;
        }
        return new HashSet<>();
    }

    @Override
    public List<Map<String, Object>> getRoleRelevanceUserId(String agencyCode, String roleCode) throws Exception {
        List<Map<String, Object>> longs = (userRoleDao.findRoleRelevanceUserId(agencyCode, roleCode));
        if (!ValidationUtil.isEmpty(longs)) {
            return longs;
        }
        return null;
    }

    @Override
    public List<UserRoleModel> getRoleRelevanceRoleCode() throws Exception {
        List<UserRole> userRoles = userRoleDao.findUserRoles(RequestContext.getAgencyCode(), Long.valueOf(RequestContext.getExeUserId()));
        if (ValidationUtil.isEmpty(userRoles)) {
            throw new DataNotFoundException(MessageConstants.DATA_NOT_FOUND);
        }
        return Bean.toModels(userRoles, UserRoleModel.class);
    }
}