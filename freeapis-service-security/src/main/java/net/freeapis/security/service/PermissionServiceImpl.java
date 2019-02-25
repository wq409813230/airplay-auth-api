package net.freeapis.security.service;

import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.enumeration.UserType;
import net.freeapis.core.foundation.exceptions.DataNotFoundException;
import net.freeapis.core.foundation.exceptions.DataValidateException;
import net.freeapis.core.foundation.sequence.SequenceGenerator;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.security.dao.*;
import net.freeapis.security.face.ModuleService;
import net.freeapis.security.face.PermissionService;
import net.freeapis.security.face.constants.SecurityConstants;
import net.freeapis.security.face.entity.*;
import net.freeapis.security.face.model.ModuleModel;
import net.freeapis.security.face.model.ModuleOperationModel;
import net.freeapis.security.face.model.PrimarySecurityModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;


/**
 * <pre>
 *
 *  freeapis
 *  File: PrivilegeServiceImpl.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: PrivilegeServiceImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年07月18日		framework		Initial.
 *
 * </pre>
 */
@Service(value = "permissionService")
public class PermissionServiceImpl implements PermissionService {
    @Autowired
    UserRoleDAO userRoleDAO;

    @Autowired
    ModulePrimaryDAO modulePrimaryDAO;

    @Autowired
    PermissionDAO permissionDAO;

    @Autowired
    SequenceGenerator sequenceGenerator;

    @Autowired
    ModuleDAO moduleDAO;

    @Autowired
    OperationDAO operationDAO;

    @Autowired
    ModuleOperationDAO moduleOperationDAO;

    @Autowired
    RoleDAO roleDAO;

    @Autowired
    ModuleService moduleService;

    @Autowired
    EmployeeDAO employeeDAO;

    @Autowired
    LoginInfoDAO loginInfoDAO;


    @Override
    public ModuleModel getCurrentUserModuleTree() throws Exception {
        ModuleModel moduleModel = Redis.get(SecurityConstants.CACHE_KEY_USER_MODULE_TREE,RequestContext.getAgencyCode(),RequestContext.getExeUserId());
        if(ValidationUtil.isEmpty(moduleModel)){
            //系统管理员
            if(UserType.SUPER_ADMIN==RequestContext.getUserType()
                    && CoreConstants.SUPER_USER_ID.equals(Long.valueOf(RequestContext.getExeUserId()))){
                moduleModel = moduleService.buildModuleTree(RequestContext.getAgencyCode());
            }
            //商家管理员
            else if(UserType.AGENCY_USER==RequestContext.getUserType()){
                Employee employee = employeeDAO.findByUserId(Long.valueOf(RequestContext.getExeUserId()));
                if(CoreConstants.ADMIN_LOGIN_ID.equals(employee.getEmployeeCode())){
                    moduleModel = moduleService.buildModuleTree(RequestContext.getAgencyCode());
                }
            }
            else//普通系统用户
            {
                Map<Object, ModuleModel> moduleMap = new HashMap<Object, ModuleModel>();
                //获取用户所有角色对应的模块信息
                List<UserRole> userRoles = userRoleDAO.findByLockStatus(RequestContext.getAgencyCode(), Long.parseLong(RequestContext.getExeUserId()), CoreConstants.COMMON_N);
                //获取自身的权限信息
                List<ModulePrimary> userModules = modulePrimaryDAO.findByPrimaryInfo(RequestContext.getAgencyCode(),SecurityConstants.PERMISSION_PRIMARY_USER,RequestContext.getExeUserId());
                //获取用户角色对应的模块信息
                for (UserRole userRole : userRoles) {
                    userModules.addAll(modulePrimaryDAO.findByPrimaryInfo(userRole.getAgencyCode(),SecurityConstants.PERMISSION_PRIMARY_ROLE,userRole.getRoleCode()));
                }
                if(!ValidationUtil.isEmpty(userModules)){
                    //过滤重复的模块信息
                    Set<String> moduleCode = new HashSet<String>();
                    for (ModulePrimary  modulePrimary: userModules) {
                        moduleCode.add(modulePrimary.getModuleCode());
                    }
                    //开始构建模块树
                    for(String tempModuleCode:moduleCode){
                        Module module = moduleDAO.findByModuleCode(RequestContext.getAgencyCode(),tempModuleCode);
                        moduleMap.put(tempModuleCode, Bean.copyExistPropertis(module, new ModuleModel()));
                    }
                    createModuleTree(moduleMap);
                    moduleModel = moduleMap.get(SecurityConstants.MODULE_ROOT_CODE);
                }
            }
            if(!ValidationUtil.isEmpty(moduleModel)){
                //查询完之后进行排序
                sortModuleTree(moduleModel);
                Redis.set(moduleModel,SecurityConstants.CACHE_KEY_USER_MODULE_TREE,RequestContext.getAgencyCode(),RequestContext.getExeUserId());
            }
        }
        return moduleModel;
    }

