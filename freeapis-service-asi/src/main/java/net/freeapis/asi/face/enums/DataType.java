package net.freeapis.asi.face.enums;

/**
 * &lt;pre&gt;
 * <p/>
 * Lexing File: DataTypes PROJECT: build-generator
 * <p/>
 * Lexing, Inc. Copyright (C): 2015
 * <p/>
 * Description: ${todo}
 * <p/>
 * Notes: $$Id: DataTypes 31101200-9 2014-10-14 16:43:51Z Lexing\ Tony.Li $$
 * <p/>
 * Revision History &amp;lt;Date&amp;gt;, &amp;lt;Who&amp;gt;,
 * &amp;lt;What&amp;gt; 2015/11/10 Tony.Li Initial.
 * <p/>
 * &lt;/pre&gt;
 */
public enum DataType {

    String(0, true, "字符串(100字以内)"),
    Integer(1, true, "整数"),
    Decimal(2, true, "小数"),
    Datetime(3, true, "日期时间"),
    Money(4, true, "金额"),
    Richtext(5, false, "富文本"),
    Link(6, true, "超链接"),
    Textarea(7, true, "文本(1000字以内)"),
    Select(8, false, "下拉框"),
    Radio(9, false, "单选框"),
    Checkbox(10, false, "复选框"),
    Keyvalue(11, true, "自定义键值属性"),
    ImageLink(12, false, "图片超链接"),
    Enumeration(13,false,"枚举");

    private int value;
    private boolean needValidate;
    private String description;

    DataType(int type, boolean needValidate, String description) {
        this.value = type;
        this.needValidate = needValidate;
        this.description = description;
    }

    public int getValue() {
        return this.value;
    }

    public String description() {
        return this.description;
    }

    public boolean isNeedValidate() {
        return needValidate;
    }

    public static DataType getDataType(String name) {
        DataType result = null;
        for (DataType dataType : DataType.values()) {
            if (dataType.name().equals(name)) {
                result = dataType;
                break;
            }
        }
        return result;
    }
}