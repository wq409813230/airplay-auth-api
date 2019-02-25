package net.freeapis.asi.face.enums;

/**
 * Created by Administrator on 2017/6/30.
 */
public enum Operator {
    EQ,LIKE,GTE,LT;

    public static Operator getInstance(String name){
        try {
            return Operator.valueOf(name.toUpperCase());
        }catch (Exception e){
            return null;
        }
    }
}
