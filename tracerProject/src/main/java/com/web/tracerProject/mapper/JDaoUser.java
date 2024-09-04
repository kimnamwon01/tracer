package com.web.tracerProject.mapper;

import java.util.List;
import com.web.tracerProject.vo.User_info;
import org.apache.ibatis.annotations.*;

@Mapper
public interface JDaoUser {
    
    @Select("SELECT * FROM USER_INFO")
    List<User_info> findAllUsers();

    @Select("SELECT * FROM USER_INFO WHERE EMAIL = #{email}")
    User_info findUserById(String email);

    @Insert("INSERT INTO USER_INFO (EMAIL, PASSWORD, NICKNAME, NAME, BIRTH, PHONE, AUTH) " +
            "VALUES (#{email}, #{password}, #{nickname}, #{name}, #{birth}, #{phone}, #{auth})")
    void insertUser(User_info user);

    @Update("UPDATE USER_INFO SET PASSWORD=#{password}, NICKNAME=#{nickname}, NAME=#{name}, " +
            "BIRTH=#{birth}, PHONE=#{phone}, AUTH=#{auth} WHERE EMAIL = #{email}")
    void updateUser(User_info user);

    @Delete("DELETE FROM USER_INFO WHERE EMAIL = #{email}")
    void deleteUser(String email);
}
