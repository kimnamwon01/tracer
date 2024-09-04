package com.web.tracerProject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.JDaoChat;
import com.web.tracerProject.vo.Chatting;

@Service
public class JSerChat {

    @Autowired
    private JDaoChat dao;

    public void saveChatMessage(Chatting chatMessage) throws Exception {
        // 닉네임 유효성 검사
        if (dao.countUserByNickname(chatMessage.getNickname()) == 0) {
            chatMessage.setNickname("GUEST");
        }
        dao.saveChatMessage(chatMessage);
    }

    public List<Chatting> getAllChatMessages() {
        return dao.getAllChatMessages();
    }
}


