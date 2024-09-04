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
public class Comments {
	private String cid;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date ldate;
	private String content;
	private String email;
}
