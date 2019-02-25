package net.freeapis.security.service;

import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.exceptions.DataNotFoundException;
import net.freeapis.core.foundation.exceptions.DataValidateException;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mysql.BaseServiceImpl;
import net.freeapis.core.mysql.ReferenceModel;
import net.freeapis.security.dao.LoginInfoDAO;
import net.freeapis.security.dao.ModuleDAO;
import net.freeapis.security.dao.ModuleOperationDAO;
import net.freeapis.security.dao.OperationDAO;
import net.freeapis.security.face.ModuleService;
import net.freeapis.security.face.PermissionService;
import net.freeapis.security.face.constants.SecurityConstants;
import net.freeapis.security.face.entity.*;
import net.freeapis.security.face.model.ModuleModel;
import net.freeapis.security.face.model.ModuleOperationModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by Administrator on 2016/10/26.
 */

@Service(value="moduleService")
public class ModuleServiceImpl extends BaseServiceImpl<ModuleModel, Module> implements ModuleService{

    @Autowired
    ModuleDAO moduleDAO;

    @Autowired
    ModuleOperationDAO moduleOperationDAO;

    @Autowired
    OperationDAO operationDAO;

    @Autowired
    LoginInfoDAO loginInfoDAO;

    @Autowired
    PermissionService permissionService;

    @Override
    public ModuleModel buildModuleTree(String agencyCode)throws Exception{
        ModuleModel moduleModel = Redis.get(SecurityConstants.CACHE_KEY_MODULE_TREE,agencyCode);
        if(ValidationUtil.isEmpty(moduleModel)){
            moduleModel = new ModuleModel();
            moduleModel.setAgencyCode(agencyCode);
            moduleModel.setModuleCode(SecurityConstants.MODULE_ROOT_CODE);
            moduleModel.setParentCode(SecurityConstants.MODULE_ROOT_PCODE);
            moduleModel.setModuleName("全部模块");
            buildTree(moduleModel,false);
            Redis.set(moduleModel,SecurityConstants.CACHE_KEY_MODULE_TREE,agencyCode);
        }
        return moduleModel;
    }

    @Override
    public ModuleModel buildAgencyTemplateModuleTree() throws Exception {
        ModuleModel moduleModel = Redis.get(SecurityConstants.CACHE_KEY_AGENCY_TEMPLATE_TREE);
        if(ValidationUtil.isEmpty(moduleModel)){
            moduleModel = new ModuleModel();
            moduleModel.setAgencyCode(CoreConstants.CODE_SUPER_ADMIN);
            moduleModel.setModuleCode(SecurityConstants.MODULE_ROOT_CODE);
            moduleModel.setParentCode(SecurityConstants.MODULE_ROOT_PCODE);
            moduleModel.setModuleName("商家模板模块");
            buildTree(moduleModel,true);
            Redis.set(moduleModel,SecurityConstants.CACHE_KEY_AGENCY_TEMPLATE_TREE);
        }
        return moduleModel;
    }

    private void buildTree(ModuleModel parentModule,boolean isOnlyTemplateModule)throws Exception{
        List<Module> modules= null;
        modules = moduleDAO.findByParentCode(parentModule.getAgencyCode(),parentModule.getModuleCode(),isOnlyTemplateModule);
        if(ValidationUtil.isEmpty(modules)){
            parentModule.setHasChildren(false);
        }else{
            parentModule.setHasChildren(true);
            parentModule.setChildren(Bean.toModels(modules, ModuleModel.class));
            for(ModuleModel module:parentModule.getChildren()){
                buildTree(module,isOnlyTemplateModule);
            }
        }
    }

    @Override
    public List<ModuleModel> getModulesByParentCode(String agencyCode,String parentCode) throws Exception {
        List<Module> modules = moduleDAO.findByParentCode(agencyCode,parentCode,false);
        return Bean.toModels(modules, ModuleModel.class);
    }

