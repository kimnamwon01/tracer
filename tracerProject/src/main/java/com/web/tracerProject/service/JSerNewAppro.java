package com.web.tracerProject.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.JDaoNewAppro;
import com.web.tracerProject.vo.Approval;

@Service
public class JSerNewAppro {

    @Autowired(required = false)
    private JDaoNewAppro dao;

    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    public List<Approval> getAllApprovals() {
        List<Approval> approvals = dao.findAllApprovals();

        for (Approval approval : approvals) {
            if (approval.getRequestDateTime() != null) {
                approval.setFormattedRequestDateTime(approval.getRequestDateTime().format(formatter));
            }
            if (approval.getStatusUpdateDateTime() != null) {
                approval.setFormattedUpdateDateTime(approval.getStatusUpdateDateTime().format(formatter));
            }
        }

        return approvals;
    }

    public void addApproval(Approval approval) {
        approval.setRequestDateTime(LocalDateTime.now());
        dao.insertApproval(approval);
    }

    public void updateApprovalStatus(Approval approval) {
        approval.setStatusUpdateDateTime(LocalDateTime.now());
        dao.updateApproval(approval);
    }

    public List<Approval> findApprovalsByTaskId(String tkid) {
        return dao.findApprovalsByTaskId(tkid);
    }

    public void updateUserFeedback(String apid, String userFeedback) {
        Approval approval = dao.findApprovalById(apid);
        String currentFeedback = approval.getFeedback();
        String newFeedback = (currentFeedback != null ? currentFeedback + "\n" : "") + userFeedback;
        dao.updateFeedback(apid, newFeedback);
    }

    public Approval getApprovalWithEmail(String apid) {
        return dao.getApprovalWithEmail(apid);
    }

    public Approval getApprovalById(String apid) {
        return dao.findApprovalById(apid); 
    }

}

