package net.freeapis.asi.service.core.processor.impl;

import net.freeapis.asi.dao.GroupColumnDAO;
import net.freeapis.asi.face.constants.ASIConstants;
import net.freeapis.asi.face.entity.GroupColumn;
import net.freeapis.asi.face.extension.ASIBizHandler;
import net.freeapis.asi.service.core.processor.TypeProcessor;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.exceptions.DataValidateException;
import net.freeapis.core.foundation.sequence.SequenceGenerator;
import net.freeapis.core.foundation.utils.DateTimeUtil;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mongodb.MongoDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Component;

import java.util.*;

/**
 * &lt;pre&gt;
 * <p/>
 * Lexing File: TablePorcessor PROJECT: build-generator
 * <p/>
 * Lexing, Inc. Copyright (C): 2015
 * <p/>
 * Description: ${todo}
 * <p/>
 * Notes: $$Id: TablePorcessor 31101200-9 2014-10-14 16:43:51Z Lexing\ Tony.Li
 * $$
 * <p/>
 * Revision History &amp;lt;Date&amp;gt;, &amp;lt;Who&amp;gt;,
 * &amp;lt;What&amp;gt; 2015/11/24 Tony.Li Initial.
 * <p/>
 * &lt;/pre&gt;
 */
@Component("tableProcessor")
public class TablePorcessor extends TypeProcessor {

	@Autowired
	private MongoDAO<Map<String, String>> mongoDAO;

	@Autowired
	private GroupColumnDAO groupColumnDAO;
	
	@Autowired
	private SequenceGenerator sequenceGenerator;


	@Override
	public Map update4Type(String agencyCode, String entityType, String entityId,
			Map<String, List<Map<String, String>>> tableValues, Map<String, Map<String, String>> formValues) throws Exception {
		if (ValidationUtil.isEmpty(tableValues)) {
			throw new DataValidateException("Request data can not be null.");
		}
		Map<String, GroupColumn> currentColumnMeta = null;
		Map<String, List<Map<String, String>>> updateResult = new HashMap<String, List<Map<String, String>>>();
		List<Map<String, String>> updatedRows = null;
		for (String groupCode : tableValues.keySet()) {
			if (!ValidationUtil.isEmpty(tableValues.get(groupCode))) {
				updatedRows = new ArrayList<Map<String, String>>();
				currentColumnMeta = groupColumnDAO.findGroupColumnsMap(agencyCode, groupCode);
				for (Map<String, String> currentRow :tableValues.get(groupCode)) {
					// 取出对此行的操作.
					String action = currentRow.get(ASIConstants.ACTION);
					//取出此行的ID
					String currentId = currentRow.get(ASIConstants.ID);
					currentId = !ValidationUtil.isEmpty(currentId) ? currentId : String.valueOf(sequenceGenerator.getNextValue());
					String nodeLevel = CoreConstants.COMMON_0;
					if(!ValidationUtil.isEmpty(currentRow.get("nodeLevel"))){
                        nodeLevel = currentRow.get("nodeLevel");
                    }

					//如果不是删除操作才验证该行数据
					if(!ASIConstants.OPT_REMOVE.equals(action))
						currentRow = this.validateValues(currentRow, currentColumnMeta);
					
					if(!ASIConstants.OPT_REMOVE.equals(action) && ValidationUtil.isEmpty(currentRow)) continue;
					
					Iterator<String> iterator = currentRow.keySet().iterator();
					Update update = new Update();
					while (iterator.hasNext()) {
						String key = iterator.next();
						update.set(key, currentRow.get(key));
					}
					//更新前设置特殊属性字段.
					update.set(ASIConstants.ID, currentId);
					update.set(ASIConstants.MONGO_ID,currentId);
					update.set(ASIConstants.AGENCY_CODE, agencyCode);
					update.set(ASIConstants.GROUP_CODE, groupCode);
					update.set(ASIConstants.ENTITY_TYPE, entityType);
					update.set(ASIConstants.ENTITY_ID, entityId);
					update.set(ASIConstants.REC_USER_ID,RequestContext.getExeUserId());
					update.set(ASIConstants.REC_USER_NAME,RequestContext.getExeUserName());
					update.set(ASIConstants.REC_DATE,DateTimeUtil.convertToISODate(new Date()));
                    update.set(ASIConstants.NODE_LEVEL, nodeLevel);
					if(ASIConstants.OPT_ADD.equals(action)) update.set(ASIConstants.CREATE_DATE,new Date());


					ASIBizHandler.updateBefore(action,update,groupCode,entityType,entityId);

					if (!ValidationUtil.isEmpty(action)) {
						switch (action) {
							case ASIConstants.OPT_ADD:
								update.set(ASIConstants.CREATE_USER_ID,RequestContext.getExeUserId());
								update.set(ASIConstants.CREATE_USER_NAME,RequestContext.getExeUserName());
								update.set(ASIConstants.CREATE_DATE,DateTimeUtil.convertToISODate(new Date()));
								mongoDAO.getMongoOp()
										.upsert(new Query(Criteria.where(ASIConstants.AGENCY_CODE).is(agencyCode)
												.and(ASIConstants.GROUP_CODE).is(groupCode)
												.and(ASIConstants.ENTITY_TYPE).is(entityType)
												.and(ASIConstants.ENTITY_ID).is(entityId)
												.and(ASIConstants.ID).is(currentId)),
												update,Map.class, buildTableName(entityType,groupCode));
								break;
							case ASIConstants.OPT_UPDATE:
								mongoDAO.getMongoOp()
										.upsert(new Query(Criteria.where(ASIConstants.AGENCY_CODE).is(agencyCode)
												.and(ASIConstants.GROUP_CODE).is(groupCode)
												.and(ASIConstants.ENTITY_TYPE).is(entityType)
												.and(ASIConstants.ENTITY_ID).is(entityId)
												.and(ASIConstants.ID).is(currentId)),
												update,Map.class, buildTableName(entityType, groupCode));
								break;
							case ASIConstants.OPT_REMOVE:
								mongoDAO.getMongoOp()
										.remove(new Query(Criteria.where(ASIConstants.AGENCY_CODE).is(agencyCode)
												.and(ASIConstants.GROUP_CODE).is(groupCode)
												.and(ASIConstants.ENTITY_TYPE).is(entityType)
												.and(ASIConstants.ENTITY_ID).is(entityId)
												.and(ASIConstants.ID).is(currentId)),buildTableName(entityType, groupCode));
							break;
							default:
								break;
						}

					}
					currentRow.put(ASIConstants.ID, currentId);
					updatedRows.add(currentRow);
				}
				updateResult.put(groupCode, updatedRows);
			}
		}
		return updateResult;
	}

	@SuppressWarnings({ "rawtypes" })
	@Override
	public Map getFormValue(String agencyCode, String groupCode,String entityType,String entityId) throws Exception {
		return null;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> getTableValue(String agencyCode, String groupCode,String entityType,String entityId,
								   String order) throws Exception {
		if(ValidationUtil.isEmpty(order)){
			order = Sort.Direction.ASC.toString();
		}
		return mongoDAO.getMongoOp()
				.find(new Query(Criteria.where(ASIConstants.AGENCY_CODE).is(agencyCode)
						.and(ASIConstants.GROUP_CODE).is(groupCode)
						.and(ASIConstants.ENTITY_TYPE).is(entityType)
						.and(ASIConstants.ENTITY_ID).is(entityId)).with(new Sort(Sort.Direction.fromString(order),ASIConstants.NODE_LEVEL)),
						Map.class,this.buildTableName(entityType, groupCode));
	}

}
