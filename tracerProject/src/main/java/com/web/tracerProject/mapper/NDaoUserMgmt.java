package com.web.tracerProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.web.tracerProject.vo.User_info;

@Mapper
public interface NDaoUserMgmt {

    @Select("""
            SELECT * 
            FROM (
                SELECT a.*, ROW_NUMBER() OVER (ORDER BY email) AS rn
                FROM USER_INFO a
            )
            WHERE rn BETWEEN #{offset} + 1 AND #{offset} + #{pageSize}
            """)
    List<User_info> getUserInfo(@Param("offset") int offset, @Param("pageSize") int pageSize);

    @Select("""
            SELECT * 
            FROM (
                SELECT a.*, ROW_NUMBER() OVER (ORDER BY email) AS rn
                FROM USER_INFO a
                WHERE NAME LIKE '%' || #{name} || '%'
                AND AUTH LIKE '%' || #{auth} || '%'
                AND NICKNAME LIKE '%' || #{nickname} || '%'
            )
            WHERE rn BETWEEN #{offset} + 1 AND #{offset} + #{pageSize}
            """)
    List<User_info> schUserInfo(@Param("nickname") String nickname, 
    							@Param("name") String name, 
                                @Param("auth") String auth,
                                @Param("offset") int offset, 
                                @Param("pageSize") int pageSize);
    
    @Update("""
            UPDATE USER_INFO
            SET AUTH = #{auth}
            WHERE EMAIL = #{email}
            """)
    int uptUser(@Param("auth") String auth, @Param("email") String email);
    
    @Delete("""
            DELETE FROM USER_INFO
            WHERE EMAIL = #{email}
            """)
    int delUser(@Param("email") String email);
    
    @Select("""
            SELECT COUNT(*) 
            FROM USER_INFO
            """)
    int countAllUsers();

    @Select("""
            SELECT COUNT(*) 
            FROM USER_INFO 
            WHERE NAME LIKE '%' || #{name} || '%' 
            AND AUTH LIKE '%' || #{auth} || '%'
            AND NICKNAME LIKE '%' || #{nickname} || '%'
            """)
    int countUsers(@Param("nickname") String nickname, 
    				@Param("name") String name, @Param("auth") String auth);
}
