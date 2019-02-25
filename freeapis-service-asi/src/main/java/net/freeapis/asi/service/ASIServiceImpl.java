package net.freeapis.asi.service;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import net.freeapis.asi.dao.ASIBizDAO;
import net.freeapis.asi.face.ASIService;
import net.freeapis.asi.face.GroupColumnService;
import net.freeapis.asi.face.GroupService;
import net.freeapis.asi.face.constants.ASIConstants;
import net.freeapis.asi.face.entity.ASIBiz;
import net.freeapis.asi.face.enums.ASIType;
import net.freeapis.asi.face.enums.Operator;
import net.freeapis.asi.face.model.ASIBizModel;
import net.freeapis.asi.face.model.ASIModel;
import net.freeapis.asi.face.model.GroupColumnModel;
import net.freeapis.asi.face.model.GroupModel;
import net.freeapis.asi.service.core.processor.TypeProcessor;
import net.freeapis.core.cache.Redis;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.exceptions.BusinessException;
import net.freeapis.core.foundation.exceptions.DataNotFoundException;
import net.freeapis.core.foundation.exceptions.DataValidateException;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.utils.Bean;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mongodb.MongoDAO;
import net.freeapis.core.mysql.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: BizServiceImpl.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: BizServiceImpl.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年08月18日		framework		Initial.
 *
 * </pre>
 */
@Service(value = "asiService")
public class ASIServiceImpl extends BaseServiceImpl<ASIBizModel, ASIBiz> implements ASIService {

	@Autowired
	private GroupColumnService groupColumnService;

	@Autowired
	private GroupService groupService;
	
	@Autowired
	private ASIBizDAO asiBizDAO;

	@Autowired
	private MongoDAO mongoDAO;

	@Override
	public GroupModel getASIMeta(String agencyCode,String groupCode,String entityType) throws Exception {
		ASIBiz currentASIBiz = asiBizDAO.findASIBiz(agencyCode, groupCode, entityType);
		if (ValidationUtil.isEmpty(currentASIBiz)){
			return null;
		}
		GroupModel rootGroup = groupService.getGroup(agencyCode, currentASIBiz.getGroupCode());
		if(!ValidationUtil.isEmpty(rootGroup)){
			List<GroupModel> children = groupService.getGroupsByParentCode(agencyCode, rootGroup.getGroupCode());
			if(!ValidationUtil.isEmpty(children)){
				rootGroup.setChildren(children);
				List<GroupColumnModel> currentGroupColumns = null;
				for(GroupModel child : children){
					currentGroupColumns = groupColumnService.getGroupColumns(agencyCode, child.getGroupCode());
					if (!ValidationUtil.isEmpty(currentGroupColumns)) {
						child.setColumns(currentGroupColumns);
					}
				}
			}
		}
		return rootGroup;
	}

	@Override
	public GroupModel getASIData(String agencyCode, String groupCode, String entityType, String entityId)
			throws Exception {
		GroupModel group = groupService.getGroup(agencyCode, groupCode);
		List<GroupColumnModel> columns = groupColumnService.getGroupColumns(agencyCode, groupCode);
		if (!ValidationUtil.isEmpty(group) && !ValidationUtil.isEmpty(columns)) {
			group.setColumns(columns);
			Object values = TypeProcessor.getProcessor(ASIType.getASIType(group.getGroupType())).getValues(agencyCode,
					groupCode, entityType, entityId,null);
			if (!ValidationUtil.isEmpty(values)) {
				group.setValues(values);
			}
		}
		return group;
	}

	@Override
	public Map updateASIData(String agencyCode, String entityType, String entityId,
			Map<String, List<Map<String, String>>> tableValues, Map<String, Map<String, String>> formValues,ASIType asiType)
					throws Exception {
		return TypeProcessor.getProcessor(asiType).update(agencyCode, entityType, entityId, tableValues, formValues);
	}

