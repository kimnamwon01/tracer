package com.web.tracerProject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.NDaoTeamDetail;
import com.web.tracerProject.vo.Team;
import com.web.tracerProject.vo.User_info;

@Service
public class NSerTeamDetail {
	@Autowired(required=false)
	private NDaoTeamDetail dao;
	
	public Team selTeam(String tid) {
		return dao.selTeam(tid);
	}
	
	public String uptTeam(Team team) {
		return dao.uptTeam(team)>0?"팀수정성공":"팀수정실패";
	}
	
	public String delTeam(String tid) {
		dao.delAllUserTid(tid);
		return dao.delTeam(tid)>0?"팀삭제성공":"팀삭제실패";
	}
	public List<User_info> getCanWorkTeam(String nickname, String pid){
		return dao.getCanWorkTeam(nickname, pid);
	}
	public List<User_info> getParticipantsTeam(String tid){
		return dao.getParticipantsTeam(tid);
	}
	public String insUserTid(String tid, String email) {
		return dao.insUserTid(tid, email)>0?"팀참가성공":"팀참가실패";
	}
	public String delUserTid(String email) {
		return dao.delUserTid(email)>0?"팀퇴출성공":"팀퇴출실패";
	}
}
