package com.web.tracerProject.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.tracerProject.service.NSerMail;

import lombok.AllArgsConstructor;
@Controller
@AllArgsConstructor
public class NContMail {
	 private final NSerMail mservice;
	 
	    @PostMapping("/mail/sendSingupSuccess")
	    public ResponseEntity<String> sendSingupSuccess(@RequestParam("email") String email
	    													, @RequestParam("nickname") String nickname) {
	        return ResponseEntity.ok(mservice.sendSingupSuccess(email, nickname));
	    }
	    @PostMapping("/mail/sendResetPwd")
	    public ResponseEntity<String> sendResetPwd(@RequestParam("email") String email) {
	    	return ResponseEntity.ok(mservice.sendResetPwd(email));
	    }
	    @PostMapping("/mail/sendEmailChk")
	    public ResponseEntity<String> sendEmailChk(@RequestParam("email") String email) {
	    	return ResponseEntity.ok(mservice.sendEmailChk(email));
	    }
}
