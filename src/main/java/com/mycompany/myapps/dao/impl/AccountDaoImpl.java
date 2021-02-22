package com.mycompany.myapps.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mycompany.myapps.dao.AccountDao;
import com.mycompany.myapps.model.AccountInfo;
import com.mycompany.myapps.model.LogInHistory;

@Repository("accountDao")
public class AccountDaoImpl implements AccountDao {
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<AccountInfo> getAccountList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("getAccountList");
	}

	@Override
	public AccountInfo logIn(AccountInfo info) {
		
		return sqlSession.selectOne("logIn", info);
	}

	@Override
	public int checkEmail(String email) {
		int cnt = sqlSession.selectOne("checkEmail", email);
		return cnt;
	}

	@Override
	public int createAccount(AccountInfo info) {
		// TODO Auto-generated method stub
		//System.out.println("등록"+info);
		return sqlSession.insert("createAccount", info);
	}

	@Override
	public int createLogInHistory(LogInHistory history) {
		// TODO Auto-generated method stub
		return sqlSession.insert("createLogInHistory", history);
	}

	@Override
	public List<LogInHistory> getLogInHistory() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("getLogInHistory");
	}

	@Override
	public List<LogInHistory> getSearchedHistory(LogInHistory history) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("getSearchedHistory", history);
	}

	

}