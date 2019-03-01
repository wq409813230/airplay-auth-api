package net.freeapis.systemctl.face;

import net.freeapis.core.foundation.exceptions.DataNotFoundException;
import net.freeapis.core.foundation.exceptions.DataValidateException;
import net.freeapis.core.foundation.model.Page;
import net.freeapis.core.foundation.orm.BaseService;
import net.freeapis.systemctl.face.entity.Dictionary;
import net.freeapis.systemctl.face.model.DictionaryEntryModel;
import net.freeapis.systemctl.face.model.DictionaryModel;

import java.util.List;
import java.util.Map;

/**
 *  freeapis,Inc.
 *  Copyright(C): 2016
 *  
 *  <p>字典服务,提供基础的字典Service层接口
 *  
 *  @author Administrator
 *  @date 2018/4/16 15:07
 */
public interface DictionaryService extends BaseService<DictionaryModel,Dictionary>
{
	/**
	 * 创建字典
	 * @param dictionaryModel 字典Model
	 * @return DictionaryModel
	 * @throws Exception 创建字典异常
	 */
	DictionaryModel createDictionary(DictionaryModel dictionaryModel) throws Exception;
	/**
	 * 删除字典
	 * @param agencyCode 商家编码
	 * @param dictCodes 字典编码,可变数据类型
	 * @throws DataValidateException 如果有字典中有字典值存在,则不能直接删除
	 */
	void deleteDictionary(String agencyCode, String... dictCodes) throws Exception;
	/**
	 * 更新字典
	 * @param dictionaryModel 字典Model
	 * @return DictionaryModel
	 * @throws Exception 创建字典异常
	 */
	DictionaryModel updateDictionary(DictionaryModel dictionaryModel) throws Exception;
	/**
	 * 根据商家编码和字典编码获取字典
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @return DictionaryModel
	 * @throws Exception
	 */
	DictionaryModel getByCode(String agencyCode, String dictCode) throws Exception;
	/**
	 * 分页查询字典
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @param dictName 字典名称
	 * @param page 分页对象 {@link net.freeapis.core.foundation.model.Page}
	 * @return Page
	 * @throws Exception
	 */
	Page getDictionaryByPage(String agencyCode, String dictCode, String dictName, Page page, String orderBy, String order) throws Exception;
	/**
	 * 判断字典编码是否可用
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @return 当字典编码不存在重复时返回 {@code true} ,否则返回{@code false}
	 * @throws Exception
	 */
	Boolean isDictionaryCodeAvailable(String agencyCode, String dictCode) throws Exception;
	/**
	 * 创建字典值
	 * @param dictionaryEntryModel 字典值model
	 * @return DictionaryEntryModel
	 * @throws Exception
	 */
	DictionaryEntryModel createEntry(DictionaryEntryModel dictionaryEntryModel) throws Exception;
	/**
	 * 删除字典值
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @param keys 字典key
	 * @throws Exception
	 */
	void deleteEntry(String agencyCode, String dictCode, String... keys) throws Exception;
	/**
	 * 更新字典值
	 * @param dictionaryEntryModel 字典值model
	 * @return DictionaryEntryModel
	 * @throws Exception
	 */
	DictionaryEntryModel updateEntry(DictionaryEntryModel dictionaryEntryModel) throws Exception;
	/**
	 * 启用/禁用字典值
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @param key 字典key
	 * @return DictionaryEntryModel
	 * @throws DataNotFoundException 如果字典值不存在则抛出数据未找到异常
	 */
	DictionaryEntryModel updateEntryLockStatus(String agencyCode, String dictCode, String key) throws Exception;
	/**
	 * 根据字典值key获取字典值
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @param key 字典key
	 * @return DictionaryEntryModel 字典值model
	 * @throws Exception
	 */
	DictionaryEntryModel getEntry(String agencyCode, String dictCode, String key) throws Exception;
	/**
	 * 根据字典值key获取value
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @param key 字典key
	 * @return 字典值value
	 * @throws Exception
	 */
	String getValue(String agencyCode, String dictCode, String key) throws Exception;
	/**
	 * 判断字典值key是否可用
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @param key 字典值key
	 * @return 如果字典值key不存在重复则返回 {@code true} 否则返回 {@code false}
	 * @throws Exception
	 */
	Boolean isEntryKeyAvailable(String agencyCode, String dictCode, String key) throws Exception;
	/**
	 * 分页查询字典值
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @param page 分页对象 {@link net.freeapis.core.foundation.model.Page}
	 * @return Page
	 * @throws Exception
	 */
	Page getEntryByPage(String agencyCode, String dictCode, Page page, String orderBy, String order) throws Exception;

    Page queryEntryByPage(String agencyCode, String dictCode, String entryKey,Page page, String orderBy, String order) throws Exception;
	/**
	 * 根据字典编码获取字典中的所有值
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @return 字典值列表
	 * @throws Exception
	 */
	List<DictionaryEntryModel> getEntries(String agencyCode, String dictCode) throws Exception;

	/**
	 * 根据字典编码获取字典的所有值
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @return 以map的形式返回,形如:
	 * <code>
	 *     {
	 *     	"key1":"value1",
	 *     	"key2";"value2"
	 *     }
	 * </code>
	 * @throws Exception
	 */
	Map<String,String> getEntryMap(String agencyCode, String dictCode) throws Exception;

	/**
	 * 验证字典值是否有效
	 * @param agencyCode 商家编码
	 * @param dictCode 字典编码
	 * @param key 字典key
	 * @param value 字典value
	 * @return 如果字典value不存在重复则返回<code>true</code>,否则返回<code>false</code>
	 * @throws Exception
	 */
	boolean isValueValid(String agencyCode, String dictCode, String key, String value) throws Exception;
}