    @Override
    public List<ModuleModel> getModelOperations(String agencyCode) throws Exception {
        List<ModuleModel> moduleTree = Redis.get(SecurityConstants.CACHE_KEY_AGENCY_OPERATION, agencyCode);
        if (ValidationUtil.isEmpty(moduleTree)) {
            //获取非系统模块信息
            List<Module> modules = moduleDAO.findByAgencyCode(agencyCode);
            List<ModuleModel> moduleModels = Bean.toModels(modules,ModuleModel.class);
            for (ModuleModel moduleModel : moduleModels) {
                //设置模块权限信息
                if(SecurityConstants.MODULE_CONTENT_TYPE_BUTTON.equals(moduleModel.getChildContentType())){
                    List<ModuleOperation> moduleOperation = moduleOperationDAO.findByModuleCode(agencyCode,moduleModel.getModuleCode());
                    moduleModel.setOperations(Bean.toModels(moduleOperation,ModuleOperation.class));
                }
            }
            Map<Object, ModuleModel> map = Bean.listToMap(moduleModels, "moduleCode", ModuleModel.class);
            createModuleTree(map);
            //查询完之后进行排序
            ModuleModel rootModuleModel = map.get(SecurityConstants.MODULE_ROOT_CODE);
            sortModuleTree(rootModuleModel);
            //将所有model不为空的资源全部返回
            moduleTree = new ArrayList<ModuleModel>();
            recursionModelOperation(rootModuleModel,moduleTree);
            //将模块权限树存放到缓存中
            Redis.set(moduleTree, SecurityConstants.CACHE_KEY_AGENCY_OPERATION, agencyCode);
        }
        return moduleTree;
    }

    private void recursionModelOperation(ModuleModel moduleModel,List<ModuleModel> returnModelOperationList) {
        List<ModuleModel> child = moduleModel.getChildren();
        if (!ValidationUtil.isEmpty(child)) {
            for (ModuleModel module : child) {
                if (module.getLevelNum() == CoreConstants.COMMON_1_INT) {
                    returnModelOperationList.add(module);
                }
                recursionModelOperation(module, returnModelOperationList);
            }
        }

    }

    @Override
    public List<Object> getPrimaryPermissions(String agencyCode, String primaryType, String primaryCode) throws Exception {
        List<Object> primaryPermissions = Redis.get(SecurityConstants.CACHE_KEY_PRIMARY_PERMISSION,agencyCode,primaryType,primaryCode);
        if(ValidationUtil.isEmpty(primaryPermissions)){
            List<ModulePrimary> modulePrimaries = modulePrimaryDAO.findByPrimaryInfo(agencyCode,primaryType,primaryCode);
            if (!ValidationUtil.isEmpty(modulePrimaries)) {
                primaryPermissions = new ArrayList<Object>();
                for (ModulePrimary modulePrimary: modulePrimaries) {
                    List<Permission> permissions = permissionDAO.findByPrimaryInfo(modulePrimary.getAgencyCode(),modulePrimary.getModuleCode(),primaryType,primaryCode);
                    if (!ValidationUtil.isEmpty(permissions)) {
                        List<String> fidObj = null;
                        for (Permission permission : permissions) {
                            fidObj  = new ArrayList<String>();
                            fidObj.add(permission.getModuleCode());
                            fidObj.add(permission.getButtonCode());
                            primaryPermissions.add(fidObj);
                        }
                    }
                }
            }
            Redis.set(primaryPermissions,SecurityConstants.CACHE_KEY_PRIMARY_PERMISSION,agencyCode,primaryType,primaryCode);
        }
        return primaryPermissions;
    }

