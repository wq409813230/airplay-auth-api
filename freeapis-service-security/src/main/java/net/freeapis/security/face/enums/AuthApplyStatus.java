package net.freeapis.security.face.enums;

/**
 * Created by Administrator on 2016/11/1.
 * 安全认证审核状态
 */
public enum AuthApplyStatus {
    /**
     * 验证通过
     */
    APPROVED,
    /**
     * 验证拒绝
     */
    UNAPPROVED,
    /**
     * 审核中
     */
    APPROVING;

    public String toString(){
        String IDverification="";

        switch (this){
            case APPROVED:
                IDverification = "通过";
                break;
            case UNAPPROVED:
                IDverification = "拒绝";
                break;
            case APPROVING:
                IDverification = "审核中";
        }
        return IDverification;
    }
}
