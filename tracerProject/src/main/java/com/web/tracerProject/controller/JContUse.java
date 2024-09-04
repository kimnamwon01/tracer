package com.web.tracerProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.web.tracerProject.service.JSerMain;
import com.web.tracerProject.vo.Task;

@Controller
public class JContUse extends NContBase {

	@Autowired
	private JSerMain service;
	
    @GetMapping("/indexU")
    public String userIndex(Model d, Task task) {
        int todayDoCount = service.getTodayDo(task);
        d.addAttribute("todayDoCount", todayDoCount);
        
        int thisWeekDo = service.getWeekDo(task);
        d.addAttribute("thisWeekDo", thisWeekDo);
        
        d.addAttribute("dueto", service.getDueto(task));
        d.addAttribute("dDay", service.getDday(task));
        
        int myTaskProgress = service.getMyTaskProgress(task);
        d.addAttribute("myTaskProgress", myTaskProgress);

        return "tracerPages/indexU";
    }
}
