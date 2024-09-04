package com.web.tracerProject.service;

import java.util.regex.Pattern;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.NDaoMem;
import com.web.tracerProject.vo.User_info;

@Service
public class NSerMem {
	@Autowired(required=false)
	private NDaoMem dao;
	
	
	// mem 회원가입
	public String insMember(User_info user_info) {
		if(!isRightEmail(user_info.getEmail()))
			return "이메일 형식이 맞지 않습니다 ex) example12@example.com";
		if(!isRightPwd(user_info.getPassword()))
			return "비밀번호는 8~20글자, 영어 대소문자, 숫자, 특수문자가 필수로 포함되어야 합니다.";
		return dao.insMember(user_info)>0?"회원가입성공":"회원가입실패";
	}
	// mem 권한 확인
	public String chkAuth(String password, String email) {
		return dao.chkAuth(password, email)>0?"권한인정성공":"권한인정실패";
	}
	// mem 이메일 중복 검사
	public String emailDupChk(String email) {
		return dao.emailDupChk(email)>0?"이미 가입된 이메일입니다":"잠시만 기다려주세요.";
	}
		
	// mem 비밀번호변경
	public String chgPwd(String password, String email) {
		if(!isRightPwd(password))
			return "비밀번호는 8~20글자, 영어 대소문자, 숫자, 특수문자가 필수로 포함되어야 합니다.";
		return dao.chgPwd(password, email)>0?"비밀번호변경성공":"비밀번호변경실패";
	}
	// mem 유효성검사
	public boolean isRightPwd(@Param("password") String password) {
		String pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).{8,20}$";
		return Pattern.matches(pattern, password);
	}
	public boolean isRightEmail(@Param("email") String email) {
		String pattern = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
		return Pattern.matches(pattern, email);
	}
	
	// 세션 처리
	
	
	
}
