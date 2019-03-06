package net.freeapis.airplayauth.dao.impl;

import com.google.common.collect.Maps;
import net.freeapis.airplayauth.dao.AuthConfigDAO;
import net.freeapis.airplayauth.face.entity.AuthConfig;
import net.freeapis.core.cache.Redis;
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
 *  File: AuthConfigDAOImpl.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthConfigDAOImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:37		freeapis		Initial.
 *
 * </pre>
 */
@Repository(value="authConfigDAO")
public class AuthConfigDAOImpl extends GenericDAOImpl<AuthConfig> implements AuthConfigDAO
{

    private static final String findSql = "SELECT " +
            " A.SEQUENCE_NBR as sequenceNBR, " +
            " A.MACHINE_MODEL AS machineModel , " +
            " A.COMPANY_NAME AS companyName , " +
            " A.PRIVATE_KEY AS privateKey , " +
            " A.MAX_AUTH_COUNT AS maxAuthCount , " +
            " A.CREATE_TIME AS createTime , " +
            " ( " +
            "  SELECT " +
            "   COUNT(1) " +
            "  FROM " +
            "   AIRPLAYAUTH_AUTH_INFO B " +
            "  WHERE " +
            "   B.MACHINE_MODEL = A.MACHINE_MODEL " +
            "  AND B.COMPANY_CODE = A.COMPANY_CODE " +
            " ) AS authedCount " +
            "FROM " +
            " AIRPLAYAUTH_AUTH_CONFIG A WHERE 1=1 ";

    @Override
    public AuthConfig findAuthConfig(String companyCode, String machineModel) throws Exception {
        AuthConfig authConfig = Redis.getSingle(this.getEntityClass(),companyCode, machineModel);
        if(ValidationUtil.isEmpty(authConfig)){
            String sql = "AND COMPANY_CODE = :COMPANY_CODE AND MACHINE_MODEL = :MACHINE_MODEL";
            Map<String,Object> params = Maps.newHashMap();
            params.put("COMPANY_CODE",companyCode);
            params.put("MACHINE_MODEL",machineModel);
            authConfig = this.findFirst(sql,params);
            if(!ValidationUtil.isEmpty(authConfig)){
                Redis.setSingle(authConfig,companyCode,machineModel);
            }
        }
        return authConfig;
    }

    @Override
    public List<Map<String,Object>> findByPage(String company, String machineModel, Page page) throws Exception{
        StringBuilder sql = new StringBuilder(findSql);
        Map<String,Object> params = Maps.newHashMap();
        if(!ValidationUtil.isEmpty(company)){
            sql.append(" AND (")
                    .append(like("A.COMPANY_NAME",":COMPANY"))
                    .append(" OR ")
                    .append(like("A.COMPANY_CODE",":COMPANY"))
                    .append(")");
            params.put("COMPANY",company);
        }
        if(!ValidationUtil.isEmpty(machineModel)){
            sql.append(" AND ").append(like("A.MACHINE_MODEL",":MACHINE_MODEL"));
            params.put("MACHINE_MODEL",machineModel);
        }
        sql.append(" ORDER BY A.CREATE_TIME DESC");
        return this.findMapsByPage(sql.toString(),params,page);
    }

    @Override
    public void delete(Long id) throws Exception {
        AuthConfig authConfig = this.findById(id);
        if (!ValidationUtil.isEmpty(authConfig)) {
            super.delete(id);
            Redis.removeSingle(this.getEntityClass(),authConfig.getCompanyCode(), authConfig.getMachineModel());
        }
    }

    @Override
    public void update(AuthConfig authConfig) throws Exception {
        super.update(authConfig);
        Redis.removeSingle(AuthConfig.class,authConfig.getCompanyCode(), authConfig.getMachineModel());
    }
}