    @Override
    public ModuleOperationModel createModuleOperation(ModuleOperationModel moduleOperation) throws Exception {
        //如果按钮类型是api那么必须关联funcId
        if(SecurityConstants.MODULE_BUTTON_TYPE_API.equalsIgnoreCase(moduleOperation.getButtonType())
                && ValidationUtil.isEmpty(moduleOperation.getFuncId())){
            throw new DataValidateException(SecurityConstants.MODULE_BUTTON_FUNC_ID_NOT_NULL);
        }
        Module module = moduleDAO.findByModuleCode(moduleOperation.getAgencyCode(),moduleOperation.getModuleCode());
        if(!SecurityConstants.MODULE_CONTENT_TYPE_BUTTON.equals(module.getChildContentType())){
            throw new DataValidateException("【"+module.getModuleName()+"】该模块内容类型不是按钮！");
        }
        moduleOperation.setSequenceNBR(sequenceGenerator.getNextValue());
        moduleOperation.setRecDate(new Date());
        moduleOperation.setRecUserId(RequestContext.getExeUserId());
        moduleOperation.setRecStatus(CoreConstants.COMMON_ACTIVE);
        moduleOperationDAO.insert(Bean.toPo(moduleOperation,new ModuleOperation()));
        //清除全部权限缓存
        Redis.removeByPrefix(SecurityConstants.CACHE_KEY_PREFIX_PERMISSION);
        return moduleOperation;
    }

    @Override
    public ModuleOperationModel updateModuleOperation(ModuleOperationModel moduleOperationModel) throws Exception {
        //如果按钮类型是api那么必须关联funcId
        if(SecurityConstants.MODULE_BUTTON_TYPE_API.equalsIgnoreCase(moduleOperationModel.getButtonType())
                && ValidationUtil.isEmpty(moduleOperationModel.getFuncId())){
            throw new DataValidateException(SecurityConstants.MODULE_BUTTON_FUNC_ID_NOT_NULL);
        }
        ModuleOperation moduleOperation = moduleOperationDAO.findById(moduleOperationModel.getSequenceNBR());
        if(ValidationUtil.isEmpty(moduleOperation)){
            throw new DataNotFoundException(MessageConstants.DATA_NOT_FOUND);
        }
        moduleOperationModel.setSequenceNBR(moduleOperation.getSequenceNBR());
        moduleOperationModel.setAgencyCode(moduleOperation.getAgencyCode());
        moduleOperationModel.setModuleCode(moduleOperation.getModuleCode());
        moduleOperationModel.setButtonCode(moduleOperation.getButtonCode());//不可修改按钮编码，因为主体权限有可能会引用
        moduleOperationModel.setRecDate(new Date());
        moduleOperationModel.setRecUserId(RequestContext.getExeUserId());
        Bean.copyExistPropertis(moduleOperationModel,moduleOperation);
        moduleOperationDAO.update(moduleOperation);
        //清除全部权限缓存
        Redis.removeByPrefix(SecurityConstants.CACHE_KEY_PREFIX_PERMISSION);
        return moduleOperationModel;
    }

    @Override
    public Page getModuleOperationsByPage(String agencyCode, String moduleCode, String buttonName, Page page, String orderBy, String order) throws Exception {
        List<ModuleOperation> operations = moduleOperationDAO.findByPage(agencyCode,moduleCode,buttonName,page,order,orderBy);
        page.setList(Bean.toModels(operations,ModuleOperationModel.class));
        return page;
    }

    @Override
    public void deleteModuleOperation(Long id) throws Exception {
        ModuleOperation moduleOperation = moduleOperationDAO.findById(id);
        if(ValidationUtil.isEmpty(moduleOperation)){
            throw new DataNotFoundException(MessageConstants.DATA_NOT_FOUND);
        }
        //如果该按钮信息已经被主体权限所引用则不能删除
        deleteModuleOperationCheck(moduleOperation.getAgencyCode(),moduleOperation.getModuleCode(),moduleOperation.getButtonCode());
        moduleOperationDAO.delete(id);
        //清除全部权限缓存
        Redis.removeByPrefix(SecurityConstants.CACHE_KEY_PREFIX_PERMISSION);
    }

    @Override
    public ModuleModel createModule(ModuleModel newModule)throws Exception{
        validateParentModule(newModule);
        Module module = this.prepareEntity(newModule);
        module.setLockStatus(ValidationUtil.isEmpty(newModule.getLockStatus())?CoreConstants.COMMON_N:newModule.getLockStatus());
        module.setParentCode(ValidationUtil.isEmpty(newModule.getParentCode())?SecurityConstants.MODULE_ROOT_CODE:newModule.getParentCode());
        module.setLockDate(new Date());
        module.setLockUserId(RequestContext.getExeUserId());
        moduleDAO.insert(module);
        //清除全部权限缓存
        Redis.removeByPrefix(SecurityConstants.CACHE_KEY_PREFIX_PERMISSION);
        return Bean.toModel(module, newModule);
    }

