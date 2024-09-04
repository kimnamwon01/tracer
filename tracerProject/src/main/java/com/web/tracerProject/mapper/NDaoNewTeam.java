package com.web.tracerProject.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.web.tracerProject.vo.Team;

@Mapper
public interface NDaoNewTeam {
	@Insert("""
			INSERT INTO TEAM (TID, NAME, PID)
			VALUES(tid_seq.NEXTVAL, #{name}, #{pid})
			""")
	int insertTeam(Team team);
}
