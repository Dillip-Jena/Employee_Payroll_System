package com.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SalarySlip {
	private String emp_id;
	private String admin_id;
	private int year;
	private String month;
	private int days;
	private double salary;
}
