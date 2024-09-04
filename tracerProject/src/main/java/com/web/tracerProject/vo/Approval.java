package com.web.tracerProject.vo;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Approval {
    private String apid;
    private String approvalStatus = "결재 대기";
    
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime requestDateTime;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime statusUpdateDateTime;
    
    private String feedback;
    private String tkid;
    private String upfile;
    private String originalFileName;
    private String email;
    private String content;
    private String approvalTitle;
    private String approvalDescription;
    
    // 포맷팅된 날짜 필드
    private String formattedRequestDateTime;
    private String formattedUpdateDateTime;
}
