package com.model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class JobDetails {
	private String empId;
	private String jobTitle;
	private double salary;
	
	public JobDetails(String jobTitle, double salary) {
		this.jobTitle = jobTitle;
		this.salary = salary;
	}
}
