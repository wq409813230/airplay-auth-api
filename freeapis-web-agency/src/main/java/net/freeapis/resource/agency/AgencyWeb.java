package net.freeapis.resource.agency;

import net.freeapis.core.config.EnableRestAPI;
import net.freeapis.core.config.MysqlConfig;
import net.freeapis.core.config.RedisConfig;
import net.freeapis.core.config.commoncfg.GlobalConfig;
import net.freeapis.common.sso.SsoConfig;
import org.springframework.boot.SpringApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Import;

/**
 * freeapis, Inc.
 * Copyright (C): 2016
 * <p>
 * Description:安全认证模块应用入口
 * <p>
 * @author Administrator
 * @date 2017年12月27日 13:27
 */
@Import({
        GlobalConfig.class,
        MysqlConfig.class,
        RedisConfig.class,
        SsoConfig.class
})
@EnableRestAPI
@ComponentScan({
        "net.freeapis.systemctl",
        "net.freeapis.security",
        "net.freeapis.agency"
})
public class AgencyWeb {

    public static void main(String[] args) throws Exception {
        SpringApplication.run(AgencyWeb.class, args);
    }
}
