package com.web.tracerProject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Gantt {
	private String id;
	private String start_date;
	private String duration;
	private String progress;
	private String sortorder;
	private String parent;
	private String open;
	private String text;
	private String users;
	private String end_date;
	
	private String $index;
	
	private String email;
	private String pid;
}
