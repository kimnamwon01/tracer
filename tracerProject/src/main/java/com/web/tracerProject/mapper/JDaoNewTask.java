package com.web.tracerProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.web.tracerProject.vo.Task;

@Mapper
public interface JDaoNewTask {

    // 기존 주석을 실제 코드로 변환
	@Select("SELECT tkid, start_date AS startDate, end_date AS endDate, name, description, endYn, sid FROM TASK")
    List<Task> findAllTasks();

	@Insert("INSERT INTO task (tkid, start_date, end_date, name, description, endYN, sid) " +
	        "VALUES ('TKID'||LPAD(TKID_SEQ.NEXTVAL, 4, '0'), " +
	        "#{startDate,jdbcType=DATE}, #{endDate,jdbcType=DATE}, " +
	        "#{name,jdbcType=VARCHAR}, #{description,jdbcType=VARCHAR}, " +
	        "#{endYn,jdbcType=NUMERIC}, #{sid,jdbcType=VARCHAR})")
	int insertTask(Task task);


    @Update("UPDATE TASK SET ENDYN = #{endYn} WHERE TKID = #{tkid}")
    void updateTaskEndYn(@Param("tkid") String tkid, @Param("endYn") int endYn);

    @Update("UPDATE TASK SET START_DATE = #{startDate}, END_DATE = #{endDate}, " +
            "NAME = #{name}, DESCRIPTION = #{description}, SID = #{sid,jdbcType=VARCHAR}, ENDYN = #{endYn,jdbcType=NUMERIC} " +
            "WHERE TKID = #{tkid}")
    void updateTask(Task task);

    @Delete("DELETE FROM TASK WHERE TKID = #{tkid}")
    void deleteTask(String tkid);

    @Select("SELECT tkid, start_date AS startDate, end_date AS endDate, name, description, endYn, sid FROM TASK WHERE tkid = #{tkid}")
    Task findTaskById(String tkid);

    /*
     * @Select("SELECT * FROM \"C##JH\".\"TASK\"")
     * List<Task> findAllTasks();
     */

    /*
     * @Insert("INSERT INTO \"C##JH\".\"TASK\" (\"TKID\", \"START_DATE\", \"END_DATE\", \"NAME\", \"DESCRIPTION\", \"SID\", \"ENDYN\") " +
     *         "VALUES (#{tkid}, #{startDate}, #{endDate}, #{name}, #{description}, #{sid}, #{endYn})")
     */

    /*
     * @Update("UPDATE \"C##JH\".\"TASK\" SET \"START_DATE\" = #{startDate}, \"END_DATE\" = #{endDate}, " +
     *         "\"NAME\" = #{name}, \"DESCRIPTION\" = #{description}, \"SID\" = #{sid}, \"ENDYN\" = #{endYn} " +
     *         "WHERE \"TKID\" = #{tkid}")
     */

    /*
     * @Delete("DELETE FROM \"C##JH\".\"TASK\" WHERE \"TKID\" = #{tkid}")
     */

    /*
     * @Select("SELECT * FROM \"C##JH\".\"TASK\" WHERE \"TKID\" = #{tkid}")
     * Task findTaskById(String tkid);
     */
}
