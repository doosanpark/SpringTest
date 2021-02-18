package com.mycompany.myapps.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mycompany.myapps.dao.AccountDao;
import com.mycompany.myapps.model.AccountInfo;

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
	public AccountInfo logIn(String email, String password) {
		
		return sqlSession.selectOne("logIn", email);
	}

	@Override
	public int checkEmail(String email) {
		int cnt = sqlSession.selectOne("checkEmail", email);
		return cnt;
	}

	@Override
	public int createAccount(AccountInfo info) {
		// TODO Auto-generated method stub
		System.out.println("등록"+info);
		return sqlSession.insert("createAccount", info);
	}
}
