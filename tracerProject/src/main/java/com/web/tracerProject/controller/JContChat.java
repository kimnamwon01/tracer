package com.web.tracerProject.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import jakarta.servlet.http.HttpSession;
import java.util.Date;

@Controller
public class JContChat {

    @Value("${socketServer}")
    private String socketServer;

    @GetMapping("/chatting")
    public String chatting(Model d, HttpSession session) {
        // 세션에서 이메일과 닉네임 가져오기
        String userEmail = (String) session.getAttribute("userEmail");
        String userNickname = (String) session.getAttribute("userNickname");
        if (userNickname == null || userNickname.isEmpty()) {
            // 세션에 닉네임이 없으면 기본값 설정
            userNickname = "Guest" + new Date().getTime();
        }
        session.setAttribute("nickname", userNickname); // WebSocket 세션에 닉네임 설정
        d.addAttribute("userEmail", userEmail);
        d.addAttribute("userNickname", userNickname);
        d.addAttribute("socketServer", socketServer);

        // 현재 날짜 추가
        d.addAttribute("currentDate", new Date());
        return "tracerPages/chatting";
    }
    
}

