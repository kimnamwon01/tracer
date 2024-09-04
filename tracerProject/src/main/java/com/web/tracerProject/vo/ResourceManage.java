package com.web.tracerProject.vo;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ResourceManage {
    private String rid;
    private String rtype;
    private int assigned_budget;
    private int used_budget;
    private int remainingBudget;
    private String software_name;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date license_purchase_date;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date license_expiry_date;
    private int software_price;
    private String pid;
    private String projectTitle;

    // 필요한 생성자 추가
    public ResourceManage(String rid, String pid, String rtype, String software_name, Date license_purchase_date, Date license_expiry_date, int software_price) {
        this.rid = rid;
        this.pid = pid;
        this.rtype = rtype;
        this.software_name = software_name;
        this.license_purchase_date = license_purchase_date;
        this.license_expiry_date = license_expiry_date;
        this.software_price = software_price;
    }
}

