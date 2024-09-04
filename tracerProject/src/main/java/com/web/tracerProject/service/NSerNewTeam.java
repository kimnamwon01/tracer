package com.web.tracerProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.NDaoNewTeam;
import com.web.tracerProject.vo.Team;

@Service
public class NSerNewTeam {
	@Autowired(required=false)
	private NDaoNewTeam dao;
	
	public String insertTeam(Team team) {
		return dao.insertTeam(team)>0?"팀생성성공":"팀생성실패";
	}
}
