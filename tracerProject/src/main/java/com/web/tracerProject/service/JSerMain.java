package com.web.tracerProject.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.JDaoMain;
import com.web.tracerProject.vo.Task;
import com.web.tracerProject.vo.UserProgress;
import com.web.tracerProject.vo.User_info;

@Service
public class JSerMain {
    @Autowired(required = false)
    private JDaoMain dao;

    public String isMember(User_info user_info) {
        if (user_info.getEmail() == null)
            user_info.setEmail("");
        if (user_info.getPassword() == null)
            user_info.setPassword("");
        return dao.isMember(user_info) > 0 ? "로그인성공" : "로그인실패";
    }

    public User_info getMember(User_info user_info) {
        return dao.getMember(user_info);
    }

    public int getTodayDo(Task task) {
        return dao.getTodayDo(task);
    }

    public int getWeekDo(Task task) {
        return dao.getWeekDo(task);
    }

    public Date getDueto(Task task) {
        return dao.getDueto(task);
    }

    public String getDday(Task task) {
        return dao.getDday(task);
    }

    public int getRequestApprovalCount(Task task) {
        return dao.getRequestApprovalCount(task);
    }

    public List<UserProgress> getUserProgress() {
        return dao.getUserProgress();
    }

    public Integer getMyTaskProgress(Task task) {
        if (task.getEmail() == null) {
            task.setEmail("");
        }
        Integer progress = dao.getMyTaskProgress(task);
        return progress != null ? progress : 0;
    }



}
