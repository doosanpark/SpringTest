package com.mycompany.myapps.model;

import java.util.Date;

public class AccountInfo {
	String email;
	String password;
	String phone;
	Date regDate;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Override
	public String toString() {
		return "AccountInfo [email=" + email + ", password=" + password + ", phone=" + phone + ", regDate=" + regDate
				+ "]";
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
}
