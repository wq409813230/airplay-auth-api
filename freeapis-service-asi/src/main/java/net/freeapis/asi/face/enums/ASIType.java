package net.freeapis.asi.face.enums;

/**
 * &lt;pre&gt;
 * <p/>
 * freeapis
 * File: ASITypes
 * PROJECT: build-generator
 * <p/>
 * freeapis, Inc.
 * Copyright (C): 2015
 * <p/>
 * Description:
 * ${todo}
 * <p/>
 * Notes:
 * $$Id: ASITypes 31101200-9 2014-10-14 16:43:51Z freeapis\ Tony.Li $$
 * <p/>
 * Revision History
 * &amp;lt;Date&amp;gt;,			&amp;lt;Who&amp;gt;,			&amp;lt;What&amp;gt;
 * 2015/11/10		Tony.Li		Initial.
 * <p/>
 * &lt;/pre&gt;
 */
public enum ASIType {

    TABLE(0),
    FORM(1);
    private int value;

    /**
     *
     * @param type
     */
    ASIType(int type)
    {
        this.value = type;
    }

    /**
     *
     * @return
     */
    public int getValue()
    {
        return value;
    }

    /**
     * toString
     *
     * @return String
     */
    public String toString()
    {
        String aSITypes;
        switch (this)
        {
            case FORM:
                aSITypes = "表单";
                break;
            case TABLE:
                aSITypes = "表格";
                break;
            default:
                aSITypes = "";
        }

        return aSITypes;
    }

    public static ASIType getASIType(String str)
    {
    	ASIType asiTypes = null;
        for (ASIType ut : ASIType.values())
        {
            if (ut.name().equals( str))
            {
                asiTypes = ut;
                break;
            }
        }
        return asiTypes;
    }

    public String getProcessorName()
    {
        String name;
        switch (this)
        {
            case FORM:
                name = "form";
                break;
            case TABLE:
                name = "table";
                break;
            default:
                name = "";
        }
        return name;
    }
}
