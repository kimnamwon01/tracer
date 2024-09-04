package com.web.tracerProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.tracerProject.service.JSerProfile;
import com.web.tracerProject.vo.User_info;

import jakarta.servlet.http.HttpSession;

@Controller
public class JConProfile {
    @Autowired(required=false)
    private JSerProfile service;
    @Autowired(required=false)
    private HttpSession session;

    @PostMapping("/updateNickname")
    @ResponseBody
    public String updateNickname(@RequestParam("nickname") String nickname) {
        User_info userInfo = (User_info) session.getAttribute("info");
        if (userInfo == null) {
            return "로그인이 필요합니다.";
        }

        userInfo.setNickname(nickname);
        String result = service.updateUserNickname(userInfo);
        if ("닉네임 변경 성공".equals(result)) {
            session.invalidate(); // 세션 무효화
            return "닉네임 변경 성공: 로그아웃 필요";
        }
        return result;
    }


    @PostMapping("/updatePhone")
    @ResponseBody
    public String updatePhone(@RequestParam("phone") String phone) {
        User_info userInfo = (User_info) session.getAttribute("info");
        if (userInfo == null) {
            return "로그인이 필요합니다.";
        }

        userInfo.setPhone(phone);
        String result = service.updatePhone(userInfo);
        if ("전화번호 변경 성공".equals(result)) {
            session.setAttribute("info", userInfo); // 세션 업데이트
        }
        return result;
    }

    @PostMapping("/deleteAccount")
    @ResponseBody
    public String deleteAccount() {
        User_info userInfo = (User_info) session.getAttribute("info");
        if (userInfo == null) {
            return "로그인이 필요합니다.";
        }

        String result = service.deleteAccount(userInfo);
        if ("회원 탈퇴 성공".equals(result)) {
            session.invalidate(); // 세션 무효화
        }
        return result;
    }
}
