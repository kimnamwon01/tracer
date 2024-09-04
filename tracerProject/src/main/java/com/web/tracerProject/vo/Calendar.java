package com.web.tracerProject.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Calendar {
	private String id;
	private String title;
	private String writer;
	private String start;
	private String end;
	private String content;
	private String backgroundColor;
	private String textColor;
	private boolean allDay;
	private String url;
	
	private String email;
	private String tid;
	private String pid;
}
