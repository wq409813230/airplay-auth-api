package net.freeapis.resource.systemctl;

import net.freeapis.core.config.*;
import net.freeapis.core.config.commoncfg.GlobalConfig;
import net.freeapis.common.sso.SsoConfig;
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
        MysqlConfig.class,
        RedisConfig.class,
        SsoConfig.class
})
@ComponentScan({
        "net.freeapis.systemctl",
        "net.freeapis.security"
})
public class SystemctlWeb {

    public static void main(String[] args) throws Exception {
        SpringApplication.run(SystemctlWeb.class, args);
    }
}
