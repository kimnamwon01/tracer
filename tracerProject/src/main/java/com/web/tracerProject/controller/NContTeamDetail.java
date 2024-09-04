package com.web.tracerProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.tracerProject.service.NSerTeamDetail;
import com.web.tracerProject.vo.Team;
import com.web.tracerProject.vo.User_info;

@Controller
public class NContTeamDetail extends NContBase{
	@Autowired(required=false)
	private NSerTeamDetail service;
	
	@GetMapping("teamDetail")
	public String prjDetail(@RequestParam("tid") String tid, Model d) {
		d.addAttribute("selTeam", service.selTeam(tid));
		return "tracerPages/teamDetail";
	}
	@GetMapping("teamInfo")
	public String teamInfo(@RequestParam("tid") String tid, Model d) {
		d.addAttribute("selTeam", service.selTeam(tid));
		return "tracerPages/teamInfo";
	}
	@PostMapping("uptDetailTeam")
    public ResponseEntity<String> uptDetailTeam(Team team) {
    	return ResponseEntity.ok(service.uptTeam(team));
    }
    @PostMapping("delDetailTeam")
    public ResponseEntity<String> delDetailTeam(@RequestParam("tid") String tid) {
    	return ResponseEntity.ok(service.delTeam(tid));
    }
    @PostMapping("getCanWorkTeam")
    public ResponseEntity<List<User_info>> getCanWorkTeam(@RequestParam("nickname") String nickname
    														,@RequestParam("pid") String pid) {
    	return ResponseEntity.ok(service.getCanWorkTeam(nickname, pid));
    }
    @PostMapping("getParticipantsTeam")
    public ResponseEntity<List<User_info>> getParticipantsTeam(@RequestParam("tid") String tid) {
    	return ResponseEntity.ok(service.getParticipantsTeam(tid));
    }
    @PostMapping("insUserTid")
    public ResponseEntity<String> insUserTid(@RequestParam("tid") String tid,
    											@RequestParam("email") String email) {
    	return ResponseEntity.ok(service.insUserTid(tid, email));
    }
    @PostMapping("delUserTid")
    public ResponseEntity<String> delUserTid(@RequestParam("email") String email) {
    	return ResponseEntity.ok(service.delUserTid(email));
    }
}
