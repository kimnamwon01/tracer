package com.web.tracerProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.web.tracerProject.vo.Project;

@Mapper
public interface NDaoPrj {
	
	
	// 프로젝트 조회
	@Select("""
			SELECT *
			FROM PROJECT
			""")
	List<Project> getProject();
	@Select("""
			SELECT *
			FROM PROJECT
			WHERE TITLE LIKE '%'||#{prjTitle}||'%'
			""")
	List<Project> schProject(@Param("prjTitle") String prjTitle);
	@Delete("""
			DELETE PROJECT
			WHERE PID = #{pid}
			""")
	int delPrj(@Param("pid") String pid);
}