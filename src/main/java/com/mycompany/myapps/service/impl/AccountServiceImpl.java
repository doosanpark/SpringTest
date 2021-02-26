package com.mycompany.myapps.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mycompany.myapps.dao.AccountDao;
import com.mycompany.myapps.model.AccountInfo;
import com.mycompany.myapps.model.LogInHistory;
import com.mycompany.myapps.service.AccountService;

@Service("accountService")
public class AccountServiceImpl implements AccountService{
	@Resource(name="accountDao")
	private AccountDao accountDao;

	@Override
	public List<AccountInfo> getAccountList() {
		return accountDao.getAccountList();
	}

	@Override
	public AccountInfo logIn(AccountInfo info) {
		// TODO Auto-generated method stub
		return accountDao.logIn(info);
	}

	@Override
	public int checkEmail(String email) {
		// TODO Auto-generated method stub
		return accountDao.checkEmail(email);
	}

	@Override
	public int createAccount(AccountInfo info) {
		// TODO Auto-generated method stub
		return accountDao.createAccount(info);
	}

	@Override
	public int createLogInHistory(LogInHistory history) {
		// TODO Auto-generated method stub
		return accountDao.createLogInHistory(history);
	}
	
	@Override
	public List<LogInHistory> getLogInHistory(){
		return accountDao.getLogInHistory();
	}
	
	@Override
	public List<LogInHistory> getPeriodHistory(LogInHistory history) {
		// TODO Auto-generated method stub
		return accountDao.getPeriodHistory(history);
	}

	@Override
	public List<LogInHistory> getSearchedHistory(LogInHistory history) {
		// TODO Auto-generated method stub
		
		return accountDao.getSearchedHistory(history);
	}

}
