package com.web.tracerProject.controller;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.LocaleResolver;

import com.web.tracerProject.service.JSerMain;
import com.web.tracerProject.vo.User_info;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class JContMain extends NContBase {
	
	@Autowired
	private JSerMain service;
	
    @Autowired
    private HttpSession session;
    
    @Autowired
    private LocaleResolver localeResolver;
    
    @PostMapping("/login")
    public String login(Model d, User_info user_info, HttpServletRequest request, HttpServletResponse response) {
        String loginResult = service.isMember(user_info);
        
        if ("로그인성공".equals(loginResult)) {
            User_info loggedInUser = service.getMember(user_info);
            session.setAttribute("info", loggedInUser);
            session.setAttribute("userNickname", loggedInUser.getNickname()); // 닉네임 세션에 저장
            session.setAttribute("userEmail", loggedInUser.getEmail()); // 이메일 세션에 저장
            d.addAttribute("user_info", loggedInUser);

            // 로그인 시 로케일 설정
            localeResolver.setLocale(request, response, Locale.KOREAN);
            
            if ("admin".equals(loggedInUser.getAuth())) { // 관리자 권한
                return "redirect:/indexM";
            } else { // 일반 사용자 권한
                return "redirect:/indexU";
            }
        } else {
            d.addAttribute("loginFailed", 1);
            return "tracerPages/login";
        }
    }

    @GetMapping("memberLogout")
    public String memberLogout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login"; // 로그인 페이지로 리디렉션
    }
}
