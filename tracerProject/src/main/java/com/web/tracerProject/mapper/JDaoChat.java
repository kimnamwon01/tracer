package com.web.tracerProject.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.web.tracerProject.vo.Chatting;

import java.util.List;

@Mapper
public interface JDaoChat {
    @Insert("INSERT INTO CHATTING (CHID, EMAIL, SENT_DATE, CONTENT, NICKNAME) VALUES (#{chid}, #{email}, #{sent_date}, #{content}, #{nickname})")
    void saveChatMessage(Chatting chatMessage);

    @Select("SELECT * FROM CHATTING ORDER BY SENT_DATE ASC")
    List<Chatting> getAllChatMessages();

    @Select("SELECT COUNT(*) FROM USER_INFO WHERE NICKNAME = #{nickname}")
    int countUserByNickname(@Param("nickname") String nickname);
}


