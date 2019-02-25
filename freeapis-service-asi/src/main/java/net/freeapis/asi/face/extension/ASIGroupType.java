package net.freeapis.asi.face.extension;

/**
 * Created by Administrator on 2016/11/25.
 */
public enum ASIGroupType {
    SAMPLEBANNER("SAMPLEBANNER"),
    BANNER("BANNER"),
    HOT("HOT"),
    TOPIC("TOPIC"),
    UZAOC("UZAOC"),
    FRMB("FRMB"),
    FAQ("FAQ"),
    ADPLACELIST("ADPLACELIST");

    private String typeName;

    public String getTypeName() {
        return typeName;
    }

    ASIGroupType(String typeName){
        this.typeName = typeName;
    }

    public static ASIGroupType getASIGroupType(String typeName){
        ASIGroupType asiGroupType = null;
        for (ASIGroupType agt: ASIGroupType.values()) {
            if (agt.name().equals(typeName)){
                asiGroupType = agt;
                break;
            }
        }
        return asiGroupType;
    }

}
