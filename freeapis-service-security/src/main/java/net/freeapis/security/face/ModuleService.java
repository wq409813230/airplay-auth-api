package net.freeapis.security.face;

import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.orm.BaseService;
import net.freeapis.security.face.entity.Module;
import net.freeapis.security.face.model.ModuleModel;
import net.freeapis.security.face.model.ModuleOperationModel;

import java.util.List;

/**
 *
 * <pre>
 *
 *  freeapis
 *  File: LoginService.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2015
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: LoginService.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016/10/26		freeapis		Initial.
 *
 * </pre>
 */
public interface ModuleService extends BaseService<ModuleModel, Module> {

    /**
     * 获取模块树
     * @param agencyCode
     * @return
     * @throws Exception
     */
    ModuleModel buildModuleTree(String agencyCode)throws Exception;

    /**
     * 获取商家模板树
     * @return
     */
    ModuleModel buildAgencyTemplateModuleTree() throws Exception;

    /**
     * 根据父模块编码获取子模块列表
     * @param agencyCode
     * @param parentCode
     * @return
     * @throws Exception
     */
    List<ModuleModel> getModulesByParentCode(String agencyCode,String parentCode)throws  Exception;

    /**
     * 创建模块资源信息
     * @param moduleOperation
     */
    ModuleOperationModel createModuleOperation(ModuleOperationModel moduleOperation) throws Exception;

    /**
     * 修改模块资源信息
     * @param moduleOperation
     * @throws Exception
     * @return
     */
    ModuleOperationModel updateModuleOperation(ModuleOperationModel moduleOperation) throws Exception;

    /**
     * 分页获取模块操作
     * @param agencyCode
     * @param moduleCode
     * @param buttonName
     * @param page
     * @param orderBy
     * @param order
     * @return
     */
    Page getModuleOperationsByPage(String agencyCode, String moduleCode, String buttonName, Page page, String orderBy, String order) throws Exception;

    /**
     * 删除模块资源信息
     * @param id
     */
    void deleteModuleOperation(Long id) throws Exception;

    /**
     * 创建模块
     * @param moduleModel
     * @return
     * @throws Exception
     */
    ModuleModel createModule(ModuleModel moduleModel)throws Exception;

    /**
     * 删除模块
     * @param agencyCode
     * @param moduleCode
     * @throws Exception
     */
    void deleteModules(String agencyCode,String... moduleCode)throws Exception;

    /**
     * 更新模块
     * @param agencyCode
     * @param moduleModel
     * @return
     * @throws Exception
     */
    ModuleModel updateModule(String agencyCode,ModuleModel moduleModel)throws Exception;

    /**
     * 检查模块编码是否可用
     * @param agencyCode
     * @param moduleCode
     * @param id
     * @return
     * @throws Exception
     */
    boolean isModuleCodeAvailable(String agencyCode,String moduleCode,Long id)throws Exception;

    /**
     * 创建商家模块以及模块操作
     * @param moduleModel
     */
    void createAgencyModuleAndOperation(ModuleModel moduleModel) throws Exception;


    /**
     * 根据模块Code获取模块信息
     * @param agencyCode
     * @param moduleCode
     * @return
     */
    ModuleModel getByModuleCode(String agencyCode,String moduleCode) throws Exception;


    /**
     * 判断模块关联的按钮编码是否唯一
     * @param agencyCode
     * @param moduleCode
     * @param buttonCode
     * @param id
     * @return
     */
    boolean isOperationButtonCodeAvailable(String agencyCode, String moduleCode, String buttonCode, Long id) throws Exception;

}
