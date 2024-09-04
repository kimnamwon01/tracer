package com.web.tracerProject.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.web.tracerProject.service.NSerNewPrj;
import com.web.tracerProject.vo.Project;

@Controller
public class NContNewPrj extends NContBase{
	@Autowired(required=false)
	private NSerNewPrj service;
	
	@GetMapping("newPrj")
	public String newPrj() {
		return "tracerPages/newPrj";
	}
	@PostMapping("insertProject")
    public ResponseEntity<String> insertProject(Project project) {
    	return ResponseEntity.ok(service.insertProject(project));
    }
}