    @Override
    public Map<String,Set<String>> getCurrentUserModuleButtons() throws Exception {
        Map<String,Set<String>> buttons = Redis.get(SecurityConstants.CACHE_KEY_USER_BUTTONS,RequestContext.getAgencyCode(),RequestContext.getExeUserId());
        if(ValidationUtil.isEmpty(buttons)) {
            Set<String> currentFuncIds = new HashSet<>();
            buttons = new HashMap<String, Set<String>>();
            //系统管理员
            if(UserType.SUPER_ADMIN==RequestContext.getUserType()
                    && CoreConstants.SUPER_USER_ID.equals(Long.valueOf(RequestContext.getExeUserId()))){
                 initSuperOrAdminButtonAndFuncId(buttons,currentFuncIds);
            }
            //商家管理员
            else if(UserType.AGENCY_USER==RequestContext.getUserType()){
                Employee employee = employeeDAO.findByUserId(Long.valueOf(RequestContext.getExeUserId()));
                if(CoreConstants.ADMIN_LOGIN_ID.equals(employee.getEmployeeCode())){
                    initSuperOrAdminButtonAndFuncId(buttons,currentFuncIds);
                }
            }
            //普通用户
            else{
                //获取用户所有角色的按钮以及funcId信息
                List<Permission> permissions = permissionDAO.findByPrimaryInfo(RequestContext.getAgencyCode(),null,SecurityConstants.PERMISSION_PRIMARY_USER,RequestContext.getExeUserId());
                currentFuncIds.addAll(permissionDAO.findPrimaryFuncIds(RequestContext.getAgencyCode(),SecurityConstants.PERMISSION_PRIMARY_USER,RequestContext.getExeUserId()));
                List<UserRole> userRoles = userRoleDAO.findByLockStatus(RequestContext.getAgencyCode(), Long.parseLong(RequestContext.getExeUserId()), CoreConstants.COMMON_N);
                for (UserRole userRole : userRoles) {
                    permissions.addAll(permissionDAO.findByPrimaryInfo(RequestContext.getAgencyCode(),null,SecurityConstants.PERMISSION_PRIMARY_ROLE,userRole.getRoleCode()));
                    currentFuncIds.addAll(permissionDAO.findPrimaryFuncIds(RequestContext.getAgencyCode(),SecurityConstants.PERMISSION_PRIMARY_ROLE,userRole.getRoleCode()));
                }
                for (Permission permission : permissions) {
                    if (ValidationUtil.isEmpty(buttons.get(permission.getModuleCode()))) {
                        buttons.put(permission.getModuleCode(), new HashSet<String>());
                    }
                    buttons.get(permission.getModuleCode()).add(permission.getButtonCode());
                }
            }
            if(!ValidationUtil.isEmpty(buttons)){
                Redis.set(buttons,SecurityConstants.CACHE_KEY_USER_BUTTONS,RequestContext.getAgencyCode(),RequestContext.getExeUserId());
                Redis.set(currentFuncIds,SecurityConstants.CACHE_KEY_USER_FUNC_IDS,RequestContext.getAgencyCode(),RequestContext.getExeUserId());
            }
        }
        return buttons;
    }

