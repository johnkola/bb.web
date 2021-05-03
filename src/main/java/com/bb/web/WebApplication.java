package com.bb.web;

import lombok.extern.log4j.Log4j2;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@Log4j2
@SpringBootApplication
public class WebApplication {

	public static void main(String[] args) {
		log.info("main is called");
		SpringApplication.run(WebApplication.class, args);
	}

}
