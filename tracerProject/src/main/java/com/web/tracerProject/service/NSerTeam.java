package com.web.tracerProject.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.web.tracerProject.mapper.NDaoTeam;
import com.web.tracerProject.vo.Team;

@Controller
public class NSerTeam {
	@Autowired(required=false)
	private NDaoTeam dao;
	
	
	public List<Team> getTeam(String pid){
		return dao.getTeam(pid);
	}
	public List<Team> schTeam(String name, String pid){
		return dao.schTeam(name, pid);
	}
	public List<Team> delTeam(String tid, @Param("pid") String pid) {
		dao.delTeam(tid);
		return dao.schTeam("", pid);
	}
}
