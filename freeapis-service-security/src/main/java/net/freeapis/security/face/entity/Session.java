package net.freeapis.security.face.entity;

import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * <pre>
 *
 *  freeapis
 *  File: UserSession.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: UserSession.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月7日		freeapis		Initial.
 *
 * </pre>
 */
@Entity
@Table(name = "security_session")
@DynamicUpdate
public class Session implements java.io.Serializable {
    private static final long serialVersionUID = 1701924515983788810L;

    @Id
    @Column(name = "SEQUENCE_NBR")
    private Long sequenceNBR;//物理主键
    private String sessionId;//会话Id
    private String agencyCode;//商家编码
    private Long userId;//用户ID
    private String userName;//用户名
    private String loginId;//登录账号
    private Integer userType;//用户类型
    private String product;//登录产品/设备
    private String remoteIp;//远端IP
    private String expiration;//session过期时间
    private String status;//session状态
    private Date createTime;//创建时间
    private String userAgent;//客户端agent

    public Long getSequenceNBR() {
        return sequenceNBR;
    }

    public void setSequenceNBR(Long sequenceNBR) {
        this.sequenceNBR = sequenceNBR;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public String getAgencyCode() {
        return agencyCode;
    }

    public void setAgencyCode(String agencyCode) {
        this.agencyCode = agencyCode;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getLoginId() {
        return loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public String getRemoteIp() {
        return remoteIp;
    }

    public void setRemoteIp(String remoteIp) {
        this.remoteIp = remoteIp;
    }

    public String getExpiration() {
        return expiration;
    }

    public void setExpiration(String expiration) {
        this.expiration = expiration;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }
}