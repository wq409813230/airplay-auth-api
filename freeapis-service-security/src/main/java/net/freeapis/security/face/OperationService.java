package net.freeapis.security.face;

import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.orm.BaseService;
import net.freeapis.security.face.entity.Operation;
import net.freeapis.security.face.model.OperationModel;

import java.util.List;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: SecurityResourceService.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  TODO
 * 
 *  Notes:
 *  $Id: SecurityResourceService.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2015年6月16日		wuqiang		Initial.
 *
 * </pre>
 */
public interface OperationService extends BaseService<OperationModel,Operation>
{

	/**
	 * 创建单个的资源操作信息
	 * @param operation
	 * @return
	 * @throws Exception 
	 */
	OperationModel createOperation(OperationModel operation) throws Exception;

	/**
	 * TODO.同步模块的所有操作到数据库中
	 * @param operations
	 * @throws Exception
	 */
	void syncOperations(List<OperationModel> operations) throws Exception;

	/**
	 * 获取系统所有资源
	 * @return
	 */
     List<Object> getAllOperations() throws Exception;


	/**
	 * 根据主键删除资源信息
	 * @param ids
	 */
	void deleteOperations(Long[] ids) throws Exception;

	/**
	 * 判断资源Funcid是否唯一
	 * @param funcId
	 * @param id
	 * @return
	 */
	Boolean isFuncIdAvailable(String funcId, Long id) throws Exception;

	/**
	 * 分页查询资源列表
	 * @param resourceName
	 * @param page
	 * @param orderBy
	 * @param order
	 * @return
	 * @throws Exception
	 */
	Page getForPage(String resourceName,Page page, String orderBy, String order) throws Exception;

	/**
	 * 修改资源
	 * @param operationModel
	 * @return
	 * @throws Exception
	 */
	OperationModel updateOperation(OperationModel operationModel) throws Exception;

	/**
	 * 根据funcId查找操作信息
	 * @param funcId
	 * @return
	 * @throws Exception
	 */
	OperationModel getByFuncId(String funcId) throws Exception;
}
