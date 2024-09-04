package com.web.tracerProject.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ProjectProgress {
	private String pid;
	private String title;
	private int progress;
	private int completedTasks;
    private int totalTasks;
}
