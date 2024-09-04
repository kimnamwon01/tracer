package com.web.tracerProject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.NDaoUserMgmt;
import com.web.tracerProject.vo.User_info;

@Service
public class NSerUserMgmt {

    @Autowired
    private NDaoUserMgmt dao;

    public Page<User_info> getUser_info(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        int offset = page * size;
        List<User_info> users = dao.getUserInfo(offset, size);
        int total = dao.countAllUsers();  // Total records
        return new PageImpl<>(users, pageable, total);
    }

    public Page<User_info> schUserInfo(String nickname, 
    									String name, String auth, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        int offset = page * size;
        List<User_info> users = dao.schUserInfo(nickname, name, auth, offset, size);
        int total = dao.countUsers(nickname, name, auth);  // Total records matching search criteria
        return new PageImpl<>(users, pageable, total);
    }

    public Page<User_info> delUser(String nickname, String name, String auth, String email, int page, int size) {
        dao.delUser(email);
        return schUserInfo(nickname, name, auth, page, size);  // Refresh the list after deletion
    }

    public String uptUser(String auth, String email) {
        return dao.uptUser(auth, email) > 0 ? "권한 수정 성공" : "권한 수정 실패";
    }
}

