package com.web.tracerProject.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.web.tracerProject.vo.Project;

@Mapper
public interface NDaoNewPrj {
	@Insert("""
			INSERT INTO PROJECT (PID, TITLE, DESCRIPTION, START_DATE, END_DATE)
			VALUES(pid_seq.NEXTVAL, #{title}, #{description}, #{start_date}, #{end_date})
			""")
	int insertProject(Project project);
}
