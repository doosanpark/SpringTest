package com.mycompany.myapps.service;

import java.util.List;

import com.mycompany.myapps.model.AccountInfo;

public interface AccountService {
	public List<AccountInfo> getAccountList();
	public AccountInfo logIn(String email, String password);
	public int checkEmail(String email);
	public int createAccount(AccountInfo info);
}
