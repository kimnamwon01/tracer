package com.web.tracerProject.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.web.tracerProject.vo.User_info;

@Mapper
public interface JDaoProfile {
	
	// 닉네임 변경
	@Update("UPDATE USER_INFO SET nickname=#{nickname} WHERE email=#{email}")
	int updateUserNickname(User_info user_info);
	
	// 닉네임 중복 확인
    @Select("SELECT COUNT(*) FROM USER_INFO WHERE nickname=#{nickname}")
    int checkNicknameDuplication(String nickname);
	
	// 전화번호 변경
	@Update("UPDATE USER_INFO SET phone=#{phone} WHERE email=#{email}")
	int updatePhone(User_info user_info);
	
	// 회원탈퇴
	@Delete("DELETE USER_INFO WHERE email=#{email}")
	int deleteAccount(String email);
}
