package net.freeapis.asi.face;

import net.freeapis.asi.face.entity.ASIBiz;
import net.freeapis.asi.face.enums.ASIType;
import net.freeapis.asi.face.model.ASIBizModel;
import net.freeapis.asi.face.model.ASIModel;
import net.freeapis.asi.face.model.GroupModel;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.orm.BaseService;

import java.util.List;
import java.util.Map;

/**
 * <pre>
 *
 *  freeapis
 *  File: BizService.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: BizService.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
public interface ASIService extends BaseService<ASIBizModel, ASIBiz> {
    /**
     * TODO.获取分组的元数据
     *
     * @param agencyCode
     * @param groupCode
     * @return
     * @throws Exception
     */
    GroupModel getASIMeta(String agencyCode, String groupCode, String entityType) throws Exception;

    /**
     * TODO.根据分组和业务ID获取动态表单数据
     *
     * @param agencyCode
     * @param groupCode
     * @param entityType
     * @param entityId
     * @return
     * @throws Exception
     */
    GroupModel getASIData(String agencyCode, String groupCode, String entityType, String entityId) throws Exception;

    /**
     * TODO.更新动态表单数据
     *
     * @param agencyCode
     * @param entityType
     * @param entityId
     * @param tableValues
     * @param formValues
     * @throws Exception
     */
    Map updateASIData(String agencyCode, String entityType, String entityId,
                      Map<String, List<Map<String, String>>> tableValues, Map<String, Map<String, String>> formValues, ASIType asiType) throws Exception;

    /**
     * TODO.将动态表单组和具体的业务类型关联
     *
     * @param asiBizModel
     * @return
     * @throws Exception
     */
    ASIBizModel upsertASIBiz(ASIBizModel asiBizModel) throws Exception;

    /**
     * TODO.获取实体关联的动态表单数据
     *
     * @param agencyCode
     * @param groupCode
     * @param entityType
     * @param entityId
     * @return
     * @throws Exception
     */
    GroupModel getValues(String agencyCode, String groupCode, String entityType, String entityId) throws Exception;

    /**
     * 根据数据ID获取一条数据
     *
     * @param agencyCode
     * @param groupCode
     * @param id
     * @return
     * @throws Exception
     */
    GroupModel getOne(String agencyCode, String entityType, String entityId, String groupCode, String id) throws Exception;

    /**
     * 分页获取动态表格数据
     *
     * @param agencyCode
     * @param entityType
     * @param entityId
     * @param groupCode
     * @param page
     * @param orderBy
     * @param order
     * @return
     * @throws Exception
     */
    Page getByPage(String agencyCode, String entityType, String entityId,
                   String groupCode, Page page, String orderBy, String order) throws Exception;


    Page getByPage(String agencyCode, String entityType, String entityId, String groupCode, String[] fieldNames,
                   String[] fieldValues, String[] operators, Page page, String orderBy, String order) throws Exception;

    List<Map> getByList(String agencyCode, String entityType, String entityId, String groupCode, String[] fieldNames,
                        String[] fieldValues, String[] operators, String orderBy, String order) throws Exception;

    Boolean isValueAvailable(String agencyCode, String entityType, String entityId, String groupCode, String id, String[] fieldNames, String[] fieldValues) throws Exception;

    Object getByEntityId(String agencyCode, String entityType, String entityId, String groupCode) throws Exception;

    void deleteByGroupCode(String agencyCode, String groupCode) throws Exception;


    <T extends ASIModel> T createASI(T asiModel) throws Exception;

    <T extends ASIModel> List<String> deleteASI(Class<T> asiModelClass, String... ids) throws Exception;

    <T extends ASIModel> T updateASI(T asiModel) throws Exception;

    <T extends ASIModel> T getASIById(Class<T> asiModelClass, String id) throws Exception;

    <T extends ASIModel> Page getASIByPage(
            Class<T> asiModelClass, String[] fieldNames,
            String[] fieldValues, String[] operators, Page page, String orderBy, String order) throws Exception;

    <T extends ASIModel> boolean isASIValueAvailable(
            Class<T> asiModelClassm,String id, String[] fieldNames, String[] fieldValues) throws Exception;
}