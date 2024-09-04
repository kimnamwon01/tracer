package com.web.tracerProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.tracerProject.service.NSerPrjDetail;
import com.web.tracerProject.vo.Project;
import com.web.tracerProject.vo.User_info;

@Controller
public class NContPrjDetail extends NContBase{
	@Autowired(required=false)
	private NSerPrjDetail service;
	
	@GetMapping("prjDetail")
	public String prjDetail(@RequestParam("pid") String pid, Model d) {
		d.addAttribute("selPrj", service.selPrj(pid));
		return "tracerPages/prjDetail";
	}
	@GetMapping("prjInfo")
	public String prjInfo(@RequestParam("pid") String pid, Model d) {
		d.addAttribute("selPrj", service.selPrj(pid));
		return "tracerPages/prjInfo";
	}
	@PostMapping("uptDetailPrj")
    public ResponseEntity<String> uptDetailPrj(Project project) {
    	return ResponseEntity.ok(service.uptPrj(project));
    }
    @PostMapping("delDetailPrj")
    public ResponseEntity<String> delDetailPrj(@RequestParam("pid") String pid) {
    	return ResponseEntity.ok(service.delPrj(pid));
    }
    @PostMapping("getCanWork")
    public ResponseEntity<List<User_info>> getCanWork(@RequestParam("nickname") String nickname) {
    	return ResponseEntity.ok(service.getCanWork(nickname));
    }
    @PostMapping("getParticipants")
    public ResponseEntity<List<User_info>> getParticipants(@RequestParam("pid") String pid) {
    	return ResponseEntity.ok(service.getParticipants(pid));
    }
    @PostMapping("insUserPid")
    public ResponseEntity<String> insUserPid(@RequestParam("pid") String pid,
    											@RequestParam("email") String email) {
    	return ResponseEntity.ok(service.insUserPid(pid, email));
    }
    @PostMapping("delUserPid")
    public ResponseEntity<String> delUserPid(@RequestParam("email") String email) {
    	return ResponseEntity.ok(service.delUserPid(email));
    }
}
