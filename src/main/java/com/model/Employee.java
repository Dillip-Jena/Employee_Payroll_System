package com.model;

import java.io.InputStream;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Employee {
	private String empId;
	private String name;
	private String email;
	private String password;
	private String contact;
	private String address;
	private Date joiningDate;
	private String adminId;
	private InputStream profilePic;
	
	public Employee() {
		super();
	}
}