    @Override
    public void deleteModules(String agencyCode,String... moduleCodes)throws Exception{
        for(String moduleCode:moduleCodes){
            String checkResult=moduleDAO.deleteCheck(new ReferenceModel(getTableName(),
                            new String[]{"AGENCY_CODE","PARENT_CODE"},
                            new String[]{agencyCode,moduleCode},
                            "在子模块中"),
                    new ReferenceModel(getTableName(ModuleOperation.class),
                            new String[]{"AGENCY_CODE","MODULE_CODE"},
                            new String[]{agencyCode,moduleCode},
                            "在模块资源信息表中"),
                    new ReferenceModel(getTableName(ModulePrimary.class),
                            new String[]{"AGENCY_CODE","MODULE_CODE"},
                            new String[]{agencyCode,moduleCode},
                            "在模块主体关系表中"));
            if(!ValidationUtil.isEmpty(checkResult)) {
                throw new DataValidateException(checkResult);
            }
            moduleDAO.deleteByModuleCode(agencyCode,moduleCode);
            //清除全部权限缓存
            Redis.removeByPrefix(SecurityConstants.CACHE_KEY_PREFIX_PERMISSION);
        }
    }

    @Override
    public ModuleModel updateModule(String agencyCode,ModuleModel currentModule)throws Exception{
        Module module = moduleDAO.findByModuleCode(RequestContext.getAgencyCode(),currentModule.getModuleCode());
        if(ValidationUtil.isEmpty(module)){
            throw new DataNotFoundException(MessageConstants.DATA_NOT_FOUND);
        }
        Bean.copyExistPropertis(currentModule,module);
        validateParentModule(Bean.copyExistPropertis(module,currentModule));
        module.setRecDate(new Date());
        module.setRecUserId(RequestContext.getExeUserId());
        moduleDAO.update(module);
        //清除全部权限缓存
        Redis.removeByPrefix(SecurityConstants.CACHE_KEY_PREFIX_PERMISSION);
        return Bean.toModel(module, currentModule);
    }

    @Override
    public boolean isModuleCodeAvailable(String agencyCode,String moduleCode, Long id) throws Exception {
        return moduleDAO.isModuleCodeAvailable(agencyCode,moduleCode, id);
    }

    @Override
    public void createAgencyModuleAndOperation(ModuleModel moduleModel) throws Exception{
        //数据验证
        if(ValidationUtil.isEmpty(moduleModel.getAgencyCode())
                || ValidationUtil.isEmpty(moduleModel.getModuleCode())){
            throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
        }
        //创建父亲模块
        createModuleAndOperationByRecursive(moduleModel.getAgencyCode(),moduleModel.getModuleCode());
        //清除全部权限缓存
        Redis.removeByPrefix(SecurityConstants.CACHE_KEY_PREFIX_PERMISSION);
    }

    /**
     * 递归创建父亲模块
     * @param agencyCode
     * @param moduleCode
     * @throws Exception
     */
    private void createModuleAndOperationByRecursive(String agencyCode, String moduleCode) throws Exception {
        Module module = moduleDAO.findByModuleCode(agencyCode,moduleCode);
        if(ValidationUtil.isEmpty(module)){
            //创建商家模块
            Module sysModule = moduleDAO.findByModuleCode(CoreConstants.CODE_SUPER_ADMIN,moduleCode);
            if(ValidationUtil.isEmpty(sysModule)){
                throw new DataValidateException("系统模块【"+sysModule.getModuleCode()+"】不存在，无法创建商家模块。");
            }
            ModuleModel agencyModule = Bean.toModel(sysModule,new ModuleModel());
            agencyModule.setAgencyCode(agencyCode);
            agencyModule.setSequenceNBR(sequenceGenerator.getNextValue());
            agencyModule.setRecDate(new Date());
            agencyModule.setRecStatus(CoreConstants.COMMON_ACTIVE);
            agencyModule.setRecUserId(RequestContext.getExeUserId());
            agencyModule.setLockStatus(CoreConstants.COMMON_N);
            agencyModule.setLockDate(new Date());
            agencyModule.setLockUserId(RequestContext.getExeUserId());
            moduleDAO.insert(Bean.toPo(agencyModule,new Module()));
            if(SecurityConstants.MODULE_ROOT_CODE.equals(agencyModule.getParentCode())){
                return;
            }
            //如果模块节点内容类型是button，则创建ModuleOperation
            if(SecurityConstants.MODULE_CONTENT_TYPE_BUTTON.equals(sysModule.getChildContentType())){
                List<ModuleOperation> moduleOperations = moduleOperationDAO.findByModuleCode(sysModule.getAgencyCode(),sysModule.getModuleCode());
                //检查要删除的模块按钮是否已经被主体权限所引用
                deleteCheck4createModuleOperation(agencyCode, moduleCode, moduleOperations);
                //删除以前的模块资源信息
                moduleOperationDAO.deleteByModule(agencyCode,moduleCode);
                //复制系统模块按钮到商家的模块按钮（商家的模块资源权限完全被系统模块资源权限所控制）
                for(ModuleOperation moduleOperation : moduleOperations){
                    ModuleOperation agencyModuleOperation = Bean.copyExistPropertis(moduleOperation,new ModuleOperation());
                    agencyModuleOperation.setSequenceNBR(sequenceGenerator.getNextValue());
                    agencyModuleOperation.setAgencyCode(agencyCode);
                    agencyModuleOperation.setRecDate(new Date());
                    agencyModuleOperation.setRecUserId(RequestContext.getExeUserId());
                    agencyModuleOperation.setRecStatus(CoreConstants.COMMON_ACTIVE);
                    moduleOperationDAO.insert(Bean.toPo(agencyModuleOperation,new ModuleOperation()));
                }
            }
            createModuleAndOperationByRecursive(agencyCode,agencyModule.getParentCode());
        }
    }

