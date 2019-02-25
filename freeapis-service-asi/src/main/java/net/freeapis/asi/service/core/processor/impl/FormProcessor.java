package net.freeapis.asi.service.core.processor.impl;

import net.freeapis.asi.dao.GroupColumnDAO;
import net.freeapis.asi.face.constants.ASIConstants;
import net.freeapis.asi.service.core.processor.TypeProcessor;
import net.freeapis.core.foundation.sequence.SequenceGenerator;
import net.freeapis.core.foundation.utils.ValidationUtil;
import net.freeapis.core.mongodb.MongoDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Component;

import java.util.*;

/**
 * &lt;pre&gt;
 * <p/>
 * Lexing File: FormProcessor PROJECT: build-generator
 * <p/>
 * Lexing, Inc. Copyright (C): 2015
 * <p/>
 * Description: ${todo}
 * <p/>
 * Notes: $$Id: FormProcessor 31101200-9 2014-10-14 16:43:51Z Lexing\ Tony.Li $$
 * <p/>
 * Revision History &amp;lt;Date&amp;gt;, &amp;lt;Who&amp;gt;,
 * &amp;lt;What&amp;gt; 2015/11/24 Tony.Li Initial.
 * <p/>
 * &lt;/pre&gt;
 */
@Component("formProcessor")
public class FormProcessor extends TypeProcessor {

	@Autowired
	private GroupColumnDAO groupColumnDAO;

	@Autowired
	private MongoDAO<Map<String, String>> mongoDAO;
	
	@Autowired
	private SequenceGenerator sequenceGenerator;

	@Override
	public Map update4Type(String agencyCode, String entityType, String entityId,
			Map<String, List<Map<String, String>>> tableValues, Map<String, Map<String, String>> formValues)
					throws Exception {
		Map<String, String> currentForm = null;
		Map<String, Map<String, String>> updateResult = new HashMap<String, Map<String, String>>();
		for (String groupCode : formValues.keySet()) {
			// #1.验证数据
			currentForm = formValues.get(groupCode);
			//取出ID
			String currentId = currentForm.get(ASIConstants.ID);
			currentId = !ValidationUtil.isEmpty(currentId) ? currentId : String.valueOf(sequenceGenerator.getNextValue());
			//取出对表单的操作
			String action = currentForm.get(ASIConstants.ACTION);

			currentForm = validateValues(currentForm,groupColumnDAO.findGroupColumnsMap(agencyCode, groupCode));
			
			if (ValidationUtil.isEmpty(currentForm)) return null;
			// #2.更新数据
			Iterator<String> iterator = currentForm.keySet().iterator();
			Update update = new Update();
			while (iterator.hasNext()) {
				String key = iterator.next();
				update.set(key, currentForm.get(key));
			}
			
			update.set(ASIConstants.ID, currentId);
			update.set(ASIConstants.AGENCY_CODE, agencyCode);
			update.set(ASIConstants.GROUP_CODE, groupCode);
			update.set(ASIConstants.ENTITY_TYPE, entityType);
			update.set(ASIConstants.ENTITY_ID, entityId);
			update.set(ASIConstants.REC_DATE,new Date());
			if(ASIConstants.OPT_ADD.equals(action)) update.set(ASIConstants.CREATE_DATE,new Date());

			mongoDAO.getMongoOp().upsert(
					new Query(Criteria.where(ASIConstants.AGENCY_CODE).is(agencyCode)
							.and(ASIConstants.GROUP_CODE).is(groupCode)
							.and(ASIConstants.ENTITY_TYPE).is(entityType)
							.and(ASIConstants.ENTITY_ID).is(entityId)),
					update, Map.class, super.buildTableName(entityType, groupCode));
			
			currentForm.put(ASIConstants.ID, currentId);
			updateResult.put(groupCode, currentForm);
		}
		return updateResult;
	}

	@SuppressWarnings({ "rawtypes" })
	@Override
	public Map getFormValue(String agencyCode, String groupCode, String entityType, String entityId) throws Exception {
		return mongoDAO.getMongoOp().findOne(
				new Query(Criteria.where(ASIConstants.AGENCY_CODE).is(agencyCode)
						.and(ASIConstants.GROUP_CODE).is(groupCode)
						.and(ASIConstants.ENTITY_TYPE).is(entityType)
						.and(ASIConstants.ENTITY_ID).is(entityId)),
				Map.class, this.buildTableName(entityType, groupCode));
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> getTableValue(String agencyCode, String groupCode, String entityType,
			String entityId,String order) throws Exception {
		return null;
	}

}
