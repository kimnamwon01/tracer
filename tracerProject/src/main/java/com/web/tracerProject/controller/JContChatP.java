package com.web.tracerProject.controller;

import java.util.Date;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class JContChatP {

    @GetMapping("/private-chat")
    public String privateChat(Model model, HttpSession session) {
        String userEmail = (String) session.getAttribute("userEmail");
        String userNickname = (String) session.getAttribute("userNickname");
        session.setAttribute("nickname", userNickname); // WebSocket 세션에 닉네임 설정
        
        model.addAttribute("userEmail", userEmail);
        model.addAttribute("userNickname", userNickname);
        model.addAttribute("currentDate", new Date()); // 현재 날짜 추가
        
        return "tracerPages/privateChat";
    }		
	
    @MessageMapping("/hello")
    @SendTo("/topic/greetings")
    public String greeting(String message) {
        System.out.println("# 메시지 전송 #"+message);
        return message;
    }
}
