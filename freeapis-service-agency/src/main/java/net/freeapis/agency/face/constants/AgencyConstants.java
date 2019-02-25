package net.freeapis.agency.face.constants;

/**
 * <pre>
 * 
 *  freeapis
 *  File: AgencyConstants.java
 * 
 *  freeapis, Inc.
 *  Copyright (C): 2016
 * 
 *  Description:常量类（包含此模块所有常量定义）
 *  TODO
 * 
 *  Notes:
 * 	$Id: AgencyConstants.java 72642 2009-01-01 20:01:57Z freeapis\wuqiang $ 
 * 
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年8月26日		wuqiang		Initial.
 * 	@author gaoyuanteng@zhaotai.ren
 * </pre>
 */
public class AgencyConstants {
	
	public static final String DEFAULT_AGENCY_COORDINATE = "108.938198,34.230751";

	public static final String DEFAULT_AGENCY_USER_PASSWORD = "DC483E80A7A0BD9EF71D8CF973673924";
	
	public static final String CUSTOM_SERVICE = "CUSTOM_SERVICE";
	
	public static final String NO_CUSTOM_SERVICE_CAN_USE = "暂无可用的客服";
	
	//在Redis中的所有客服的list列表key
	public static final String CUSTOM_SERVICE_LIST = "CUSTOM_SERVICE_LIST";
	
	//Redis循环到的客服的序列数key
	public static final String CUSTOM_SERVICE_SORT = "CUSTOM_SERVICE_SORT";

	//供应商基础信息
	public static final String SUPPLIER_BASE_INFO = "BASE_INFO";

	public static final String SUPPLIER_NOT_FOUND = "供应商信息未找到！";
	public static final String SUPPLIER_IMAGE_TYPE_WORK_IMAGES = "workImages";

	public static final String SUPPLIER_CATEGORY_INFO ="category";
	public static final String SUPPLIER_WORK_IMAGE_INFO ="workImage";

	//同步供应商对应的分类类型
	public static final String SYNC_CATEGORY_SPU = "spu";
}

/*
 * $Log: av-env.bat,v $
 */