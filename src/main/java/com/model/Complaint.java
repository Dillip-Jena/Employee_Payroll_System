package com.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Complaint {
	private int id;
	private String empId;
	private String problemText;
	private String complaintDate;
	
	public Complaint(String empId, String problemText, String complaintDate) {
		this.empId = empId;
		this.problemText = problemText;
		this.complaintDate = complaintDate;
	}
}
