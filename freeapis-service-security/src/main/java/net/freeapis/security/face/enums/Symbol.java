package net.freeapis.security.face.enums;

/**
 * freeapis,Inc.
 * Copyright(C): 2016
 *
 * <p>请描述这个类的作用,以及必要的示例
 *
 * @author Administrator
 * @date 2018年11月26日 18:07
 */
public enum Symbol{

    eq(" = "," 等于 "),
    neq(" != "," 不等于 "),
    gt(" > "," 大于 "),
    gte(" >= "," 大于等于 "),
    lt(" < "," 小于 "),
    lte(" <= "," 小于等于 "),
    like(" LIKE "," 包含 ");

    private String value;
    private String label;
    Symbol(String value,String label){
        this.value = value;
        this.label = label;
    }

    public static Symbol getSymbol(String name){
        for(Symbol symbol : Symbol.values()){
            if(symbol.name().equalsIgnoreCase(name)){
                return symbol;
            }
        }
        return null;
    }

    public String label(){
        return this.label;
    }

    public String value(){
        return this.value;
    }
}