    /**
     * 获取管理员的所有模块按钮编码
     * @param buttons
     * @param currentUserIds
     * @return
     * @throws Exception
     */
    private void initSuperOrAdminButtonAndFuncId(Map<String,Set<String>> buttons, Set<String> currentUserIds) throws Exception {
        List<ModuleOperation> moduleOperations = moduleOperationDAO.findByAgencyCode(RequestContext.getAgencyCode());
        for (ModuleOperation moduleOperation : moduleOperations) {
            if (ValidationUtil.isEmpty(buttons.get(moduleOperation.getModuleCode()))) {
                buttons.put(moduleOperation.getModuleCode(), new HashSet<String>());
            }
            buttons.get(moduleOperation.getModuleCode()).add(moduleOperation.getButtonCode());
            if(!ValidationUtil.isEmpty(moduleOperation.getFuncId())
                    && SecurityConstants.MODULE_BUTTON_TYPE_API.equalsIgnoreCase(moduleOperation.getButtonType())){
                currentUserIds.add(moduleOperation.getFuncId());
            }
        }
    }

    @Override
    public PrimarySecurityModel createPermission(PrimarySecurityModel primarySecurityModel) throws Exception {
        // 数据验证
        if (ValidationUtil.isEmpty(primarySecurityModel) || ValidationUtil.isEmpty(primarySecurityModel.getPrimaryType())
                || ValidationUtil.isEmpty(primarySecurityModel.getPrimaryCode())
                || ValidationUtil.isEmpty(primarySecurityModel.getAgencyCode())) {
            throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
        }
        for (ModuleOperationModel moduleResourceModel : primarySecurityModel.getPrivilege()) {
            if (ValidationUtil.isEmpty(moduleResourceModel.getModuleCode())
                    || ValidationUtil.isEmpty(moduleResourceModel.getButtonCode())) {
                throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
            }
        }
        // 删除原有的权限模块关系
        modulePrimaryDAO.deleteByPrimaryInfo(primarySecurityModel.getAgencyCode(), primarySecurityModel.getPrimaryType(),primarySecurityModel.getPrimaryCode());
        // 删除原有的权限资源关系
        permissionDAO.deleteByPrimaryInfo(primarySecurityModel.getAgencyCode(),primarySecurityModel.getPrimaryType(),primarySecurityModel.getPrimaryCode());
        //清除缓存
        clearPrimaryPermissionCache(primarySecurityModel.getAgencyCode(), primarySecurityModel.getPrimaryType(),primarySecurityModel.getPrimaryCode());
        if (!ValidationUtil.isEmpty(primarySecurityModel.getPrivilege())) {
            Set<String> roleModuleSet = new HashSet<String>();
            for (ModuleOperationModel moduleResourceModel : primarySecurityModel.getPrivilege()) {
                //添加角色资源权限信息
                Permission permission = new Permission();
                permission.setAgencyCode(primarySecurityModel.getAgencyCode());
                permission.setPrimaryType(primarySecurityModel.getPrimaryType());
                permission.setPrimaryCode(primarySecurityModel.getPrimaryCode());
                permission.setModuleCode(moduleResourceModel.getModuleCode());
                permission.setButtonCode(moduleResourceModel.getButtonCode());
                permission.setRecDate(new Date());
                permission.setRecStatus(CoreConstants.COMMON_Y);
                permission.setRecUserId(RequestContext.getExeUserId());
                permission.setSequenceNBR(sequenceGenerator.getNextValue());
                permissionDAO.insert(permission);
                //组装角色模块集合信息
                roleModuleSet.add(moduleResourceModel.getModuleCode());
            }
            //递归获取父节模块
            Set<String> allRoleModelSet = new HashSet<String>();
            if (!ValidationUtil.isEmpty(roleModuleSet)) {
                for (String moduleCode : roleModuleSet) {
                    recursiveGetModelSet(primarySecurityModel.getAgencyCode(),allRoleModelSet, moduleCode);
                }
            }
            //保存主体模块权限数据
            if (!ValidationUtil.isEmpty(allRoleModelSet)) {
                for (String moduleCode : allRoleModelSet) {
                    ModulePrimary moduleRole = new ModulePrimary();
                    moduleRole.setAgencyCode(primarySecurityModel.getAgencyCode());
                    moduleRole.setModuleCode(moduleCode);
                    moduleRole.setPrimaryType(primarySecurityModel.getPrimaryType());
                    moduleRole.setPrimaryCode(primarySecurityModel.getPrimaryCode());
                    moduleRole.setRecDate(new Date());
                    moduleRole.setRecStatus(CoreConstants.COMMON_Y);
                    moduleRole.setRecUserId(RequestContext.getExeUserId());
                    moduleRole.setSequenceNBR(sequenceGenerator.getNextValue());
                    modulePrimaryDAO.insert(moduleRole);
                }
            }
        }
        //清除缓存
        clearPrimaryPermissionCache(primarySecurityModel.getAgencyCode(), primarySecurityModel.getPrimaryType(),primarySecurityModel.getPrimaryCode());
        return primarySecurityModel;
    }

