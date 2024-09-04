package com.web.tracerProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.JDaoProfile;
import com.web.tracerProject.vo.User_info;

@Service
public class JSerProfile {
    @Autowired(required=false)
    private JDaoProfile dao;

    public String updateUserNickname(User_info user_info) {
        int nicknameCount = dao.checkNicknameDuplication(user_info.getNickname());
        if (nicknameCount > 0) {
            return "이미 사용 중인 닉네임입니다.";
        }

        int result = dao.updateUserNickname(user_info);
        if (result > 0) {
            return "닉네임 변경 성공";
        } else {
            return "닉네임 변경 실패";
        }
    }

    public String updatePhone(User_info userInfo) {
        try {
            int rowsUpdated = dao.updatePhone(userInfo);
            if (rowsUpdated > 0) {
                return "전화번호 변경 성공";
            } else {
                return "전화번호 변경 실패";
            }
        } catch (Exception e) {
            return "전화번호 변경 실패";
        }
    }

    public String deleteAccount(User_info userInfo) {
        int rowsAffected = dao.deleteAccount(userInfo.getEmail());
        if (rowsAffected > 0) {
            return "회원 탈퇴 성공";
        } else {
            return "회원 탈퇴 실패";
        }
    }
}
