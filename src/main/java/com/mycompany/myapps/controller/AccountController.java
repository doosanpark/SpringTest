package com.mycompany.myapps.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.mycompany.myapps.model.AccountInfo;
import com.mycompany.myapps.model.LogInHistory;
import com.mycompany.myapps.service.AccountService;

@Controller
public class AccountController {

	@Autowired
	AccountService accountService;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String logIn() {
		return "account/login";
	}
	

	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(Model param) {
		
		return "test";
	}

	
	@RequestMapping(value = "/get/test/data", method = RequestMethod.POST)
	public @ResponseBody String test(@RequestBody HashMap paramMap) {	
		System.out.println("/get/test/data: " );
		System.out.println("map:"+paramMap.toString() );
		List<AccountInfo> list = accountService.getAccountList();
		System.out.println("list: "+ list );
		Gson gson = new Gson();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		HashMap<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("contents", list);
		HashMap<String, Object> pageMap = new HashMap<String, Object>();
		pageMap.put("page", paramMap.get("page"));
		pageMap.put("totalCount", 10);
		dataMap.put("pagination", pageMap);
		map.put("data", dataMap);
		System.out.println("map===="+gson.toJson(map));
		return gson.toJson(map);
	}
	
	// 회원가입 화면
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signUp() {
		return "account/signup";
	}

	// 회원 등록
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String createAccount(AccountInfo info) {

		String emailPattern ="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-z]{2,6}";
		Matcher emailMatcher = Pattern.compile(emailPattern).matcher(info.getEmail());
		boolean emailMat = emailMatcher.matches();
		
		String pwPattern = "^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[a-z])(?=.*[A-Z]).{9,12}$";
		Matcher pwMatcher = Pattern.compile(pwPattern).matcher(info.getPassword());
		boolean pwMat = pwMatcher.matches();

		int cnt = 0;
		
		if (info != null) {
			// Email 데이터 받기
			String email = info.getEmail();
			cnt = accountService.checkEmail(email);
		}

		if (cnt > 0) {
			// 이메일 중복이면 'd'uplicated invalid
			return "d";
		}
		
		if(!emailMat) {
			// email 형식이 안맞으면 'e'mail invalid
			return "e";
		}
		
		if (!pwMat) {
			// 비밀번호 형식이 안맞으면 'p'assword invalid
			return "p";
		}

		if (info != null) {
			// 회원 등록
			cnt = accountService.createAccount(info);
		}

		if (cnt > 0) {
			// 회원가입 성공 's'uccess
			return "s";
		} else {
			// 회원가입 실패 'f'ail
			return "f";
		}

	}

	// log in 이벤트
	@ResponseBody
	@RequestMapping(value = "/access", method = RequestMethod.POST)
	public String logging(AccountInfo info) {

		AccountInfo accountInfo = accountService.logIn(info);

		// 로그인 성공 여부 판단
		String loggedIn = "fail";

		LogInHistory history = new LogInHistory();

		if (accountInfo != null) {
			loggedIn = "success";
			history.setEmail(info.getEmail());
			history.setAccess('y');
			accountService.createLogInHistory(history);
		} else {
			history.setEmail(info.getEmail());
			history.setAccess('n');
			accountService.createLogInHistory(history);
		}

		return loggedIn;
	}
}
