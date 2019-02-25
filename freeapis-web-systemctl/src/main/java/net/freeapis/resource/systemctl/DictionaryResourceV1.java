package net.freeapis.resource.systemctl;


import net.freeapis.core.foundation.constants.MessageConstants;
import net.freeapis.core.foundation.constants.ParamConstants;
import net.freeapis.core.foundation.context.RequestContext;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.rest.BaseResources;
import net.freeapis.core.rest.containers.APILevel;
import net.freeapis.core.rest.containers.FreeapisOperation;
import net.freeapis.core.rest.containers.FreeapisResource;
import net.freeapis.core.rest.utils.ResponseHelper;
import net.freeapis.core.rest.utils.ResponseModel;
import net.freeapis.systemctl.face.DictionaryService;
import net.freeapis.systemctl.face.model.DictionaryEntryModel;
import net.freeapis.systemctl.face.model.DictionaryModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: DictionaryResourceV1.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  TODO
 *  Description:
 * 
 *  Notes:
 *  $Id: DictionaryResourceV1.java 31101200-9 2014-10-14 16:43:51Z freeapis\freeapis $
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年8月19日		freeapis		Initial.
 *
 * </pre>
 */
@RestController
@RequestMapping(value = "/1/dictionary")
@FreeapisResource(module = "systemctl",value = "DictionaryResourceV1",description="字典信息")
public class DictionaryResourceV1 extends BaseResources
{
	@Autowired
	private DictionaryService dictionaryService;
	
	@FreeapisOperation(name = "createDictionary", ApiLevel = APILevel.AGENCY,description = "创建字典",beanValidation = true)
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseModel<DictionaryModel> createDictionary(@RequestBody DictionaryModel dictionaryModel) throws Exception
	{
		return ResponseHelper.buildResponseModel(dictionaryService.createDictionary(dictionaryModel));
	}
	
	@FreeapisOperation(name = "deleteDictionary", ApiLevel = APILevel.AGENCY,description = "删除字典")
	@RequestMapping(value = "", method = RequestMethod.DELETE)
	public ResponseModel<String> deleteDictionary(@RequestBody String[] codes) throws Exception
	{
		dictionaryService.deleteDictionary(RequestContext.getAgencyCode(), codes);
		return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
	}

	@FreeapisOperation(name = "updateDictionary", ApiLevel = APILevel.AGENCY,description = "更新字典")
	@RequestMapping(value = "/{dictCode}", method = RequestMethod.PUT)
	public ResponseModel<DictionaryModel> updateDictionary(
			@RequestBody DictionaryModel dictionaryModel,
			@PathVariable(value="dictCode") String dictCode) throws Exception {
		dictionaryModel.setDictCode(dictCode);
		dictionaryModel.setAgencyCode(RequestContext.getAgencyCode());
		return ResponseHelper.buildResponseModel(dictionaryService.updateDictionary(dictionaryModel));
	}

	@FreeapisOperation(name = "queryByCode", ApiLevel = APILevel.ALL,description = "通过字典编码获取字典")
	@RequestMapping(value = "/{dictCode}", method = RequestMethod.GET)
	public ResponseModel<DictionaryModel> queryByCode(
			@PathVariable(value = "dictCode") String dictCode) throws Exception {
		return ResponseHelper.buildResponseModel(dictionaryService.getByCode(RequestContext.getAgencyCode(), dictCode));
	}

	@FreeapisOperation(name = "queryForPage", ApiLevel = APILevel.ALL,description = "分页查询字典信息")
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public ResponseModel<Page> queryForPage(
			@RequestParam(value = "dictName", required = false) String dictName,
			@RequestParam(value = "dictCode", required = false) String dictCode,
			@RequestParam(value = ParamConstants.SIDX, required = false) String orderby,
			@RequestParam(value = ParamConstants.SORT, required = false) String order,
			@RequestParam(value = ParamConstants.OFFSET) int start,
			@RequestParam(value = ParamConstants.LENGTH) int length) throws Exception
	{
		return ResponseHelper.buildResponseModel(dictionaryService.getDictionaryByPage(RequestContext.getAgencyCode(),
				dictCode, dictName, new Page(length,start), orderby, order));
	}
	
	@FreeapisOperation(name = "isDictionaryCodeAvailable", ApiLevel = APILevel.ALL,description = "检查字典编号是否可用")
	@RequestMapping(value = "/{dictCode}/available", method = RequestMethod.GET)
	public ResponseModel<Boolean> isDictionaryCodeAvailable(
			@PathVariable(value = "dictCode") String dictCode) throws Exception {
		return ResponseHelper.buildResponseModel(dictionaryService.isDictionaryCodeAvailable(RequestContext.getAgencyCode(), dictCode));
	}
	
