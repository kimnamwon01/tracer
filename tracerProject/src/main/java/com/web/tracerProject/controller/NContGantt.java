package com.web.tracerProject.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.tracerProject.service.NSerGantt;
import com.web.tracerProject.service.NSerPrj;
import com.web.tracerProject.vo.Calendar;
import com.web.tracerProject.vo.Gantt;

@Controller
public class NContGantt extends NContBase{
	@Autowired(required=false)
	NSerGantt service;
	@Autowired(required=false)
	NSerPrj getPrj;
	
	@GetMapping("timeline")
	public String timeline(Model d) {
		d.addAttribute("prjs", getPrj.schProject(""));
		return "tracerPages/timeline";
	}
	@PostMapping("timeline")
    public ResponseEntity<Map<String, Object>> getGanttScheduleTask(@RequestParam("pid") String pid) {
        List<Gantt> ganttSchedule = service.getGanttSchedule(pid);
        List<Gantt> ganttTask = service.getGanttTask(pid);
        
        List<Gantt> ganttData = new ArrayList<>();
        ganttData.addAll(ganttSchedule);
        ganttData.addAll(ganttTask);
        
        Map<String, Object> response = new HashMap<>();
        response.put("data", ganttData);

        return ResponseEntity.ok(response);
    }
	@PostMapping("getUsers")
	public ResponseEntity<List<String>> getUsers() {
		return ResponseEntity.ok(service.getUsers());
	}
	
	@PostMapping("insSchByGantt")
	public ResponseEntity<String> insSchByGantt(Gantt gantt){
		return ResponseEntity.ok(service.insGanttSchedule(gantt));
	}
	@PostMapping("insTaskByGantt")
	public ResponseEntity<String> insTaskByGantt(Gantt gantt){
		return ResponseEntity.ok(service.insGanttTask(gantt));
	}
	@PostMapping("uptSchByGantt")
	public ResponseEntity<String> uptSchByGantt(Gantt gantt){
		return ResponseEntity.ok(service.uptGanttSchedule(gantt));
	}
	@PostMapping("uptTaskByGantt")
	public ResponseEntity<String> uptTaskByGantt(Gantt gantt){
		return ResponseEntity.ok(service.uptGanttTask(gantt));
	}
	@PostMapping("delSchByGantt")
	public ResponseEntity<String> delSchByGantt(Gantt gantt){
		return ResponseEntity.ok(service.delGanttSchedule(gantt));
	}
	@PostMapping("delTaskByGantt")
	public ResponseEntity<String> delTaskByGantt(Gantt gantt){
		return ResponseEntity.ok(service.delGanttTask(gantt));
	}
	
	@PostMapping("getEmail")
	public ResponseEntity<String> getEmail(Gantt gantt){
		return ResponseEntity.ok(service.getEmail(gantt));
	}
	
	
}
