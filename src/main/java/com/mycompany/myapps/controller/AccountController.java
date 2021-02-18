package com.mycompany.myapps.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.myapps.model.AccountInfo;
import com.mycompany.myapps.service.AccountService;

@Controller
public class AccountController {

	@Autowired
	AccountService accountService;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String logIn() {

		return "account/login";
	}

	// log in 이벤트
	@ResponseBody
	@RequestMapping(value = "/access", method = RequestMethod.POST)
	public String logging(AccountInfo info) {

		String email = info.getEmail();
		String password = info.getPassword();

		AccountInfo accountInfo = accountService.logIn(email, password);

		if (accountInfo != null) {
			return "success";
		} else {
			return "fail";
		}
	}

	// 회원가입 화면
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signUp() {
		return "account/signup";
	}

	// 이메일 중복 확인
	@ResponseBody
	@RequestMapping(value = "/idcheck", method = RequestMethod.POST)
	public String idCheck(AccountInfo info) {

		int cnt = 0;
		if (info != null) {
			// Email 데이터 받기
			String email = info.getEmail();
			cnt = accountService.checkEmail(email);
		}

		if (cnt > 0) {
			return "f";
		} else {
			return "t";
		}
	}

	// 회원 등록
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String createAccount(AccountInfo info) {

		System.out.println("GET info : " + info);
		int cnt = 0;
		if (info != null) {
			// Email 데이터 받기
			cnt = accountService.createAccount(info);
		}

		
		if (cnt > 0) {
			return "s";
		} else {
			return "f";
		}
		
		
	}

}
