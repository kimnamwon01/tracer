package com.web.tracerProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.tracerProject.service.NSerPrj;
import com.web.tracerProject.vo.Project;

@Controller
public class NContPrj extends NContBase{
	@Autowired(required=false)
	private NSerPrj service;
	
    // 프로젝트 조회
    
    @GetMapping("prjList")
    public String prjList(Project project, Model d) {
    	d.addAttribute("prjs", service.getProject());
    	return "tracerPages/prjList";
    }
    @PostMapping("prjList")
    public ResponseEntity<List<Project>> schPrjList(@RequestParam("prjTitle") String prjTitle) {
    	return ResponseEntity.ok(service.schProject(prjTitle));
    }
    @PostMapping("delPrj")
    public ResponseEntity<List<Project>> delPrj(@RequestParam("pid") String pid) {
    	return ResponseEntity.ok(service.delPrj(pid));
    }
}
