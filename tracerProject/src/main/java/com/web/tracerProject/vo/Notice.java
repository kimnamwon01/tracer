package com.web.tracerProject.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Notice {
 private String vid;
 private String title;
 private String content;
 private String email;
 private Date date_of_registration;
 private Date start_date;
 private Date end_date;
 private String nickname;
 private String link;
}