	@Override
	public ASIBizModel upsertASIBiz(ASIBizModel asiBizModel) throws Exception {
		
		if(ValidationUtil.isEmpty(asiBizModel)
				|| ValidationUtil.isEmpty(asiBizModel.getAgencyCode())
				|| ValidationUtil.isEmpty(asiBizModel.getEntityType())) {
			throw new DataValidateException(MessageConstants.DATA_VALIDATION_FAILED);
		}
		ASIBiz currentAsiBiz = asiBizDAO.findASIBiz(asiBizModel.getAgencyCode(),asiBizModel.getGroupCode(),asiBizModel.getEntityType());
		if(ValidationUtil.isEmpty(currentAsiBiz)){
			currentAsiBiz = Bean.toPo(asiBizModel, new ASIBiz());
			currentAsiBiz.setRecDate(new Date());
			currentAsiBiz.setRecStatus(CoreConstants.COMMON_ACTIVE);
			currentAsiBiz.setRecUserId(RequestContext.getExeUserId());
			asiBizDAO.insertWithCache(currentAsiBiz);
		}else{
			currentAsiBiz.setRecDate(new Date());
			asiBizDAO.updateWithCache(currentAsiBiz);
		}
		return Bean.toModel(currentAsiBiz, asiBizModel);
	}

	@Override
	public GroupModel getValues(String agencyCode,String groupCode,String entityType, String entityId) throws Exception {
		GroupModel result = Redis.get(ASIConstants.ASIVALUE_CACHEKEY_PREFIX,agencyCode,groupCode,entityType,entityId);
		if(ValidationUtil.isEmpty(result)){
			result = groupService.getGroup(agencyCode, groupCode);
			if(ValidationUtil.isEmpty(result)) {return null;}
			this.setGroupValues(agencyCode,entityType,entityId,result);
			Redis.set(result,ASIConstants.ASIVALUE_CACHEKEY_PREFIX,agencyCode,groupCode,entityType,entityId);
		}
		return result;
	}

	//递归获取分组的所有值
	private void setGroupValues(String agencyCode,String entityType,String entityId,GroupModel currentGroup) throws Exception{
		if(currentGroup.isHasChildren()){
			List<GroupModel> children = groupService.getGroupsByParentCode(agencyCode, currentGroup.getGroupCode());
			if(!ValidationUtil.isEmpty(children)){
				currentGroup.setChildren(children);
				for(GroupModel child : children){
					this.setGroupValues(agencyCode,entityType,entityId,child);
				}
			}
		}else{
			currentGroup.setValues(TypeProcessor.getProcessor(ASIType.getASIType(currentGroup.getGroupType()))
					.getValues(agencyCode,currentGroup.getGroupCode(),entityType, entityId, currentGroup.getDataSort()));
		}
	}

	@Override
	public GroupModel getOne(String agencyCode,String entityType, String entityId, String groupCode, String id) throws Exception {
		//首先根据groupCode获取那组信息
		GroupModel groupModel = groupService.getGroup(agencyCode, groupCode);
		if (ValidationUtil.isEmpty(groupModel)){
			throw new BusinessException(MessageConstants.DATA_NOT_FOUND);
		}
		//根据分组获取列字段
		List<GroupColumnModel> currentGroupColumns = groupColumnService.getGroupColumns(agencyCode, groupCode);
		groupModel.setColumns(currentGroupColumns);
		//根据ID从mongo中获取数据

		Object currentValue = mongoDAO.getMongoOp().findOne(
						new Query(Criteria.where(ASIConstants.AGENCY_CODE).is(agencyCode)
						.and(ASIConstants.GROUP_CODE).is(groupCode)
						.and(ASIConstants.ENTITY_TYPE).is(entityType)
						.and(ASIConstants.ENTITY_ID).is(entityId).and(ASIConstants.ID).is(id)),
				Map.class,this.buildTableName(groupModel.getGroupType(),entityType, groupCode));
		if (!ValidationUtil.isEmpty(currentValue)) {
			groupModel.setValues(currentValue);
		}
		return groupModel;
	}

	@Override
	public Page getByPage(String agencyCode, String entityType,
						  String entityId, String groupCode, Page page, String orderBy, String order) throws Exception {
		Query query = new Query(Criteria.where(ASIConstants.AGENCY_CODE).is(agencyCode)
						.and(ASIConstants.GROUP_CODE).is(groupCode)
						.and(ASIConstants.ENTITY_TYPE).is(entityType)
						.and(ASIConstants.ENTITY_ID).is(entityId));
		page.setTotalRows(Long.valueOf(mongoDAO.getMongoOp().count(query,this.buildTableName(ASIType.TABLE.name(),entityType, groupCode))).intValue());
		page.setList(mongoDAO.getMongoOp().find(query.skip(page.getPageStartRow()).limit(page.getPageRecorders()),
				Map.class,this.buildTableName(ASIType.TABLE.name(),entityType, groupCode)));
		return page;
	}

