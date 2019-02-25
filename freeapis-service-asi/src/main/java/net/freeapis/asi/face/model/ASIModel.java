package net.freeapis.asi.face.model;

import lombok.Data;

import java.io.Serializable;

/**
 * freeapis,Inc.
 * Copyright(C): 2016
 *
 * <p>请描述这个类的作用,以及必要的示例
 *
 * @author Administrator
 * @date 2018年11月01日 18:28
 */
@Data
public class ASIModel implements Serializable {
    protected String sequenceNBR;
    private String createUserId;
    private String createUserName;
    private String createDate;
    protected String recUserId;
    protected String recUserName;
    protected String recDate;
    protected String recStatus;
}