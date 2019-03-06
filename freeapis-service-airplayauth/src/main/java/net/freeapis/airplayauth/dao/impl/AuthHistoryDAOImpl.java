package net.freeapis.airplayauth.dao.impl;

import com.google.common.collect.Maps;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.ValidationUtil;
import org.springframework.stereotype.Repository;
import net.freeapis.core.mysql.GenericDAOImpl;
import net.freeapis.airplayauth.dao.AuthHistoryDAO;
import net.freeapis.airplayauth.face.entity.AuthHistory;

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

    @Override
    public List<AuthHistory> findByPage(String machineModel, String companyName, Page page) throws Exception{
        StringBuilder sql = new StringBuilder();
        Map<String,Object> params = Maps.newHashMap();
        if(!ValidationUtil.isEmpty(companyName)){
            sql.append(" AND (")
                    .append(like("COMPANY_NAME",":COMPANY"))
                    .append(" OR ")
                    .append(like("COMPANY_CODE",":COMPANY"))
                    .append(")");
            params.put("COMPANY",companyName);
        }
        if(!ValidationUtil.isEmpty(machineModel)){
            sql.append(" AND ").append(like("MACHINE_MODEL",":MACHINE_MODEL"));
            params.put("MACHINE_MODEL",machineModel);
        }
        return this.paginate(sql.toString(),params,page,"authTime","desc");
    }
}
