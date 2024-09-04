package com.web.tracerProject.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.web.tracerProject.mapper.JDaoUser;
import com.web.tracerProject.vo.User_info;

@Service
public class JSerUser {
    @Autowired(required = false)
    private JDaoUser dao;
    
    public List<User_info> getAllUsers() {
        return dao.findAllUsers();
    }
    
    public User_info getUserById(String email) {
        return dao.findUserById(email);
    }
    
    public void createUser(User_info user) {
        dao.insertUser(user);
    }
    
    public void updateUser(User_info user) {
        dao.updateUser(user);
    }
    
    public void deleteUser(String email) {
        dao.deleteUser(email);
    }
}
