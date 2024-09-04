package com.web.tracerProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.web.tracerProject.vo.Team;
import com.web.tracerProject.vo.User_info;

@Mapper
public interface NDaoTeamDetail {
	@Select("""
			SELECT *
			FROM TEAM
			WHERE TID = #{tid}
			""")
	Team selTeam(@Param("tid") String tid);
	@Update("""
			UPDATE TEAM
				SET NAME = #{name}
			WHERE TID = #{tid}
			""")
	int uptTeam(Team team);
	@Delete("""
			DELETE FROM TEAM
			WHERE TID = #{tid}
			""")
	int delTeam(@Param("tid") String tid);
	@Update("""
			UPDATE USER_INFO
			SET TID = '0'
			WHERE TID = #{tid}
			""")
	int delAllUserTid(@Param("tid") String tid);
	@Update("""
			UPDATE USER_INFO
			SET TID = '0'
			WHERE EMAIL = #{email}
			""")
	int delUserTid(@Param("email") String email);
	@Select("""
			SELECT * FROM USER_INFO
			WHERE TID = #{tid}
			""")
	List<User_info> getParticipantsTeam(@Param("tid") String tid);
	
	@Select("""
			SELECT *
			FROM USER_INFO
			WHERE TID = '0'
			AND NICKNAME LIKE '%'||#{nickname}||'%'
			AND PID = #{pid}
			""")
	List<User_info> getCanWorkTeam(@Param("nickname") String nickname,
											@Param("pid") String pid);
	@Update("""
			UPDATE USER_INFO
			SET TID = #{tid}
			WHERE EMAIL = #{email}
			""")
	int insUserTid(@Param("tid") String pid, 
					@Param("email") String email);
}
