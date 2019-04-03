package net.freeapis.security.service;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.exceptions.BusinessException;
import net.freeapis.core.foundation.exceptions.DataNotFoundException;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.BaseServiceImpl;
import net.freeapis.security.dao.EmployeeDAO;
import net.freeapis.security.dao.PrincipalDAO;
import net.freeapis.security.dao.UserRoleDAO;
import net.freeapis.security.face.EmployeeService;
import net.freeapis.security.face.PermissionService;
import net.freeapis.security.face.SecurityService;
import net.freeapis.security.face.constants.SecurityConstants;
import net.freeapis.security.face.entity.Employee;
import net.freeapis.security.face.entity.Principal;
import net.freeapis.security.face.enums.IdType;
import net.freeapis.security.face.model.EmployeeModel;
import net.freeapis.security.face.model.PrincipalModel;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <pre>
 *
 *  freeapis
 *  File: EmployeeServiceImpl.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: EmployeeServiceImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016-09-09 15:33:42		freeapis		Initial.
 *
 * </pre>
 */
@Service(value = "employeeService")
public class EmployeeServiceImpl extends BaseServiceImpl<EmployeeModel, Employee> implements EmployeeService {
    @Autowired
    private SecurityService securityService;

    @Autowired
    private EmployeeDAO employeeDAO;

    @Autowired
    private UserRoleDAO userRoleDAO;

    @Autowired
    PrincipalDAO principalDAO;

    @Autowired
    PermissionService permissionService;

    @Override
    public EmployeeModel createEmployee(EmployeeModel employeeModel) throws Exception {
        if (ValidationUtil.isEmpty(RequestContext.getAgencyCode())) {
            throw new DataNotFoundException(MessageConstants.DATA_NOT_FOUND);
        }
        //#创建主体信息
        PrincipalModel principalModel = new PrincipalModel();
        principalModel.setAgencyCode(RequestContext.getAgencyCode());
        principalModel.setLoginId(employeeModel.getEmployeeCode());
        principalModel.setUserName(employeeModel.getUserName());
        principalModel.setNickName(employeeModel.getNickName());
        principalModel.setRealName(employeeModel.getRealName());
        principalModel.setGender(employeeModel.getGender());
        principalModel.setBirthDate(employeeModel.getBirthDate());
        principalModel.setAvatar(employeeModel.getAvatar());
        principalModel.setPassword(SecurityConstants.DEFAULT_USER_PASSWORD);
        principalModel.setMobile(employeeModel.getMobile());
        principalModel.setRoleCodes(employeeModel.getRoleCodes());
        principalModel.setLoginId(employeeModel.getEmployeeCode());
        principalModel.setLockStatus(employeeModel.getLockStatus());
        principalModel.setUserType(RequestContext.getUserType().getValue());
        principalModel = securityService.createPrincipal(principalModel, IdType.employeeCode);

        //#1创建员工信息
        Employee employee = this.prepareEntity(employeeModel);
        employee.setSequenceNBR(principalModel.getUserId());
        employee.setUserId(principalModel.getUserId());
        employee.setAgencyCode(RequestContext.getAgencyCode());
        employee.setNeedChangePass(CoreConstants.COMMON_Y);
        employeeDAO.insert(employee);

        EmployeeModel model = Bean.toModel(employee, new EmployeeModel());
        Bean.copyExistPropertis(principalModel, model);
        return model;
    }

    @Override
    public void deleteEmployee(Long userId) throws Exception {
        securityService.deleteSecurityInfo(userId);
        employeeDAO.deleteByUserId(userId);
    }

    @Override
    public EmployeeModel updateEmployee(EmployeeModel employeeModel) throws Exception {
        Employee currentEmployee = employeeDAO.findByUserId(employeeModel.getUserId());
        if (ValidationUtil.isEmpty(currentEmployee)) {
            throw new DataNotFoundException(MessageConstants.DATA_NOT_FOUND);
        }
        Bean.copyExistPropertis(employeeModel, currentEmployee);
        currentEmployee.setRecDate(new Date());
        currentEmployee.setRecUserId(RequestContext.getExeUserId());
        employeeDAO.update(currentEmployee);
        //修改主体信息
        PrincipalModel currentPrincipal = Bean.copyExistPropertis(employeeModel, new PrincipalModel());
        securityService.updatePrincipal(currentPrincipal);
        Bean.copyExistPropertis(currentPrincipal, employeeModel);
        //清除用户权限缓存
        permissionService.clearUserPermissionCache(currentPrincipal.getAgencyCode(),currentPrincipal.getUserId());
        return employeeModel;
    }

    @Override
    public EmployeeModel getEmployee(Long id) throws Exception {
        Employee employee = employeeDAO.findByUserId(id);
        EmployeeModel result = null;
        if (!ValidationUtil.isEmpty(employee)) {
            result = Bean.toModel(employee, new EmployeeModel());
            PrincipalModel currentPrincipal = securityService.getPrincipal(result.getUserId());
            if (!ValidationUtil.isEmpty(currentPrincipal)) {
                BeanUtils.copyProperties(currentPrincipal, result);
                //查询用户角色
                List<Map<String, Object>> userRoles = userRoleDAO.findUserRolesInfo(currentPrincipal.getAgencyCode(), currentPrincipal.getUserId());
                StringBuffer roleCodes = new StringBuffer();
                StringBuffer roleNames = new StringBuffer();
                for (Map<String, Object> userRole : userRoles) {
                    roleCodes.append(userRole.get("roleCode") + ",");
                    roleNames.append(userRole.get("roleName") + ",");
                }
                if (!ValidationUtil.isEmpty(roleCodes.toString())) {
                    roleCodes.deleteCharAt(roleCodes.length() - 1);
                }
                if (!ValidationUtil.isEmpty(roleNames.toString())) {
                    roleNames.deleteCharAt(roleNames.length() - 1);
                }
                result.setRoleCodes(roleCodes.toString());
                result.setRoleNames(roleNames.toString());
            }
        }
        return result;
    }