	@Override
	public Page getByPage(String agencyCode, String entityType, String entityId, String groupCode, String[] fieldNames,
						  String[] fieldValues, String[] operators, Page page, String orderBy, String order) throws Exception{
		Criteria criteria = Criteria.where(ASIConstants.AGENCY_CODE).is(agencyCode)
				.and(ASIConstants.GROUP_CODE).is(groupCode)
				.and(ASIConstants.ENTITY_TYPE).is(entityType)
				.and(ASIConstants.ENTITY_ID).is(entityId);
		Query query = new Query();
		condition(fieldNames,fieldValues,operators,criteria);
		query.addCriteria(criteria);
		if(ValidationUtil.isEmpty(orderBy)){
			orderBy = ASIConstants.CREATE_DATE;
		}
		if(ValidationUtil.isEmpty(order)){
			order = Sort.Direction.DESC.toString();
		}
		page.setTotalRows(Long.valueOf(mongoDAO.getMongoOp().count(query, this.buildTableName(ASIType.TABLE.name(), entityType, groupCode))).intValue());
		page.setList(mongoDAO.getMongoOp().find(query.with(new Sort(Sort.Direction.fromString(order),orderBy)).skip(page.getPageStartRow()).limit(page.getPageRecorders()),
				Map.class, this.buildTableName(ASIType.TABLE.name(), entityType, groupCode)));
		return page;
	}

	@Override
	public List<Map> getByList(String agencyCode, String entityType, String entityId, String groupCode, String[] fieldNames, String[] fieldValues, String[] operators, String orderBy, String order) throws Exception {
		Criteria criteria = Criteria.where(ASIConstants.AGENCY_CODE).is(agencyCode)
				.and(ASIConstants.GROUP_CODE).is(groupCode)
				.and(ASIConstants.ENTITY_TYPE).is(entityType)
				.and(ASIConstants.ENTITY_ID).is(entityId);
		Query query = new Query();
		condition(fieldNames,fieldValues,operators,criteria);
		query.addCriteria(criteria);
        if(ValidationUtil.isEmpty(orderBy)){
            orderBy = ASIConstants.CREATE_DATE;
        }
        if(ValidationUtil.isEmpty(order)){
            order = Sort.Direction.DESC.toString();
        }
		return mongoDAO.getMongoOp().find(query.with(new Sort(Sort.Direction.fromString(order),orderBy)), Map.class, this.buildTableName(ASIType.TABLE.name(), entityType, groupCode));
	}

	@Override
	public Boolean isValueAvailable(String agencyCode, String entityType, String entityId, String groupCode, String id,
									String[] fieldNames, String[] fieldValues) throws Exception {
		Criteria criteria = Criteria.where(ASIConstants.AGENCY_CODE).is(CoreConstants.CODE_SUPER_ADMIN)
				.and(ASIConstants.GROUP_CODE).is(groupCode)
				.and(ASIConstants.ENTITY_TYPE).is(entityType)
				.and(ASIConstants.ENTITY_ID).is(entityId);
		if(!ValidationUtil.isEmpty(id)){
			criteria.and(ASIConstants.ID).ne(id);
		}
		Query query = new Query();
		for(int i=0;i<fieldNames.length;i++) {
			criteria.and(fieldNames[i]).is(fieldValues[i]);
		}
		query.addCriteria(criteria);
		Long count = mongoDAO.getMongoOp().count(query,buildTableName(ASIType.TABLE.name(),entityType,groupCode));
        return count <= 0;
    }

	@Override
	public Object getByEntityId(String agencyCode, String entityType, String entityId, String groupCode) throws Exception {
		Object currentValue = mongoDAO.getMongoOp().findOne(
				new Query(Criteria.where(ASIConstants.AGENCY_CODE).is(agencyCode)
						.and(ASIConstants.GROUP_CODE).is(groupCode)
						.and(ASIConstants.ENTITY_TYPE).is(entityType)
						.and(ASIConstants.ENTITY_ID).is(entityId)),
				Map.class,this.buildTableName(ASIType.TABLE.name(),entityType, groupCode));
		return currentValue;
	}

