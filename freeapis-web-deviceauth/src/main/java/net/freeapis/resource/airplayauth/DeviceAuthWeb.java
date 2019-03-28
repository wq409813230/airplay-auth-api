package net.freeapis.resource.airplayauth;

import net.freeapis.common.sso.SsoConfig;
import net.freeapis.core.config.EnableRestAPI;
import net.freeapis.core.config.MysqlConfig;
import net.freeapis.core.config.RedisConfig;
import net.freeapis.core.config.commoncfg.ConcurrentConfig;
import net.freeapis.core.config.commoncfg.GlobalConfig;
import org.springframework.boot.SpringApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Import;

/**
 * freeapis, Inc.
 * Copyright (C): 2016
 * <p>
 * Description:平台控制模块应用入口
 * <p>
 * @author Administrator
 * @date 2017年12月27日 13:27
 */
@EnableRestAPI
@Import({
        GlobalConfig.class,
        ConcurrentConfig.class,
        MysqlConfig.class,
        RedisConfig.class,
        SsoConfig.class
})
@ComponentScan({
        "net.freeapis.systemctl",
        "net.freeapis.security",
        "net.freeapis.airplayauth",
        "net.freeapis.deviceauth"
})
public class DeviceAuthWeb {

    public static void main(String[] args) throws Exception {
        SpringApplication.run(DeviceAuthWeb.class, args);
    }
}