	@FreeapisOperation(name = "queryForValuePage", ApiLevel = APILevel.ALL, description = "根据字典编码分页条件查询字典值")
	@RequestMapping(value = "/{dictCode}/entries/page", method = RequestMethod.GET)
	public ResponseModel<Page> queryForValuePage(
			@PathVariable(value = "dictCode") String dictCode,
			@RequestParam(value = "agencyCode", required = false) String agencyCode,
			@RequestParam(value = ParamConstants.SIDX, required = false) String orderby,
			@RequestParam(value = ParamConstants.SORT, required = false) String order,
			@RequestParam(value = ParamConstants.OFFSET) int start,
			@RequestParam(value = ParamConstants.LENGTH) int length) throws Exception {
		Page page = dictionaryService.getEntryByPage(agencyCode, dictCode, new Page(length,start), orderby, order);
		return ResponseHelper.buildResponseModel(page);
	}

	@FreeapisOperation(name = "queryList", ApiLevel = APILevel.ALL, description = "根据字典编码获取当前商家字典的所有值")
	@RequestMapping(value = "/{dictCode}/entries", method = RequestMethod.GET)
	public ResponseModel<List<DictionaryEntryModel>> queryList(
			@PathVariable(value = "dictCode") String dictCode) throws Exception {
		return ResponseHelper.buildResponseModel(dictionaryService.getEntries(RequestContext.getAgencyCode(),dictCode));
	}


	@FreeapisOperation(name = "queryValue", ApiLevel = APILevel.ALL, description = "获取指定字典值")
	@RequestMapping(value = "/{dictCode}/entry/{key}", method = RequestMethod.GET)
	public ResponseModel<DictionaryEntryModel> queryValue(
			@PathVariable(value = "dictCode") String dictCode,
			@PathVariable(value = "key") String dictDataKey,
			@RequestParam(value = "agencyCode") String agencyCode) throws Exception {
		return ResponseHelper.buildResponseModel(dictionaryService.getEntry(agencyCode, dictCode, dictDataKey));
	}

	@FreeapisOperation(name = "createStandardChoicesValue", ApiLevel = APILevel.AGENCY, description = "创建字典值")
	@RequestMapping(value = "/{dictCode}/entry", method = RequestMethod.POST)
	public ResponseModel<DictionaryEntryModel> createStandardChoicesValue(
			@RequestBody DictionaryEntryModel dictionaryEntryModel,
			@PathVariable String dictCode ) throws Exception {
		return ResponseHelper.buildResponseModel(dictionaryService.createEntry(dictionaryEntryModel));
	}

	@FreeapisOperation(name = "deleteStandardChoicesValue", ApiLevel = APILevel.AGENCY, description = "删除字典值")
	@RequestMapping(value = "/{dictCode}/entries", method = RequestMethod.DELETE)
	public ResponseModel<String> deleteStandardChoicesValue(
			@PathVariable String dictCode,
			@RequestBody String[] entryKey) throws Exception {
		dictionaryService.deleteEntry(RequestContext.getAgencyCode(), dictCode,entryKey);
		return ResponseHelper.buildResponseModel(MessageConstants.SUCCEED);
	}

	@FreeapisOperation(name = "updateStandardChoicesValue", ApiLevel = APILevel.AGENCY, description = "更新字典值")
	@RequestMapping(value = "/{dictCode}/entry/{entryKey}", method = RequestMethod.PUT)
	public ResponseModel<DictionaryEntryModel> updateStandardChoicesValue(
            @RequestBody DictionaryEntryModel dictionaryEntryModel,
            @PathVariable String dictCode, @PathVariable String entryKey) throws Exception {
		dictionaryEntryModel.setDictCode(dictCode);
		dictionaryEntryModel.setEntryKey(entryKey);
		dictionaryEntryModel.setAgencyCode(RequestContext.getAgencyCode());
		return ResponseHelper.buildResponseModel(dictionaryService.updateEntry(dictionaryEntryModel));
	}


	@FreeapisOperation(name = "isEntryKeyAvailable", ApiLevel = APILevel.ALL, description = "字典值key是否可用")
	@RequestMapping(value = "/{dictCode}/entry/{key}/available", method = RequestMethod.GET)
	public ResponseModel<Boolean> isEntryKeyAvailable(
			@PathVariable String key,
			@PathVariable String dictCode,
			@RequestParam String agencyCode) throws Exception {
		return ResponseHelper.buildResponseModel(dictionaryService.isEntryKeyAvailable(agencyCode, dictCode, key));
	}

	@FreeapisOperation(name = "updateLockStatus", ApiLevel = APILevel.AGENCY,  description = "启用/禁用字典值。")
	@RequestMapping(value = "/{dictCode}/entry/{key}/lockStatus", method = RequestMethod.PUT)
	public ResponseModel<DictionaryEntryModel> updateLockStatus(
			@PathVariable String key,
			@PathVariable String dictCode) throws Exception {
		return ResponseHelper.buildResponseModel(dictionaryService.updateEntryLockStatus(RequestContext.getAgencyCode(), dictCode, key));
	}
}

/*
 * $Log: av-env.bat,v $
 */