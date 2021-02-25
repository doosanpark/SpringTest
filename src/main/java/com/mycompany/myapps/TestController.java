package com.mycompany.myapps;

import java.util.HashMap;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TestController {

	@RequestMapping(value="/test")
	public String test(Locale locale, Model model) {
		return "test";
	}
	
	@ResponseBody
	@RequestMapping(value="test/req")
	public HashMap<String, String> responseTest() {
		
		String json = "{color: red, money: 10000}";
		HashMap<String, String> obj = new HashMap<String, String>();
		obj.put("data", json);
		
		return obj;
	}
}