    @Override
    public boolean isEmployeeCodeAvailable(String agencyCode, String employeeCode) throws Exception {
        return employeeDAO.isEmployeeCodeAvailable(RequestContext.getAgencyCode(), employeeCode);
    }

    @Override
    public EmployeeModel updateLockStatus(Long userId) throws Exception {
        Employee currentEmployee = employeeDAO.findByUserId(userId);
        if (ValidationUtil.isEmpty(currentEmployee)) {
            throw new DataNotFoundException(MessageConstants.DATA_NOT_FOUND);
        }
        PrincipalModel principalModel = securityService.updateLockStatus(currentEmployee.getUserId());
        EmployeeModel employeeModel = Bean.toModel(currentEmployee, new EmployeeModel());
        Bean.copyExistPropertis(principalModel, employeeModel);
        //清除用户权限缓存
        permissionService.clearUserPermissionCache(employeeModel.getAgencyCode(),userId);
        return employeeModel;
    }

    @Override
    public Page getByPage(String agencyCode, String departmentCode, String userName, String employeeCode, Page page, String orderBy, String order) throws Exception {
        List<Map<String, Object>> listEntity = employeeDAO.findByPage(agencyCode, departmentCode, userName, employeeCode, page, orderBy, order);
        List<EmployeeModel> listModel = Bean.listMap2ListBean(listEntity, EmployeeModel.class);
        page.setList(listModel);
        return page;
    }

    @Override
    public void updatePasswordBySelf(EmployeeModel employeeModel) throws Exception {
        Employee employee = employeeDAO.findByUserId(Long.valueOf(RequestContext.getExeUserId()));
        if (ValidationUtil.isEmpty(employee)) {
            throw new DataNotFoundException(MessageConstants.DATA_NOT_FOUND);
        }
        securityService.updatePassword(employee.getUserId(), employeeModel.getPassword(), employeeModel.getOldPassword());
    }

    @Override
    public String getEmployeeMobile(String employeeCode) throws Exception {
       List<String> stringList = employeeDAO.findEmployeeMobile(employeeCode);
        if (ValidationUtil.isEmpty(stringList)){
           throw new BusinessException(MessageConstants.DATA_NOT_FOUND);
        }
        return stringList.get(0);
    }

    @Override
    public List<Map<String, String>> getBrieflyEmployee() throws Exception {
        List<Principal> principals = principalDAO.findBrieflyEmployee(RequestContext.getAgencyCode(),RequestContext.getUserType().getValue());
        if (ValidationUtil.isEmpty(principals)){
            return Lists.newArrayList();
        }
        List<Map<String, String>> brieflyEmployees = Lists.newArrayList();
        for (Principal principal : principals){
            Map<String, String> brieflyEmployeeMap = Maps.newHashMap();
            brieflyEmployeeMap.put("userId",principal.getUserId().toString());
            brieflyEmployeeMap.put("userName",principal.getUserName());
            brieflyEmployees.add(brieflyEmployeeMap);
        }
        return brieflyEmployees;
    }

    @Override
    public List<Long> getUserIdsByDepartmentCode(String agencyCode, String departmentCode) throws Exception {
        return employeeDAO.findUserIdsByDepartmentCode(agencyCode,departmentCode);
    }

    @Override
    public List<Map<String, Object>> getBrieflyEmployee(String roleCode) throws Exception {
        List<Map<String,Object>> result = principalDAO.findBrieflyEmployeeByRoleCode(roleCode,RequestContext.getAgencyCode(),RequestContext.getUserType().getValue());
        return result;
    }

    @Override
    public List<Map<String, Object>> getUserDepartmentNameByUserIds(List<Long> userIds) throws Exception {
        List<Map<String, Object>> principalMaps = principalDAO.findUserNameByUserIds(userIds);
        List<Map<String, Object>> departmentMaps = employeeDAO.findEmployeeDepartmentByUserIds(userIds);
        for (Map<String, Object> principalMap : principalMaps) {
            Long userId = ((BigInteger) principalMap.get("USER_ID")).longValue();
            for(Map<String, Object> department:departmentMaps){
                if(!ValidationUtil.isEmpty(department.get("USER_ID"))){
                    if(userId.equals(Long.valueOf(department.get("USER_ID").toString()))){
                        principalMap.put("DEPARTMENT_NAME",ValidationUtil.isEmpty(department.get("DEPARTMENT_NAME"))
                                ?"":department.get("DEPARTMENT_NAME").toString());
                    }
                }
            }
            if (ValidationUtil.isEmpty(principalMap.get("DEPARTMENT_NAME")) &&
                    userId.equals(CoreConstants.SUPER_USER_ID)){
                principalMap.put("DEPARTMENT_NAME","超级管理员");
            }
        }
        return principalMaps;
    }

    @Override
    public List<Map<String, Object>> getEmployeesByDepartmentCode(String agencyCode, String departmentCode, String localStatus) throws Exception {
        return employeeDAO.findEmployeesByDepartmentCode(agencyCode, departmentCode, localStatus);
    }
}