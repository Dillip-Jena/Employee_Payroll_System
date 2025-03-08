package com.model;

import java.io.InputStream;
import java.sql.Date;

import lombok.Data;

@Data
public class Admin {
	private String adminId;
	private String name;
	private String email;
	private String password;
	private Date activation_date;
	private String company_name;
	private InputStream profilePic;
	private InputStream companyLogo;
	
	public Admin() {
		super();
	}
	
	public Admin(String adminId, String name, String email, String password, Date activation_date,
			String company_name) {
		this.adminId = adminId;
		this.name = name;
		this.email = email;
		this.password = password;
		this.activation_date = activation_date;
		this.company_name = company_name;
	}
}
