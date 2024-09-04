package com.web.tracerProject.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.web.tracerProject.vo.User_info;

@Mapper
public interface NDaoMem {
	// mem - 회원가입
	@Insert("INSERT INTO USER_INFO (EMAIL, PASSWORD, NICKNAME, NAME, BIRTH, PHONE)\r\n"
			+ "VALUES(#{email}, #{password}, "
			+ "#{nickname}, #{name}, #{birth}, #{phone})")
	int insMember(User_info user_info);
	// mem - 권한 확인
	@Select("SELECT count(*)\r\n"
			+ "FROM USER_INFO\r\n"
			+ "WHERE EMAIL = #{email}"
			+ "AND PASSWORD = #{password}"
			+ "AND AUTH NOT IN('noauth')"
			)
	int chkAuth(@Param("password") String password, 
			@Param("email") String email);
	// mem - 비밀번호변경 + 비밀번호초기화
	@Update("UPDATE USER_INFO\r\n"
			+ "SET PASSWORD = #{password}\r\n"
			+ "WHERE EMAIL = #{email}")
	int chgPwd(@Param("password") String password, 
			@Param("email") String email);
	
	// mem - 이메일 중복여부
	@Select("SELECT count(*)\r\n"
			+ "FROM USER_INFO\r\n"
			+ "WHERE EMAIL = #{email}")
	int emailDupChk(@Param("email") String email);
}