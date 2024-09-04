package com.web.tracerProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.web.tracerProject.service.NSerNewTeam;
import com.web.tracerProject.vo.Team;

@Controller
public class NContNewTeam extends NContBase{
	@Autowired(required=false)
	private NSerNewTeam service;
	
	@GetMapping("newTeam")
	public String newPrj() {
		return "tracerPages/newTeam";
	}
	@PostMapping("insertTeam")
    public ResponseEntity<String> insertProject(Team team) {
    	return ResponseEntity.ok(service.insertTeam(team));
    }
}
