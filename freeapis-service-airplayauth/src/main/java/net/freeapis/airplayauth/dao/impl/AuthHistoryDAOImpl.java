package net.freeapis.airplayauth.dao.impl;

import com.google.common.collect.Maps;
import net.freeapis.airplayauth.dao.AuthHistoryDAO;
import net.freeapis.airplayauth.face.entity.AuthHistory;
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
 *  File: AuthHistoryDAOImpl.java
 * 
 *  Freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: AuthHistoryDAOImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2019-02-26 11:49:38		freeapis		Initial.
 *
 * </pre>
 */
@Repository(value="authHistoryDAO")
public class AuthHistoryDAOImpl extends GenericDAOImpl<AuthHistory> implements AuthHistoryDAO
{
    private static final String findSql = "SELECT " +
            " a.SEQUENCE_NBR as sequenceNBR, " +
            " a.MACHINE_MODEL AS machineModel , " +
            " a.COMPANY_NAME AS companyName , " +
            " a.COMPANY_CODE AS companyCode , " +
            " a.DEVICE_MAC AS deviceMac , " +
            " count(1) AS authedTimes , " +
            " count(case when AUTH_SUCCESS = 'Y' then AUTH_SUCCESS end) as successCount, " +
            " a.AUTH_SUCCESS AS lastAuthStatus , " +
            " a.AUTH_TIME AS lastAuthTime, " +
            " a.FAILED_MESSAGE AS failedMessage " +
            "FROM " +
            " (SELECT * FROM AIRPLAYAUTH_AUTH_HISTORY ORDER BY SEQUENCE_NBR DESC) a " +
            "GROUP BY " +
            " a.DEVICE_MAC " +
            "HAVING " +
            " 1 = 1 ";


    @Override
    public List<Map<String,Object>> findByPage(String machineModel, String companyName, Page page) throws Exception{
        StringBuilder sql = new StringBuilder(findSql);
        Map<String,Object> params = Maps.newHashMap();
        if(!ValidationUtil.isEmpty(companyName)){
            sql.append(" AND (")
                    .append(like("a.COMPANY_NAME",":COMPANY"))
                    .append(" OR ")
                    .append(like("a.COMPANY_CODE",":COMPANY"))
                    .append(")");
            params.put("COMPANY",companyName);
        }
        if(!ValidationUtil.isEmpty(machineModel)){
            sql.append(" AND ").append(like("a.MACHINE_MODEL",":MACHINE_MODEL"));
            params.put("MACHINE_MODEL",machineModel);
        }
        sql.append(" ORDER BY a.AUTH_TIME DESC");
        return this.findMapsByPage(sql.toString(),params,page);
    }

    @Override
    public Integer findAuthSuccessCount(String company, String machineModel, String deviceMac) throws Exception {
        String sql = " AND COMPANY_CODE =:COMPANY_CODE AND MACHINE_MODEL = :MACHINE_MODEL AND DEVICE_MAC = :DEVICE_MAC AND AUTH_SUCCESS = 'Y'";
        Map<String,Object> params = Maps.newHashMap();
        params.put("COMPANY_CODE",company);
        params.put("MACHINE_MODEL",machineModel);
        params.put("DEVICE_MAC",deviceMac);
        return this.findCount(sql,params).intValue();
    }

    @Override
    public void deleteByDeviceMac(String deviceMac) throws Exception {
        Map<String,Object> params = Maps.newHashMap();
        params.put("deviceMac",deviceMac);
        this.update("delete from " + this.tableName() + " where device_mac = :deviceMac",params);
    }
}
