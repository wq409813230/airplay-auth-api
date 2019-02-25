package net.freeapis.asi.service.core.processor;

import net.freeapis.asi.face.ASIService;
import net.freeapis.asi.face.constants.ASIConstants;
import net.freeapis.asi.face.entity.GroupColumn;
import net.freeapis.asi.face.enums.ASIType;
import net.freeapis.asi.face.enums.DataType;
import net.freeapis.asi.service.core.validation.ASIDataValidatorAdapter;
import net.freeapis.core.foundation.constants.CoreConstants;
import net.freeapis.core.foundation.exceptions.BusinessException;
import net.freeapis.core.foundation.exceptions.DataValidateException;
import net.freeapis.core.foundation.support.SpringContextHelper;
import net.freeapis.core.foundation.utils.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * &lt;pre&gt;
 * <p/>
 * Lexing File: TypeProcessor PROJECT: build-generator
 * <p/>
 * Lexing, Inc. Copyright (C): 2015
 * <p/>
 * Description: ${todo}
 * <p/>
 * Notes: $$Id: TypeProcessor 31101200-9 2014-10-14 16:43:51Z Lexing\ Tony.Li $$
 * <p/>
 * Revision History &amp;lt;Date&amp;gt;, &amp;lt;Who&amp;gt;,
 * &amp;lt;What&amp;gt; 2015/11/24 Tony.Li Initial.
 * <p/>
 * &lt;/pre&gt;
 */
public abstract class TypeProcessor {

	@Autowired
	protected ASIService asiService;

	private ASIType asiType;

	public ASIType getAsiType() {
		return asiType;
	}

	public void setAsiType(ASIType asiType) {
		this.asiType = asiType;
	}

	/**
	 *
	 * @param type
	 * @return
	 * @throws Exception
	 */
	public static TypeProcessor getProcessor(ASIType type) throws Exception {
		TypeProcessor tp = SpringContextHelper
				.getBean(type.getProcessorName().concat(ASIConstants.PROCESSORNAME_SUBFIX));
		tp.setAsiType(type);
		return tp;
	}

	/**
	 *
	 * @param agencyCode
	 * @param entityType
	 * @param entityId
	 * @param formValues
	 * @param tableValues
	 * @return
	 * @throws Exception
	 */
	public Map update(String agencyCode, String entityType, String entityId,
			Map<String, List<Map<String, String>>> tableValues, Map<String, Map<String, String>> formValues)
					throws Exception {

		if (this.asiType.getValue() == ASIType.TABLE.getValue() && ValidationUtil.isEmpty(tableValues)
				|| this.asiType.getValue() == ASIType.FORM.getValue() && ValidationUtil.isEmpty(formValues)) {
			throw new DataValidateException("ASI ".concat(this.asiType.name()).concat(" Data required."));
		}

		return update4Type(agencyCode, entityType, entityId, tableValues, formValues);
	}

	protected abstract Map update4Type(String agencyCode, String entityType, String entityId,
			Map<String, List<Map<String, String>>> tableValues, Map<String, Map<String, String>> formValues)
					throws Exception;

	public String buildTableName(String entityType, String groupCode) {
		return this.asiType.name().concat(ASIConstants.SPLIT_REGEX).concat(entityType).concat(ASIConstants.SPLIT_REGEX).concat(groupCode);
	}

	/**
	 * TODO.根据元数据验证前端数据,目的有二:
	 * 1.防止向数据库写入垃圾数据,传入的数据字段必须能和元数据对应
	 * 2.根据元数据的数据类型验证数据的有效性
	 * 
	 * @param values
	 * @param meta
	 * @return
	 * @throws DataValidateException
	 * @throws BusinessException 
	 */
	protected Map<String, String> validateValues(Map<String, String> values, Map<String, GroupColumn> meta)
			throws DataValidateException, BusinessException {
		Map<String,String> validValues = new HashMap<String,String>();
		boolean isUpdate = ASIConstants.OPT_UPDATE.equals(values.get(ASIConstants.ACTION));
		Iterator<String> iterator = meta.keySet().iterator();
		String key = null;
		GroupColumn currentColumn = null;
		String currentValue = null;
		while (iterator.hasNext()) {
			key = iterator.next();
			currentColumn = meta.get(key);
			currentValue = values.get(key);

            //这里根据操作符和字段值判断是否设置值,实现DynamicUpdate.只更新指定的字段值,避免全列更新
            if(isUpdate && !values.containsKey(currentColumn.getColumnCode())) continue;

			// 先根据元数据校验数据的长度，可空等
			if(CoreConstants.COMMON_Y.equals(currentColumn.getIsRequired()) && ValidationUtil.isEmpty(currentValue))
				throw new DataValidateException(currentColumn.getColumnCode() + " is required!");

			if(!ValidationUtil.isEmpty(currentValue) && currentValue.length() > currentColumn.getMaxLength())
				throw new DataValidateException("data too long for column " + currentColumn.getColumnCode());

			// 根据数据类型验证数据
			if (!validateValue(currentValue, DataType.getDataType(currentColumn.getDataType())))
				throw new DataValidateException(" the value " + currentValue + " dose not match the dataType: "
						+ currentColumn.getDataType());

			validValues.put(key, currentValue);
		}
		return validValues;
	}

	private boolean validateValue(String value, DataType dataType) throws DataValidateException {
		if(!dataType.isNeedValidate() || ValidationUtil.isEmpty(value)) return true;
		return ASIDataValidatorAdapter.validate(dataType, value);
	}

	public Object getValues(String agencyCode, String groupCode, String entityType, String entityId,String order) throws Exception {
		Object result = null;
		switch (this.asiType) {
		case FORM:
			result = this.getFormValue(agencyCode, groupCode, entityType, entityId);
			break;
		case TABLE:
			result = this.getTableValue(agencyCode, groupCode, entityType, entityId, order);
			break;
		default:
			break;
		}
		return result;
	}

	@SuppressWarnings("rawtypes")
	protected abstract Map getFormValue(String agencyCode, String groupCode, String entityType,
			String entityId) throws Exception;

	@SuppressWarnings("rawtypes")
	protected abstract List<Map> getTableValue(String agencyCode, String groupCode, String entityType, String entityId,
											   String order) throws Exception;
}
