package com.mycompany.myapps.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mycompany.myapps.dao.AccountDao;
import com.mycompany.myapps.model.AccountInfo;
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
	public AccountInfo logIn(String email, String password) {
		// TODO Auto-generated method stub
		return accountDao.logIn(email, password);
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
	
	

}
