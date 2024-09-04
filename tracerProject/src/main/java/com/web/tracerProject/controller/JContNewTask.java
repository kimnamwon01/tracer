package com.web.tracerProject.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.web.tracerProject.service.JSerNewAppro;
import com.web.tracerProject.service.JSerNewTask;
import com.web.tracerProject.vo.Approval;
import com.web.tracerProject.vo.Task;
import com.web.tracerProject.vo.User_info;

import jakarta.servlet.http.HttpSession;

@Controller
public class JContNewTask {

    @Autowired(required = false)
    private JSerNewTask taskService;

    @Autowired(required = false)
    private JSerNewAppro approvalService;

    // application.properties에서 파일 업로드 경로 읽기
    @Value("${file.upload-dir}")
    private String uploadDir;

    @GetMapping("/newTask")
    public String showTaskList(Model model) {
        List<Task> tasks = taskService.getAllTasks(); // taskService에서 가져온다

        model.addAttribute("tasks", tasks);
        return "tracerPages/newTask";
    }

    @PostMapping("/newTask/add")
    public String addTask(@ModelAttribute Task task, HttpSession session) {
        User_info user_info = (User_info) session.getAttribute("user_info");
        String email = user_info != null ? user_info.getEmail() : null;

        task.setEndYn(false);
        taskService.addTask(task, email);
        return "redirect:/newTask";
    }


    @PostMapping("/newTask/update")
    public String updateTask(@ModelAttribute Task task) {
        taskService.updateTask(task);
        return "redirect:/newTask";
    }

    @PostMapping("/newTask/delete")
    public String deleteTask(@RequestParam("tkid") String tkid) {
        taskService.deleteTask(tkid);
        return "redirect:/newTask";
    }

    @PostMapping("/newTask/requestApproval")
    public String requestApproval(@RequestParam("tkid") String tkid,
                                  @RequestParam("approvalTitle") String approvalTitle,
                                  @RequestParam("approvalDescription") String approvalDescription,
                                  @RequestParam("approvalFile") MultipartFile approvalFile,
                                  HttpSession session) throws IOException {

        String fileName = null;
        if (!approvalFile.isEmpty()) {
            fileName = approvalFile.getOriginalFilename();
            File file = new File(uploadDir + File.separator + fileName);
            approvalFile.transferTo(file); 
        }
        User_info user_info = (User_info) session.getAttribute("user_info");
        String email = user_info != null ? user_info.getEmail() : null;

        Approval approval = new Approval();
        approval.setTkid(tkid);
        approval.setApprovalTitle(approvalTitle);
        approval.setApprovalDescription(approvalDescription);
        approval.setUpfile(fileName);
        approval.setOriginalFileName(fileName); 
        approval.setEmail(email);
        approvalService.addApproval(approval);

        return "redirect:/newTask";
    }


    @PostMapping("/newTask/submitFeedback")
    public String submitTaskFeedback(@RequestParam("apid") String apid,
                                     @RequestParam("userFeedback") String userFeedback) {
        approvalService.updateUserFeedback(apid, userFeedback);
        return "redirect:/newTask";
    }
    
    
    @PostMapping("/newTask/updateStatus")
    public ResponseEntity<String> updateTaskStatus(@RequestBody Map<String, Object> requestData) {
        String tkid = (String) requestData.get("tkid");
        boolean endYn = Boolean.parseBoolean(requestData.get("endYn").toString());

        // 서비스 메서드를 호출하여 endYn 상태를 업데이트
        taskService.updateTaskEndYn(tkid, endYn);

        return ResponseEntity.ok("{\"success\": true}");
    }


}
