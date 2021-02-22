package com.mycompany.myapps.dao;

import java.util.List;

import com.mycompany.myapps.model.AccountInfo;
import com.mycompany.myapps.model.LogInHistory;

public interface AccountDao {
	
	//모든 계정 리스트
	public List<AccountInfo> getAccountList();
	
	/* 회원가입 시 사용 */
	//이메일 중복 확인
	public int checkEmail(String email);
	//계정 생성
	public int createAccount(AccountInfo info);
	
	/* 로그인 시 사용 */
	//로그인 시도
	public AccountInfo logIn(AccountInfo info);
	//로그인 히스토리 생성
	public int createLogInHistory(LogInHistory history);
	
	/* 로그인 히스토리 */
	//전체 리스트 검색
	public List<LogInHistory> getLogInHistory();
	//조건부 리스트 검색	
	public List<LogInHistory> getSearchedHistory(LogInHistory history);
}
