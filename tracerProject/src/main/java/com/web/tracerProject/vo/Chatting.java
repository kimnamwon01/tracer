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
public class Chatting {
    private String chid;
    private String email;
    private String nickname;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date sent_date;
    private String content;
}
