package com.mycompany.myapps.controller;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
