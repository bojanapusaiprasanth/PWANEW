package com.example;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MyService {

	@RequestMapping("/pwa")
	public String hello()
	{
		return "This is PWA application";
	}
	
}
