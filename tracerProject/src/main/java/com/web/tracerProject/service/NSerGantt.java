package com.web.tracerProject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.NDaoGantt;
import com.web.tracerProject.vo.Gantt;
import com.web.tracerProject.vo.Schedule;
import com.web.tracerProject.vo.Task;

@Service
public class NSerGantt {
	@Autowired(required=false)
	NDaoGantt dao;
	
	public List<Gantt> getGanttSchedule(String pid) {
		return dao.getGanttSchedule(pid);
	}
	public List<Gantt> getGanttTask(String pid) {
		return dao.getGanttTask(pid);
	}
	
	public List<String> getUsers(){ 
		return dao.getUsers();
	}
	
	public String insGanttSchedule(Gantt gantt) {
		return dao.insGanttSchedule(gantt)>0?"일정등록성공":"일정등록실패";
	}
	public String insGanttTask(Gantt gantt) {
		return dao.insGanttTask(gantt)>0?"업무등록성공":"업무등록실패";
	}
	public String uptGanttSchedule(Gantt gantt) {
		return dao.uptGanttSchedule(gantt)>0?"일정수정성공":"일정수정실패";
	}
	public String uptGanttTask(Gantt gantt) {
		return dao.uptGanttTask(gantt)>0?"업무수정성공":"업무수정실패";
	}
	public String delGanttSchedule(Gantt gantt) {
		return dao.delGanttSchedule(gantt)>0?"일정삭제성공":"일정삭제실패";
	}
	public String delGanttTask(Gantt gantt) {
		return dao.delGanttTask(gantt)>0?"업무삭제성공":"업무삭제실패";
	}
	
	public String getEmail(Gantt gantt) {
		return dao.getEmail(gantt);
	}
}
