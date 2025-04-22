package com.healthCareFoodRecommendation.configuration;

import java.util.Properties;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;

@Configuration
@ComponentScan(basePackages = "com.healthCareFoodRecommendation.Model,com.healthCareFoodRecommendation.DAOImplement")
public class AppConfiguration {

    @Bean
    public LocalSessionFactoryBean sf() {
        LocalSessionFactoryBean sessionFactory = new LocalSessionFactoryBean();
        sessionFactory.setDataSource(dataSource()); // Set the data source for database connection
        sessionFactory.setPackagesToScan("com.healthCareFoodRecommendation.Model");
        sessionFactory.setHibernateProperties(hibernateProperties());
        return sessionFactory;
    }

    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://localhost:3306/healthcaremanagement");
        dataSource.setUsername("root");
        dataSource.setPassword("Brindha@1200");
        return dataSource;
    }

    private Properties hibernateProperties() {
        Properties properties = new Properties();
        properties.put("hibernate.dialect", "org.hibernate.dialect.MySQLDialect");
        properties.put("hibernate.show_sql", "true"); // fro Show the querys.
        properties.put("hibernate.hbm2ddl.auto", "update");
        return properties;
    }
}
