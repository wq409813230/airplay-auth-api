package net.freeapis.systemctl.dao;

import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.systemctl.face.entity.Dictionary;

import java.util.List;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: DictionaryDao.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  <p>字典服务,提供基础的字典DAO层接口
 * 
 *  Notes:
 *  $Id: DictionaryDao.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年07月12日		framework		Initial.
 *
 * </pre>
 */
public interface DictionaryDAO extends GenericDAO<Dictionary>
{
	/**
	 * TODO.删除字典-带缓存
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @throws Exception
	 */
	void delete(String agencyCode,String dictCode) throws Exception;
	/**
	 * TODO.更新字典-带缓存
	 * @param dictionary
	 * @throws Exception
	 */
	void update(Dictionary dictionary) throws Exception;
	/**
	 * TODO.根据字典编码查询字典-先从缓存中取,缓存中没有再从数据库取
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @return Dictionary
	 * @throws Exception
	 */
	Dictionary findByDictCode(String agencyCode,String dictCode) throws Exception;
	/**
	 * TODO.分页查询字典
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @param dictName 字典名称
	 * @param page 分页对象 {@link net.freeapis.core.foundation.model.Page}
	 * @param orderBy 排序字段
	 * @param order 排序方式
	 * @return 分页字典列表
	 * @throws Exception
	 */
	List<Dictionary> findByPage(String agencyCode,String dictCode,String dictName,Page page,String orderBy,String order) throws Exception;
}
