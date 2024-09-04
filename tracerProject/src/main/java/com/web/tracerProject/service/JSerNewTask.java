package com.web.tracerProject.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.JDaoNewTask;
import com.web.tracerProject.vo.Approval;
import com.web.tracerProject.vo.Task;

@Service
public class JSerNewTask {
    @Autowired(required = false)
    private JDaoNewTask dao;

    @Autowired(required = false)
    private JSerNewAppro approvalService;

    private static final SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

    public List<Task> getAllTasks() {
        List<Task> tasks = dao.findAllTasks();
        for (Task task : tasks) {
            task.setFormattedDates(); // 날짜 포맷팅 설정

            // 여러 개의 Approval을 Task에 설정
            List<Approval> approvals = approvalService.findApprovalsByTaskId(task.getTkid());
            task.setApprovals(approvals);
        }
        return tasks;
    }


    public void addTask(Task task, String userEmail) {
        if (task.getStartDate() == null) {
            task.setStartDate(new Date()); // 또는 null 처리
        }
        if (task.getEndDate() == null) {
            task.setEndDate(null); // 또는 다른 기본값
        }
        if (task.getEndYn() == null) {
            task.setEndYn(false);
        }
        
        dao.insertTask(task);
    }


    public void updateTask(Task task) {
        dao.updateTask(task);
    }
    
    public void updateTaskEndYn(String tkid, boolean endYn) {
        int endYnValue = endYn ? 1 : 0;
        dao.updateTaskEndYn(tkid, endYnValue);
    }

    public void deleteTask(String tkid) {
        dao.deleteTask(tkid);
    }

    public Task getTaskById(String tkid) {
        // Task를 데이터베이스에서 가져옴
        Task task = dao.findTaskById(tkid);

        // task가 null이 아닌지 확인
        if (task != null) {
            // 해당 Task에 연결된 모든 Approval 객체를 가져옴
            List<Approval> approvals = approvalService.findApprovalsByTaskId(task.getTkid());
            
            // 가져온 Approval 리스트를 Task 객체에 설정
            task.setApprovals(approvals);
        }

        return task;
    }


    public void requestApproval(String tkid, String approvalTitle, String approvalDescription, String fileName, String email) {
        Approval approval = new Approval();
        approval.setTkid(tkid);
        approval.setApprovalTitle(approvalTitle);
        approval.setApprovalDescription(approvalDescription);
        approval.setUpfile(fileName);
        approval.setEmail(email); // 이메일 추가
        approvalService.addApproval(approval);
    }




}
