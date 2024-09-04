package com.web.tracerProject.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.JDaoResource;
import com.web.tracerProject.vo.Project;
import com.web.tracerProject.vo.ResourceManage;

@Service
public class JSerResource {
    @Autowired(required = false)
    private JDaoResource dao;

    public ResourceManage getBudget(String pid) {
        ResourceManage budget = dao.getBudget(pid);
        if (budget != null) {
        	int remainingBudget = budget.getAssigned_budget() - budget.getUsed_budget();
            budget.setRemainingBudget(remainingBudget); // ResourceManage 객체에 남은 예산 필드를 추가했다고 가정
        }
        return budget;
    }

    public List<Project> getAllProjects() {
        return dao.getAllProjects();
    }

    public List<ResourceManage> getAllAssets() {
        return dao.getAllAssets();
    }

    public void addBudget(String pid, int amount) {
        dao.addBudget(pid, amount);
    }

    public void reduceBudget(String pid, int amount) {
        dao.reduceBudget(pid, amount);
    }

    public void assignBudget(String pid,int amount) {
        dao.assignBudget(pid,amount);
    }

    public ResourceManage addAssetAndUpdateBudget(String pid, String rtype, String software_name, String license_purchase_date, String license_expiry_date, int software_price) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            // ResourceManage 객체 생성 시, RID는 쿼리에서 자동으로 생성되므로 null로 설정
            ResourceManage asset = new ResourceManage(null, pid, rtype, software_name, sdf.parse(license_purchase_date), sdf.parse(license_expiry_date), software_price);
            
            // 자산 추가
            dao.addAsset(asset);

            // 사용 예산 업데이트
            dao.updateUsedBudget(pid, software_price);

            return asset;
        } catch (ParseException e) {
            throw new RuntimeException("날짜 형식 변환 오류", e);
        }
    }
    
    public List<Project> getProjectsWithNoAssignedBudget() {
        return dao.getProjectsWithNoAssignedBudget();
    }
}
