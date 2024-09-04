package com.web.tracerProject.vo;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Task {
    private String tkid;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startDate;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;
    
    private String name;
    private String description;
    private String sid;
    private Boolean endYn;
    private String email;
    private String approvalStatus;
    
    // 포맷팅된 날짜 필드 추가
    private String formattedStartDate;
    private String formattedEndDate;
    
    // Approval 객체를 필드로 추가
    private List<Approval> approvals; 
    
    // 날짜 포맷팅 메서드 추가
    public void setFormattedDates() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        if (startDate != null) {
            this.formattedStartDate = formatter.format(startDate);
        }
        if (endDate != null) {
            this.formattedEndDate = formatter.format(endDate);
        }
    }

}
