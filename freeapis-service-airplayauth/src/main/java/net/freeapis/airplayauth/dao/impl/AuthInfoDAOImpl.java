package net.freeapis.airplayauth.dao.impl;

import com.google.common.collect.Maps;
import net.freeapis.airplayauth.dao.AuthInfoDAO;
import net.freeapis.airplayauth.face.entity.AuthInfo;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.exceptions.DataNotFoundException;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.GenericDAOImpl;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: AuthInfoDAOImpl.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthInfoDAOImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
@Repository(value="authInfoDAO")
public class AuthInfoDAOImpl extends GenericDAOImpl<AuthInfo> implements AuthInfoDAO
{

    @Override
    public AuthInfo deleteAuthInfo(Long id) throws Exception {
        AuthInfo authInfo = this.findById(id);
        if(ValidationUtil.isEmpty(authInfo)){
            throw new DataNotFoundException(MessageConstants.DATA_NOT_FOUND);
        }
        this.delete(id);
        Redis.remove(authInfo.getCompanyCode(),authInfo.getMachineModel(),authInfo.getDeviceMac());
        return authInfo;
    }

    @Override
    public Integer findAuthedCount(String companyCode, String machineModel) throws Exception {
        Map<String,Object> params = Maps.newHashMap();
        params.put("COMPANY_CODE",companyCode);
        params.put("MACHINE_MODEL",machineModel);
        return this.findCount("AND COMPANY_CODE = :COMPANY_CODE AND MACHINE_MODEL = :MACHINE_MODEL",params).intValue();
    }

    @Override
    public AuthInfo findAuthInfo(String companyCode, String machineModel, String deviceMac) throws Exception {
        AuthInfo authInfo = Redis.getSingle(AuthInfo.class,companyCode,machineModel,deviceMac);
        if(ValidationUtil.isEmpty(authInfo)){
            Map<String,Object> params = Maps.newHashMap();
            params.put("COMPANY_CODE",companyCode);
            params.put("MACHINE_MODEL",machineModel);
            params.put("DEVICE_MAC",deviceMac);
            authInfo = this.findFirst(
                    "AND COMPANY_CODE = :COMPANY_CODE AND MACHINE_MODEL = :MACHINE_MODEL AND DEVICE_MAC = :DEVICE_MAC",params);
            if(!ValidationUtil.isEmpty(authInfo)){
                Redis.setSingle(authInfo,companyCode,machineModel,deviceMac);
            }
        }
        return authInfo;
    }

    @Override
    public List<AuthInfo> findAuthInfosByConfigId(Long authConfigId,String deviceMac, Page page) throws Exception {
        StringBuilder sql = new StringBuilder();
        Map<String,Object> params = Maps.newHashMap();

        sql.append(" AND AUTH_CONFIG_ID = :AUTH_CONFIG_ID ");
        params.put("AUTH_CONFIG_ID",authConfigId);

        if(!ValidationUtil.isEmpty(deviceMac)){
            sql.append(" AND DEVICE_MAC = :DEVICE_MAC ");
            params.put("DEVICE_MAC",deviceMac);
        }
        return this.paginate(sql.toString(),params,page,null,null);
    }
}