    /**
     * 在创建模块时检查删除
     * @param agencyCode
     * @param moduleCode
     * @param newModuleOperations
     * @throws Exception
     */
    private void deleteCheck4createModuleOperation(String agencyCode, String moduleCode,List<ModuleOperation> newModuleOperations) throws Exception {
        List<ModuleOperation> oldModuleOperations = moduleOperationDAO.findByModuleCode(agencyCode,moduleCode);
        //在创建
        if(!ValidationUtil.isEmpty(oldModuleOperations)){
            Set<String> buttonCodes = new HashSet<String>();
            for(ModuleOperation moduleOperation : oldModuleOperations){
                buttonCodes.add(moduleOperation.getButtonCode());
            }
            if(!ValidationUtil.isEmpty(newModuleOperations)){
                for(ModuleOperation moduleOperation:newModuleOperations){
                    buttonCodes.remove(moduleOperation.getButtonCode());
                }
            }
            for(String buttonCode:buttonCodes){
                deleteModuleOperationCheck(agencyCode, moduleCode, buttonCode);
            }
        }
    }

    private void deleteModuleOperationCheck(String agencyCode, String moduleCode, String buttonCode) throws Exception {
        String checkResult = moduleDAO.deleteCheck(new ReferenceModel(ModuleServiceImpl.this.getTableName(Permission.class),
                new String[]{"AGENCY_CODE","MODULE_CODE","BUTTON_CODE"},
                new String[]{agencyCode,moduleCode,buttonCode},
                "在主体权限操作表中"));
        if(!ValidationUtil.isEmpty(checkResult)){
            throw new DataValidateException(checkResult);
        }
    }


    @Override
    public ModuleModel getByModuleCode(String agencyCode,String moduleCode) throws Exception {
        Module module = moduleDAO.findByModuleCode(agencyCode,moduleCode);
        if(!ValidationUtil.isEmpty(module)){
            return Bean.toModel(module,new ModuleModel());
        }
        return null;
    }

    @Override
    public boolean isOperationButtonCodeAvailable(String agencyCode, String moduleCode, String buttonCode, Long id) throws Exception {
        return moduleOperationDAO.isOperationButtonCodeAvailable(agencyCode,moduleCode,buttonCode,id);
    }

    /**
     * 在创建或者修改商品时验证父节点
     * @param newModule
     * @throws Exception
     */
    private void validateParentModule(ModuleModel newModule) throws Exception {
        //获取父节点信息
        if(!SecurityConstants.MODULE_ROOT_CODE.equals(newModule.getParentCode())){
            Module parentModule = moduleDAO.findByModuleCode(newModule.getAgencyCode(), newModule.getParentCode());
            if(ValidationUtil.isEmpty(parentModule)){
                throw new DataNotFoundException(MessageConstants.DATA_NOT_FOUND);
            }
            if(CoreConstants.COMMON_Y.equals(newModule.getIsAgencyTemplate())
                    && !CoreConstants.COMMON_Y.equals(parentModule.getIsAgencyTemplate())){
                throw new DataValidateException("父节点不是商家模板节点，创建失败！");
            }
        }
    }

}