    @Override
    public void deleteByGroupCode(String agencyCode, String groupCode) throws Exception {
		mongoDAO.getMongoOp().remove(
				new Query(Criteria.where(ASIConstants.AGENCY_CODE).is(agencyCode)
						.and(ASIConstants.GROUP_CODE).is(ASIConstants.HELP_GROUP_CODE)
						.and(ASIConstants.ENTITY_TYPE).is(ASIConstants.HELP_ENTITY_ID)
						.and(ASIConstants.ENTITY_ID).is(groupCode)),
				Map.class,this.buildTableName(ASIType.TABLE.name(),ASIConstants.HELP_ENTITY_ID, ASIConstants.HELP_GROUP_CODE));
    }

	@Override
	public <T extends ASIModel> T createASI(T asiModel) throws Exception {
		boolean isUpdate = !ValidationUtil.isEmpty(asiModel.getSequenceNBR());
		String agencyCode = RequestContext.getAgencyCode();
		String groupCode = asiModel.getClass().getSimpleName();
		List<GroupColumnModel> columns =
				groupColumnService.getGroupColumns(RequestContext.getAgencyCode(),groupCode);
		if(ValidationUtil.isEmpty(columns)){
			throw new DataValidateException("未找到动态表" + groupCode + "的列定义,请检查动态表单配置");
		}
		Map<String,List<Map<String,String>>> multiValues = Maps.newHashMap();
		List<Map<String,String>> rows = Lists.newArrayList();
		Map<String,String> row = Maps.newHashMap();
		rows.add(row);
		multiValues.put(groupCode,rows);

		for(GroupColumnModel column : columns){
			Object value = Bean.getPropertyValue(column.getColumnCode(), asiModel);
			if(isUpdate && !ValidationUtil.isEmpty(value)){
				row.put(column.getColumnCode(),value.toString());
			}else if(!isUpdate){
				row.put(column.getColumnCode(),value != null ? value.toString() : "");
			}
		}
		if(isUpdate){
			row.put(ASIConstants.ID,asiModel.getSequenceNBR());
		}
		row.put(ASIConstants.ACTION,isUpdate ? ASIConstants.OPT_UPDATE : ASIConstants.OPT_ADD);
		Map<String, List<Map<String, Object>>> result
				= updateASIData(agencyCode, ASIConstants.ASI_ENTITY_TYPE_COMMON,
				ASIConstants.ASI_ENTITY_ID_COMMON, multiValues, null, ASIType.TABLE);
		Map<String,Object> createdRow = result.get(groupCode).get(0);
		return (T)Bean.mapToBean(createdRow,asiModel.getClass());
	}

	@Override
	public <T extends ASIModel> List<String> deleteASI(Class<T> asiModelClass,String... ids) throws Exception {
		String agencyCode = RequestContext.getAgencyCode();
		String groupCode = asiModelClass.getSimpleName();
		Map<String,List<Map<String,String>>> multiValues = Maps.newHashMap();
		List<Map<String,String>> rows = Lists.newArrayList();
		multiValues.put(groupCode,rows);
		Map<String,String> row = null;
		for (String id : ids) {
			row = Maps.newHashMap();
			row.put(ASIConstants.ACTION, ASIConstants.OPT_REMOVE);
			row.put(ASIConstants.ID, id);
			rows.add(row);
		}
		updateASIData(agencyCode, ASIConstants.ASI_ENTITY_TYPE_COMMON,
				ASIConstants.ASI_ENTITY_ID_COMMON,multiValues, null, ASIType.TABLE);
		return Arrays.asList(ids);
	}

