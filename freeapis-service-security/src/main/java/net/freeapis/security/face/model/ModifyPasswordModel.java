package net.freeapis.security.face.model;

import java.io.Serializable;

/**
 * freeapis, Inc.
 * Copyright (C): 2016
 * <p>
 * Description:
 * TODO
 * <p>
 * Author:Administrator
 * Date:2017年03月03日 10:35
 */
public class ModifyPasswordModel implements Serializable {

    private String loginId;
    private String mobile;
    private String identifyingCode;
    private String newPassword;
    private String oldPassword;

    public String getLoginId() {
        return loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getIdentifyingCode() {
        return identifyingCode;
    }

    public void setIdentifyingCode(String identifyingCode) {
        this.identifyingCode = identifyingCode;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getOldPassword() {
        return oldPassword;
    }

    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }
}
