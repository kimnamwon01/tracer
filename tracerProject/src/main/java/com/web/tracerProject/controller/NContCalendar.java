package com.web.tracerProject.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.tracerProject.service.NSerCalendar;
import com.web.tracerProject.service.NSerPrj;
import com.web.tracerProject.vo.Calendar;
import com.web.tracerProject.vo.Project;

@Controller
public class NContCalendar extends NContBase{
	@Autowired(required=false)
	NSerCalendar service;
	@Autowired(required=false)
	NSerPrj getPrj;
	
	// http://localhost:5656/calendar
	@GetMapping("calendar")
	public String calendar(Model d) {
		d.addAttribute("prjs", getPrj.schProject(""));
		return "tracerPages/calendar";
	}
	@PostMapping("getScheduleCalendarList")
	public ResponseEntity<List<Calendar>> getSchduleCalendarList(@RequestParam("pid") String pid){
		return ResponseEntity.ok(service.getScheduleCalendarList(pid));
	}
	@PostMapping("insScheduleCalendar")
	public ResponseEntity<Map<String, Object>> insScheduleCalendar(Calendar ins) {
		Map<String, Object> response = service.insScheduleCalendar(ins);
		return ResponseEntity.ok(response);
	}
	@PostMapping("uptScheduleCalendar")
	public ResponseEntity<Map<String, Object>> uptScheduleCalendar(Calendar upt) {
		Map<String, Object> response = service.uptScheduleCalendar(upt);
		return ResponseEntity.ok(response);
	}
	@PostMapping("delScheduleCalendar")
	public ResponseEntity<Map<String, Object>> delScheduleCalendar(@RequestParam("id")String id) {
		Map<String, Object> response = service.delScheduleCalendar(id);
		return ResponseEntity.ok(response);
	}
	@PostMapping("getScheduleCalendarListIndiv")
	public ResponseEntity<List<Calendar>> getSchduleCalendarListIndiv(@RequestParam("email") String email){
		return ResponseEntity.ok(service.getScheduleCalendarListIndiv(email));
	}
	@PostMapping("insScheduleCalendarIndiv")
	public ResponseEntity<Map<String, Object>> insScheduleCalendarIndiv(Calendar ins) {
		Map<String, Object> response = service.insScheduleCalendarIndiv(ins);
		return ResponseEntity.ok(response);
	}
	@PostMapping("uptScheduleCalendarIndiv")
	public ResponseEntity<Map<String, Object>> uptScheduleCalendarIndiv(Calendar upt) {
		Map<String, Object> response = service.uptScheduleCalendarIndiv(upt);
		return ResponseEntity.ok(response);
	}
	@PostMapping("delScheduleCalendarIndiv")
	public ResponseEntity<Map<String, Object>> delScheduleCalendarIndiv(@RequestParam("id")String id) {
		Map<String, Object> response = service.delScheduleCalendarIndiv(id);
		return ResponseEntity.ok(response);
	}
	@PostMapping("getScheduleCalendarListTeam")
	public ResponseEntity<List<Calendar>> getSchduleCalendarListTeam(@RequestParam("tid") String tid,
																	@RequestParam("email") String email){
		return ResponseEntity.ok(service.getScheduleCalendarListTeam(tid, email));
	}
	@PostMapping("insScheduleCalendarTeam")
	public ResponseEntity<Map<String, Object>> insScheduleCalendarTeam(Calendar ins) {
		Map<String, Object> response = service.insScheduleCalendarTeam(ins);
		return ResponseEntity.ok(response);
	}
	@PostMapping("uptScheduleCalendarTeam")
	public ResponseEntity<Map<String, Object>> uptScheduleCalendarTeam(Calendar upt) {
		Map<String, Object> response = service.uptScheduleCalendarTeam(upt);
		return ResponseEntity.ok(response);
	}
	@PostMapping("delScheduleCalendarTeam")
	public ResponseEntity<Map<String, Object>> delScheduleCalendarTeam(@RequestParam("id")String id) {
		Map<String, Object> response = service.delScheduleCalendarTeam(id);
		return ResponseEntity.ok(response);
	}
}
