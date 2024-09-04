package com.web.tracerProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.tracerProject.service.NSerTeam;
import com.web.tracerProject.vo.Team;

@Controller
public class NContTeam extends NContBase{
	@Autowired(required=false)
	private NSerTeam service;
	
    // 프로젝트 조회
    
    @GetMapping("teamList")
    public String teamList(@RequestParam("pid") String pid, Model d) {
    	d.addAttribute("teams", service.getTeam(pid));
    	return "tracerPages/teamList";
    }
    @PostMapping("teamList")
    public ResponseEntity<List<Team>> schTeamList(@RequestParam("name") String name,
    												@RequestParam("pid") String pid) {
    	return ResponseEntity.ok(service.schTeam(name, pid));
    }
    @PostMapping("delTeam")
    public ResponseEntity<List<Team>> delTeam(@RequestParam("tid") String tid ,
    										@RequestParam("pid") String pid) {
    	return ResponseEntity.ok(service.delTeam(tid, pid));
    }
}
