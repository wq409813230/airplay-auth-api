package net.freeapis.security.face.model;

import lombok.Data;
import net.freeapis.core.foundation.orm.BaseModel;

import java.util.Date;

/**
 * <pre>
 *
 *  freeapis
 *  File: EmployeeModel.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: EmployeeModel.java 31101200-9 2014-10-14 16:43:51Z freeapis $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016-09-09 15:33:42		freeapis		Initial.
 *
 * </pre>
 */
@Data
public class EmployeeModel extends BaseModel {
    private String departmentCode;
    private Long userId;
    private String needChangePass;
    private String employeeCode;
    //新加属性
    private String agencyCode;
    private Integer userType;
    private String userName;
    private String nickName;
    private String realName;
    private String gender;
    private Date birthDate;
    private String avatar;
    private Date registerDate;
    private String mobile;
    private String lockStatus;
    private Date lockDate;
    private String lockUserId;
    private String roleCodes;
    private String roleNames;
    private String password;    //修改密码时的新密码
    private String oldPassword ; //员工修改密码时的旧密码

    private String departmentName;

    private String isBind;//是否绑定 Y 已绑定  N  未绑定
}
