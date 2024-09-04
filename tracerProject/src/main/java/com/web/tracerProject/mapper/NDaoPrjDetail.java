package com.web.tracerProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.web.tracerProject.vo.Project;
import com.web.tracerProject.vo.User_info;

@Mapper
public interface NDaoPrjDetail {
	@Select("""
			SELECT *
			FROM PROJECT
			WHERE PID = #{pid}
			""")
	Project selPrj(@Param("pid") String pid);
	@Update("""
			UPDATE PROJECT
				SET START_DATE = #{start_date},
				END_DATE = #{end_date},
				TITLE = #{title},
				DESCRIPTION = #{description}
			WHERE PID = #{pid}
			""")
	int uptPrj(Project upt);
	@Delete("""
			DELETE FROM PROJECT
			WHERE PID = #{pid}
			""")
	int delPrj(@Param("pid") String pid);
	@Update("""
			UPDATE USER_INFO
			SET PID = '0'
			WHERE PID = #{pid}
			""")
	int delAllUserPid(@Param("pid") String pid);
	@Update("""
			UPDATE USER_INFO
			SET PID = '0'
			WHERE EMAIL = #{email}
			""")
	int delUserPid(@Param("email") String email);
	@Select("""
			SELECT * FROM USER_INFO
			WHERE PID = #{pid}
			""")
	List<User_info> getParticipants(@Param("pid") String pid);
	
	@Select("""
			SELECT *
			FROM USER_INFO
			WHERE PID = '0'
			AND NICKNAME LIKE '%'||#{nickname}||'%'
			""")
	List<User_info> getCanWork(@Param("nickname") String nickname);
	@Update("""
			UPDATE USER_INFO
			SET PID = #{pid}
			WHERE EMAIL = #{email}
			""")
	int insUserPid(@Param("pid") String pid, 
					@Param("email") String email);
	
}
