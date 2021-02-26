package com.mycompany.myapps.model;

public class LogInHistory {
	String email;
	char access;
	
	String date;	//로그인 시도한 날짜

	String date1;	//날짜 검색 시 시작일
	String date2;	//날짜 검색 시 종료일

	public String getDate() {
		return date;
	}
	public String getDate1() {
		return date1;
	}
	public void setDate1(String date1) {
		this.date1 = date1;
	}
	public String getDate2() {
		return date2;
	}
	public void setDate2(String date2) {
		this.date2 = date2;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public char getAccess() {
		return access;
	}
	public void setAccess(char access) {
		this.access = access;
	}
	@Override
	public String toString() {
		return "LogInHistory [email=" + email + ", access=" + access + ", date=" + date + ", date1=" + date1
				+ ", date2=" + date2 + "]";
	}
	
	 
	
}
