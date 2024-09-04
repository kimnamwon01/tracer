package com.web.tracerProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.NDaoNewPrj;
import com.web.tracerProject.vo.Project;

@Service
public class NSerNewPrj {
	@Autowired(required=false)
	private NDaoNewPrj dao;
	
	public String insertProject(Project project) {
		return dao.insertProject(project)>0?"프로젝트생성성공":"프로젝트생성실패";
	}
}
