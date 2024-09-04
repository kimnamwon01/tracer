package com.web.tracerProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.web.tracerProject.vo.Team;

@Mapper
public interface NDaoTeam {
	// 프로젝트 조회
		@Select("""
				SELECT *
				FROM TEAM
				WHERE PID = #{pid}
				""")
		List<Team> getTeam(@Param("pid") String pid);
		@Select("""
				SELECT *
				FROM TEAM
				WHERE NAME LIKE '%'||#{name}||'%'
				AND PID = #{pid}
				""")
		List<Team> schTeam(@Param("name") String name, @Param("pid") String pid);
		@Delete("""
				DELETE TEAM
				WHERE TID = #{tid}
				""")
		int delTeam(@Param("tid") String tid);
}
