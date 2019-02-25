package net.freeapis.security.face.constants;

/**
 * <pre>
 *
 *  freeapis
 *  File: CoreConstants.java
 *
 *  freeapis, Inc.
 *  Copyright (C): 2016
 *
 *  Description:
 *  TODO
 *
 *  Notes:
 *  $Id: CoreConstants.java 31101200-9 2014-10-14 16:43:51Z freeapis\wuqiang $
 *
 *  Revision History
 *  &lt;Date&gt;,			&lt;Who&gt;,			&lt;What&gt;
 *  2016年7月11日		wuqiang		Initial.
 *
 * </pre>
 */
public class SecurityConstants {

    public static final String USER_DATA_CLEAN_TYPE_ALL = "all";

    public static final String USER_DATA_CLEAN_TYPE_BIZ = "biz";

    public static final String VIPNO_PROFIX = "UBS";

    public static final String VIPNO_CREATE = "VIPNO_CREATE";

    public static final String VIPNO_CREATE_KEY = "vipNoCreateKey";

    public static final String VIPNO_LENGTH = "10";

    public static final String RES_TYPE_API = "API";

    public static final String RES_TYPE_WEB = "WEB";

    public static final String MODULE_ROOT_CODE = "root";

    public static final String MODULE_ROOT_PCODE = "0";

    public static final String DEFAULT_USER_PASSWORD = "dc483e80a7a0bd9ef71d8cf973673924";

    public static final String ADMIN_ROLE_CODE = "ADMIN";

    public static final String splitor = "--";

    public static final String CACHE_KEY_PREFIX_SESSION = "SESSION";

    public static final String MESSAGE_TOKEN_REQUIRED = "TOKEN_REQUIRED--请求没有包含认证信息,请联系管理员.";

    public static final String MESSAGE_PRODUCT_REQUIRED = "PRODUCT_REQUIRED--请求必须包含设备信息.";

    public static final String MESSAGE_TOKEN_NOT_FOUND = "TOKEN_NOT_FOUND--无效的token";

    public static final String MESSAGE_TOKEN_EXPIRED = "TOKEN_EXPIRED--token已过期";

    public static final String MESSAGE_USER_NOT_FOUND = "USER_NOT_FOUND--当前账号不存在";

    public static final String MESSAGE_USER_LOCKED = "USER_LOCKED--当前账号已经禁用,请联系管理员";

    public static final String MESSAGE_PASSWORD_ERROR = "PASSWORD_ERROR--密码错误,输入密码不匹配";

    public static final String MESSAGE_SMSCODE_ERROR = "SMSCODE_ERROR--验证码错误,请重新获取";

    public static final String MESSAGE_TOKEN_OTHER_PLACE = "用户在它处登录.";

    public static final String MESSAGE_RESOURCE_FOBBIDEN = "RESOURCE_FOBBIDEN--没有访问权限.";

    public static final String MESSAGE_LOGINID_ALREADY_EXIST = "账号已存在!";

    public static final String MESSAGE_AUTHINFO_NOT_VALID = "认证信息校验失败!";

    public static final String MESSAGE_OLD_PASSWORD_ERROR = "密码错误,旧密码不匹配!";

    public static final String MESSAGE_LOGINID_NOT_VALID = "登录账号不合法!";

    public static final String MESSAGE_LOGIN_PASSWORD_REQUIRED = "登录密码不能为空";

    public static final String MESSAEG_IDENTIFYINGCODE_ERROR = "验证码有误";

    public static final String MESSAGE_PASSWORD_NOT_AUTHED_ERROR = "您未曾设置过密码";

    public static final String CACHE_KEY_TAGS = "PUBLIC_USER_TAG";

    /**
     * 所有权限缓存的前缀
     */
    public static final String CACHE_KEY_PREFIX_PERMISSION = "PERMISSION";

    /**
     * 系统模块树
     */
    public static final String CACHE_KEY_MODULE_TREE = "PERMISSION_MODULE_TREE";

    /**
     * 获取agency模板树
     */
    public static final String CACHE_KEY_AGENCY_TEMPLATE_TREE = "PERMISSION_AGENCY_TEMPLATE_TREE";

