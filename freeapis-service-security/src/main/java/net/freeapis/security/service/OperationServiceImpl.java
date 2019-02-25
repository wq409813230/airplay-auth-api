package net.freeapis.security.service;

import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.exceptions.BadRequestException;
import net.freeapis.core.foundation.exceptions.DataNotFoundException;
import net.freeapis.core.foundation.exceptions.DataValidateException;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.BaseServiceImpl;
import net.freeapis.core.mysql.ReferenceModel;
import net.freeapis.security.dao.OperationDAO;
import net.freeapis.security.face.OperationService;
import net.freeapis.security.face.constants.SecurityConstants;
import net.freeapis.security.face.entity.ModuleOperation;
import net.freeapis.security.face.entity.Operation;
import net.freeapis.security.face.model.OperationModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * <pre>
 *
 *  freeapis
 *  File: SecurityResourceServiceImpl.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: SecurityResourceServiceImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年6月16日		wuqiang		Initial.
 *
 * </pre>
 */
@Service(value = "operationService")
public class OperationServiceImpl extends BaseServiceImpl<OperationModel, Operation> implements OperationService {

    @Autowired
    OperationDAO operationDAO;

    @Override
    public OperationModel createOperation(OperationModel operationModel) throws Exception {
        operationModel.setLockStatus(ValidationUtil.isEmpty(operationModel.getLockStatus())
                ? CoreConstants.COMMON_N : operationModel.getLockStatus());
        Operation operation = this.prepareEntity(operationModel);
        operationDAO.insert(operation);
        return Bean.toModel(operation, operationModel);
    }

    @Override
    public void syncOperations(List<OperationModel> operations) throws Exception {
        Operation currentOperation = null;
        for (OperationModel operationModel : operations) {
            currentOperation = operationDAO.findByFid(operationModel.getFuncId());
            if(ValidationUtil.isEmpty(currentOperation)){
                currentOperation = this.prepareEntity(operationModel);
                currentOperation.setRecDate(new Date());
                currentOperation.setRecStatus(CoreConstants.COMMON_ACTIVE);
                currentOperation.setRecUserId(CoreConstants.SYSTEM.toString());
                currentOperation.setLockStatus(CoreConstants.COMMON_N);
                operationDAO.insert(currentOperation);
            } else {
                Bean.copyExistPropertis(operationModel, currentOperation);
                currentOperation.setRecDate(new Date());
                operationDAO.update(currentOperation);
            }
        }
        Redis.removeByPrefix(SecurityConstants.CACHE_KEY_PREFIX_PERMISSION);
    }

    @Override
    public List<Object> getAllOperations() throws Exception {
        List<Object> returnList = Redis.get(SecurityConstants.CACHE_KEY_ALL_OPERATIONS);
        if (ValidationUtil.isEmpty(returnList)) {
            List<Operation> operations = operationDAO.findAllOperations();
            Map<String, Object> operationMap = new HashMap<String, Object>();
            Map<String, String> nameMap = new HashMap<String, String>();
            for (Operation operation : operations) {
                nameMap.put(operation.getResourceCode(), operation.getResourceName());
                List<Operation> operationList = (List<Operation>) operationMap.get(operation.getResourceCode());
                if (ValidationUtil.isEmpty(operationList)) {
                    operationList = new ArrayList<Operation>();
                }
                operationList.add(operation);
                operationMap.put(operation.getResourceCode(), operationList);
            }
            returnList = new ArrayList<Object>();
            for (String resourceCode : operationMap.keySet()) {
                Object[] objects = new Object[3];
                objects[0] = resourceCode;
                objects[1] = nameMap.get(resourceCode);
                objects[2] = operationMap.get(resourceCode);
                returnList.add(objects);
            }
            Redis.set(returnList, SecurityConstants.CACHE_KEY_ALL_OPERATIONS);
        }
        return returnList;
    }

    @Override
    public void deleteOperations(Long[] ids) throws Exception {
        for (Long id : ids) {
            Operation operation = operationDAO.findById(id);
            if (!ValidationUtil.isEmpty(operation)) {
                if (SecurityConstants.RES_TYPE_API.equals(operation.getResType())) {
                    throw new BadRequestException("不能删除系统资源");
                }
                //检查删除（资源不能关联模块）
                String checkResult = operationDAO.deleteCheck(new ReferenceModel(
                        this.getTableName(ModuleOperation.class),
                        new String[]{"FUNC_ID"},
                        new String[]{operation.getFuncId()},
                        "模块资源表中"
                ));
                if (!ValidationUtil.isEmpty(checkResult)) {
                    throw new DataValidateException(checkResult);
                }
                operationDAO.delete(id);
            }
        }
        Redis.remove(SecurityConstants.CACHE_KEY_ALL_OPERATIONS);
    }

    @Override
    public Boolean isFuncIdAvailable(String funcId, Long id) throws Exception {
        return operationDAO.isFuncIdAvailable(funcId, id);
    }

    @Override
    public Page getForPage(String resourceName, Page page, String orderBy, String order) throws Exception {
        page.setList(operationDAO.findForPage(resourceName,page,orderBy,order));
        return page;
    }

    @Override
    public OperationModel updateOperation(OperationModel operationModel) throws Exception {
        Operation operation = operationDAO.findById(operationModel.getSequenceNBR());
        if(ValidationUtil.isEmpty(operation)){
            throw new DataNotFoundException(MessageConstants.DATA_NOT_FOUND);
        }
        //目前只允许修改描述和名称信息
        operation.setOprateDescription(operationModel.getOprateDescription());
        operation.setResourceName(operationModel.getResourceName());
        operationModel.setRecDate(new Date());
        operationModel.setRecUserId(RequestContext.getExeUserId());
        operationDAO.update(operation);
        return Bean.toModel(operation,operationModel);
    }

    @Override
    public OperationModel getByFuncId(String funcId) throws Exception {
        return Bean.toModel(operationDAO.findByFid(funcId),new OperationModel());
    }
}