    @Override
    public void clearPrimaryPermissionCache(String agencyCode,String primaryType,String primaryCode) throws Exception {
        Redis.remove(SecurityConstants.CACHE_KEY_PRIMARY_PERMISSION,agencyCode,primaryType,primaryCode);
        //清除角色对应的所有用户缓存
        if(SecurityConstants.PERMISSION_PRIMARY_ROLE.equals(primaryType)){
            List<UserRole> userRoles = userRoleDAO.findByRoleCode(agencyCode,primaryCode);
            if(!ValidationUtil.isEmpty(userRoles)){
                for(UserRole userRole : userRoles){
                    clearUserPermissionCache(agencyCode,userRole.getUserId());
                }
            }
        }
        //清除用户缓存
        else if(SecurityConstants.PERMISSION_PRIMARY_USER.equals(primaryType)){
            clearUserPermissionCache(agencyCode,Long.valueOf(primaryCode));
        }

    }

    @Override
    public void clearUserPermissionCache(String agencyCode, Long userId) throws Exception {
        Redis.remove(SecurityConstants.CACHE_KEY_USER_MODULE_TREE,agencyCode,userId.toString());
        Redis.remove(SecurityConstants.CACHE_KEY_USER_BUTTONS,agencyCode,userId.toString());
    }

    private void recursiveGetModelSet(String agencyCode,Set<String> allRoleModelSet, String moduleCode) throws Exception {
        Module module = moduleDAO.findByModuleCode(agencyCode,moduleCode);
        allRoleModelSet.add(module.getModuleCode());
        if (!SecurityConstants.MODULE_ROOT_CODE.equals(module.getParentCode())) {
            recursiveGetModelSet(agencyCode,allRoleModelSet, module.getParentCode());
        }
    }

    /**
     * 递归对树节点的每一层进行排序
     *
     * @param moduleModel
     */
    private void sortModuleTree(ModuleModel moduleModel) {
        List<ModuleModel> child = moduleModel.getChildren();
        if (ValidationUtil.isEmpty(child)) {
            return;
        }
        Collections.sort(child);
        for (ModuleModel module : child) {
            sortModuleTree(module);
        }
    }

    /**
     * 构造模块树
     *
     * @param moduleMap
     * @throws Exception
     */
    private void createModuleTree(Map<Object, ModuleModel> moduleMap) throws Exception {
        //构造根节点
        ModuleModel rootModel = new ModuleModel();
        rootModel.setAgencyCode(RequestContext.getAgencyCode());
        rootModel.setModuleCode(SecurityConstants.MODULE_ROOT_CODE);
        rootModel.setParentCode(SecurityConstants.MODULE_ROOT_PCODE);
        rootModel.setModuleName("全部模块");
        moduleMap.put(SecurityConstants.MODULE_ROOT_CODE, rootModel);
        for (Object moduleCode : moduleMap.keySet()) {
            String parentCode = moduleMap.get(moduleCode).getParentCode();
            if (SecurityConstants.MODULE_ROOT_PCODE.equals(parentCode)) {
                continue;
            }
            if(ValidationUtil.isEmpty(moduleMap.get(parentCode))){
                throw new DataNotFoundException("父模块Code【"+parentCode+"】不存在.");
            }
            if (ValidationUtil.isEmpty(moduleMap.get(parentCode).getChildren())) {
                moduleMap.get(parentCode).setChildren(new ArrayList<ModuleModel>());
            }
            moduleMap.get(parentCode).getChildren().add(moduleMap.get(moduleCode));
        }
    }
}
