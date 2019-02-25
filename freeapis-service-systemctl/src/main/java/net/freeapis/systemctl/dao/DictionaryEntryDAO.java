package net.freeapis.systemctl.dao;

import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.mysql.GenericDAO;
import net.freeapis.systemctl.face.entity.DictionaryEntry;

import java.util.List;

/**
 * 
 * <pre>
 * 
 *  freeapis
 *  File: DictionaryEntryDao.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2015
 * 
 *  Description:
 *  <p>字典值服务,提供基础的字典值DAO层接口
 * 
 *  Notes:
 *  $Id: DictionaryEntryDao.java 31101200-9 2014-10-14 16:43:51Z freeapis\framework $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  - 2016年07月12日		framework		Initial.
 *
 * </pre>
 */
public interface DictionaryEntryDAO extends GenericDAO<DictionaryEntry>
{
	/**
	 * TODO.删除字典值,同时删除缓存
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @param entryKey 字典key
	 * @return
	 * @throws Exception
	 */
	void delete(String agencyCode,String dictCode,String entryKey) throws Exception;
	/**
	 * TODO.更新字典值,同时更新缓存
	 * @param dictionaryEntry
	 * @throws Exception
	 */
	void update(DictionaryEntry dictionaryEntry) throws Exception;
	/**
	 * TODO.根据字典key获取字典
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @param entryKey 字典key
	 * @return DictionaryEntry
	 * @throws Exception
	 */
	DictionaryEntry findEntryByKey(String agencyCode,String dictCode,String entryKey) throws Exception;
	/**
	 * TODO.根据字典key获取字典value
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @param entryKey 字典key
	 * @return 字典value
	 * @throws Exception
	 */
	String findValueByKey(String agencyCode,String dictCode,String entryKey) throws Exception;
	/**
	 * TODO.分页查询字典值
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @param page 分页对象 {@link net.freeapis.core.foundation.model.Page}
	 * @param orderBy 排序字段
	 * @param order 排序方式
	 * @return 分页字典值列表
	 * @throws Exception
	 */
	List<DictionaryEntry> findEntiesByPage(String agencyCode,String dictCode,Page page,String orderBy,String order) throws Exception;
	/**
	 * TODO.获取字典中的所有值
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @return 字典值列表
	 * @throws Exception
	 */
	List<DictionaryEntry> findEntries(String agencyCode,String dictCode) throws Exception;


}
