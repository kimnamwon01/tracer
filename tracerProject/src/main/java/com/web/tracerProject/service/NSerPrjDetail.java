package com.web.tracerProject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.NDaoPrjDetail;
import com.web.tracerProject.vo.Project;
import com.web.tracerProject.vo.User_info;

@Service
public class NSerPrjDetail {
	@Autowired(required=false)
	private NDaoPrjDetail dao;
	
	public Project selPrj(String pid) {
		return dao.selPrj(pid);
	}
	
	public String uptPrj(Project project) {
		return dao.uptPrj(project)>0?"프로젝트수정성공":"프로젝트수정실패";
	}
	
	public String delPrj(String pid) {
		dao.delAllUserPid(pid);
		return dao.delPrj(pid)>0?"프로젝트삭제성공":"프로젝트삭제실패";
	}
	public List<User_info> getCanWork(String nickname){
		return dao.getCanWork(nickname);
	}
	public List<User_info> getParticipants(String pid){
		return dao.getParticipants(pid);
	}
	public String insUserPid(String pid, String email) {
		return dao.insUserPid(pid, email)>0?"프로젝트참가성공":"프로젝트참가실패";
	}
	public String delUserPid(String email) {
		return dao.delUserPid(email)>0?"프로젝트퇴출성공":"프로젝트퇴출실패";
	}
}
