package com.web.tracerProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.web.tracerProject.service.JSerMain;
import com.web.tracerProject.vo.User_info;

import jakarta.servlet.http.HttpSession;

public abstract class NContBase {
	@Autowired(required = false)
	    private JSerMain service;
	 
	@Value("${server.servlet.session.timeout}")
	private int sessionTimeout;
	
	@ModelAttribute
	public void addAttributes(Model d, HttpSession session) {
		User_info user_info = (User_info)session.getAttribute("info");
			
		if(user_info != null) {
			session.setAttribute("user_info", service.getMember(user_info));
			Object newUserSession = session.getAttribute("user_info");
			d.addAttribute("user_info", newUserSession);
		}
		
		session.setMaxInactiveInterval(sessionTimeout);
	}
}