	@Override
	public <T extends ASIModel> T updateASI(T asiModel) throws Exception {
		String agencyCode = RequestContext.getAgencyCode();
		String groupCode = asiModel.getClass().getSimpleName();
		String id = asiModel.getSequenceNBR();
		Map currentValue = mongoDAO.getMongoOp().findOne(
				new Query(Criteria.where(ASIConstants.AGENCY_CODE).is(agencyCode)
						.and(ASIConstants.GROUP_CODE).is(groupCode)
						.and(ASIConstants.ENTITY_TYPE).is(ASIConstants.ASI_ENTITY_TYPE_COMMON)
						.and(ASIConstants.ENTITY_ID).is(ASIConstants.ASI_ENTITY_ID_COMMON).and(ASIConstants.ID).is(id)),
				Map.class,this.buildTableName(ASIType.TABLE.name(),ASIConstants.ASI_ENTITY_TYPE_COMMON, groupCode));
		if(ValidationUtil.isEmpty(currentValue)){
			throw new DataNotFoundException(MessageConstants.DATA_NOT_FOUND);
		}
		return createASI(asiModel);
	}

	@Override
	public <T extends ASIModel> T getASIById(Class<T> asiModelClass,String id) throws Exception {
		String agencyCode = RequestContext.getAgencyCode();
		String groupCode = asiModelClass.getSimpleName();
		Map currentValue = mongoDAO.getMongoOp().findOne(
				new Query(Criteria.where(ASIConstants.AGENCY_CODE).is(agencyCode)
						.and(ASIConstants.GROUP_CODE).is(groupCode)
						.and(ASIConstants.ENTITY_TYPE).is(ASIConstants.ASI_ENTITY_TYPE_COMMON)
						.and(ASIConstants.ENTITY_ID).is(ASIConstants.ASI_ENTITY_ID_COMMON).and(ASIConstants.ID).is(id)),
				Map.class,this.buildTableName(ASIType.TABLE.name(),ASIConstants.ASI_ENTITY_TYPE_COMMON, groupCode));
		if(ValidationUtil.isEmpty(currentValue)){
			throw new DataNotFoundException(MessageConstants.DATA_NOT_FOUND);
		}
		return (T)Bean.mapToBean(currentValue,asiModelClass);
	}

	@Override
	public <T extends ASIModel> Page getASIByPage(
			Class<T> asiModelClass,String[] fieldNames,
			String[] fieldValues, String[] operators,
			Page page, String orderBy, String order) throws Exception{
		String agencyCode = RequestContext.getAgencyCode();
		String groupCode = asiModelClass.getSimpleName();
		String entityType = ASIConstants.ASI_ENTITY_TYPE_COMMON;
		String entityId = ASIConstants.ASI_ENTITY_ID_COMMON;
		return getByPage(agencyCode, entityType, entityId, groupCode, fieldNames, fieldValues, operators, page, orderBy, order);
	}

	@Override
	public <T extends ASIModel> boolean isASIValueAvailable(
			Class<T> asiModelClass, String id, String[] fieldNames, String[] fieldValues) throws Exception {
		String agencyCode = RequestContext.getAgencyCode();
		String groupCode = asiModelClass.getSimpleName();
		String entityType = ASIConstants.ASI_ENTITY_TYPE_COMMON;
		String entityId = ASIConstants.ASI_ENTITY_ID_COMMON;
		return isValueAvailable(agencyCode,entityType,entityId,groupCode,id,fieldNames,fieldValues);
	}

	public Criteria condition(String[] fieldNames, String[] fieldValues, String[] operators,Criteria criteria)throws Exception{
		if(!ValidationUtil.isEmpty(fieldNames) && !ValidationUtil.isEmpty(fieldValues) && !ValidationUtil.isEmpty(operators)){
			for(int i=0;i<fieldNames.length;i++){
				if(ValidationUtil.isEmpty(fieldValues[i])){
					continue;
				}
				switch (Operator.getInstance(operators[i])) {
					case EQ:
						criteria.and(fieldNames[i]).is(fieldValues[i]);
						break;
					case LIKE:
						criteria.and(fieldNames[i]).regex(".*" + fieldValues[i] + ".*");
						break;
					case GTE:
						criteria.and(fieldNames[i]).gte(fieldValues[i]);
						break;
					case LT:
						criteria.and(fieldNames[i]).lt(fieldValues[i]).gte(fieldValues[i+1]);
						break;

					default:
						throw new BusinessException(ASIConstants.OPERATOR_ERROR);
				}
			}
		}
		return criteria;
	}

	private String buildTableName(String asiType,String entityType, String groupCode) {
		return asiType.concat(ASIConstants.SPLIT_REGEX).concat(entityType).concat(ASIConstants.SPLIT_REGEX).concat(groupCode);
	}
}