    /**
     * 系统所有资源缓存key
     */
    public static final String CACHE_KEY_ALL_OPERATIONS = "PERMISSION_ALL_OPERATIONS";

    /**
     * agency模块资源列表
     */
    public static final String CACHE_KEY_AGENCY_OPERATION = "PERMISSION_AGENCY_OPERATIONS";

    /**
     * 主体权限列表
     */
    public static String CACHE_KEY_PRIMARY_PERMISSION = "PERMISSION_PRIMARY";

    /**
     * 用户对应模块的所有按钮编码
     */
    public static String CACHE_KEY_USER_BUTTONS = "PERMISSION_USER_BUTTONS";

    /**
     * 用户对应的所有后台API的funcId
     */
    public static String CACHE_KEY_USER_FUNC_IDS = "PERMISSION_USER_FUNC_IDS";

    /**
     * 用户模块树
     */
    public static final String CACHE_KEY_USER_MODULE_TREE = "PERMISSION_USER_MODULE_TREE";

    public static final String APPROVED_CANNOT_AGAIN = "已审核,不能再次进行操作";

    public static final String IDCARD_UNMATCHING = "身份证信息不匹配!";

    public static final String MESSAGE_IDDISCERN_FAILED = "身份证识别失败,请上传清晰的并且有效的身份证！";

    public static final String MESSAGE_NOT_SUBMIT = "您的认证信息已通过或者正在审核中不能再次提交!";

    public static final String MESSAGE_QR_TOKEN_NOT_VALID = "登录二维码不存在或已失效,请重新获取!";

    public static final String ACCESSKEY_MAIL_AUTH = "accesskey_mail_auth";

    public static final String ACCESSKEY_MOBILE_CHANGE = "accesskey_mobile_change";

    public static final String CACHE_KEY_QR_TOKEN = "qr_token";

    /**
     * 权限主体——用户
     */
    public static final String PERMISSION_PRIMARY_USER = "user";

    /**
     * 权限主体——角色
     */
    public static final String PERMISSION_PRIMARY_ROLE = "role";

    /**
     * 模块下存放的内容类型——button
     */
    public static final String MODULE_CONTENT_TYPE_BUTTON = "button";

    /**
     * 模块关联的按钮类型——API
     */
    public static final String MODULE_BUTTON_TYPE_API = "API";

    /**
     * 只针对按钮类型为API时的验证
     */
    public static final String MODULE_BUTTON_FUNC_ID_NOT_NULL = "按钮关联的funcId不能为空";

    public static final String NICKNAME_PREFIX = "优造";

    public static final String NICKNAME_CODES = "NICKNAME_CODES";

    public static final String NICKNAME_LENGTH = "6";

    public static final String MESSAGE_NO_INVOKE = "不支持第三方登录";

    public static final String MESSAGE_NO_REGEX = "未设置手机号效验的正则规则.";

    public static final String MESSAGE_PHONE_ERROR = "手机号位数不正确.";

    public static final String FID_GET_CURRENT_USER_MODULE_FIDS ="28228C5AAF8D4AB523A1B00D17480DBF";

    public static final String PARAM_PERSISTENT_CODE = "persistent_code";
    public static final String PARAM_OPEN_ID = "openid";
    public static final String PARAM_ACCESS_TOKEN = "access_token";
    public static final String PARAM_SNS_TOKEN = "sns_token";
    public static final String PARAM_UNION_ID = "unionid";
    public static final String PARAM_AGENCY_CODE = "agencyCode";

    public static final String MESSAGE_ACCESS_TOKEN= "用户授权码或者access_token有误.";
    public static final String MESSAGE_ACCESS_CODE= "用户授权的持久授权码或者access_token有误.";
    public static final String MESSAGE_SNS_TOKEN= "用户授权的SNS_TOKEN有误.";
    public static final String MESSAGE_EMPLOYEE_NOT = "员工不存在或被禁用,请联系管理员.";
    public static final String MESSAGE_DING_TALK_NOT = "钉钉账号已绑定,请直接登录.";
    public static final String MESSAGE_EMPLOYEE_BIND = "员工账号已绑定.";

    public static final String MESSAGE_SUPER = "无权限";
}