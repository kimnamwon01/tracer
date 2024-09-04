package com.web.tracerProject.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.web.tracerProject.vo.Task;
import com.web.tracerProject.vo.UserProgress;
import com.web.tracerProject.vo.User_info;

@Mapper
public interface JDaoMain {

    @Select("SELECT COUNT(*) FROM USER_INFO WHERE email=#{email} AND password=#{password}")
    int isMember(User_info user_info);

    @Select("SELECT * FROM USER_INFO WHERE EMAIL=#{email}")
    User_info getMember(User_info user_info);

    @Select("SELECT count(*) FROM TASK WHERE trunc(START_DATE) = trunc(SYSDATE)")
    int getTodayDo(Task task);

    @Select("SELECT count(*) FROM TASK WHERE START_DATE BETWEEN trunc(sysdate, 'IW') AND trunc(sysdate, 'IW')+6")
    int getWeekDo(Task task);

    @Select("SELECT trunc(end_date) AS end_date FROM (SELECT * FROM project ORDER BY abs(trunc(start_date) - trunc(sysdate))) WHERE rownum = 1")
    Date getDueto(Task task);

    @Select("SELECT CASE WHEN TRUNC(end_date) = TRUNC(SYSDATE) THEN 'D-Day' "
    		+ "WHEN TRUNC(end_date) > TRUNC(SYSDATE) THEN 'D-' || TO_CHAR(TRUNC(end_date) - TRUNC(SYSDATE)) "
    		+ "ELSE 'D+' || TO_CHAR(TRUNC(SYSDATE) - TRUNC(end_date)) "
    		+ "END AS d_day FROM (SELECT * FROM project ORDER BY ABS(TRUNC(start_date) - TRUNC(SYSDATE))) "
    		+ "WHERE ROWNUM = 1")
    String getDday(Task task);

    @Select("SELECT COUNT(*) FROM APPROVAL WHERE APPROVALSTATUS = '결재 대기'")
    int getRequestApprovalCount(Task task);

    @Select("SELECT u.email, u.nickname, " +
            "(SUM(CASE WHEN t.endYN = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*)) AS progress " +
            "FROM USER_INFO u " +
            "JOIN SCHEDULE s ON u.email = s.email " +
            "JOIN TASK t ON s.sid = t.sid " +
            "GROUP BY u.email, u.nickname")
    List<UserProgress> getUserProgress();

    @Select("SELECT (SUM(CASE WHEN t.endYN = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*)) AS progress "
          + "FROM TASK t "
          + "JOIN SCHEDULE s ON t.sid = s.sid "
          + "WHERE s.email = #{email}")
    Integer getMyTaskProgress(Task task);



}
