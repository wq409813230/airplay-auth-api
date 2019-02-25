package net.freeapis.security.face.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import net.freeapis.core.foundation.orm.BaseEntity;
import org.hibernate.annotations.DynamicUpdate;

/**
 * <pre>
 *
 *  freeapis
 *  File: Employee.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: Employee.java 31101200-9 2014-10-14 16:43:51Z freeapis $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016-09-09 15:33:42		freeapis		Initial.
 *
 * </pre>
 */
@Entity
@Table(name = "agency_employee")
@DynamicUpdate
public class Employee extends BaseEntity {
    private static final long serialVersionUID = 1L;
    private String agencyCode;
    private String departmentCode;
    private Long userId;
    private String needChangePass;
    private String employeeCode;


    @Column(name = "EMPLOYEE_CODE", nullable = false)
    public String getEmployeeCode() {
        return employeeCode;
    }

    public void setEmployeeCode(String employeeCode) {
        this.employeeCode = employeeCode;
    }

    @Column(name = "DEPARTMENT_CODE", nullable = false)
    public String getDepartmentCode() {
        return this.departmentCode;
    }

    public void setDepartmentCode(String departmentCode) {
        this.departmentCode = departmentCode;
    }

    @Column(name = "USER_ID", unique = true, nullable = false, updatable = false)
    public Long getUserId() {
        return this.userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    @Column(name = "NEED_CHANGE_PASS")
    public String getNeedChangePass() {
        return this.needChangePass;
    }

    public void setNeedChangePass(String needChangePass) {
        this.needChangePass = needChangePass;
    }

    public String getAgencyCode() {
        return agencyCode;
    }

    public void setAgencyCode(String agencyCode) {
        this.agencyCode = agencyCode;
    }
}