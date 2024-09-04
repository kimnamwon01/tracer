package com.web.tracerProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.web.tracerProject.vo.Project;
import com.web.tracerProject.vo.ResourceManage;

@Mapper
public interface JDaoResource {
    @Select("SELECT assigned_budget, used_budget FROM ResourceManage WHERE rtype = 'BUDGET' AND pid = #{pid}")
    ResourceManage getBudget(String pid);

    @Select("SELECT rm.*, p.title as projectTitle FROM ResourceManage rm LEFT JOIN Project p ON rm.pid = p.pid WHERE rm.rtype IN ('LICENSE', 'FEE', 'EQUIPMENT')")
    List<ResourceManage> getAllAssets();

    @Update("UPDATE ResourceManage SET assigned_budget = assigned_budget + #{amount} WHERE pid = #{pid} AND rtype = 'BUDGET'")
    void addBudget(@Param("pid") String pid, @Param("amount") int amount);

    @Update("UPDATE ResourceManage SET assigned_budget = assigned_budget - #{amount} WHERE pid = #{pid} AND rtype = 'BUDGET'")
    void reduceBudget(@Param("pid") String pid, @Param("amount") int amount);

    @Insert("INSERT INTO ResourceManage (rid, pid, rtype, assigned_budget) VALUES ('RID'||LPAD(RID_SEQ.NEXTVAL, 5, '0'), #{pid}, 'BUDGET', #{amount})")
    void assignBudget(@Param("pid") String pid, @Param("amount") int amount);

    @Select("SELECT MAX(CAST(SUBSTR(rid, 4) AS INT)) \r\n"
    		+ "FROM ResourceManage \r\n"
    		+ "WHERE REGEXP_LIKE(RID, '^RID[0-9]+$')")
    Integer getMaxRid();
    
    @Insert("INSERT INTO ResourceManage (rid, pid, rtype, software_name, license_purchase_date, license_expiry_date, software_price) VALUES ('RID'||LPAD(RID_SEQ.NEXTVAL, 5, '0'), #{pid}, #{rtype}, #{software_name}, #{license_purchase_date}, #{license_expiry_date}, #{software_price})")
    void addAsset(ResourceManage asset);

    @Update("UPDATE ResourceManage SET used_budget = COALESCE(used_budget, 0) + #{amount} WHERE pid = #{pid} AND rtype = 'BUDGET'")
    void updateUsedBudget(@Param("pid") String pid, @Param("amount") int software_price);

    @Select("SELECT * FROM PROJECT")
    List<Project> getAllProjects();
    
    @Select("SELECT * FROM PROJECT p LEFT JOIN ResourceManage r ON p.pid = r.pid AND r.rtype = 'BUDGET' WHERE r.assigned_budget IS NULL OR r.assigned_budget = 0")
    List<Project> getProjectsWithNoAssignedBudget();
}
