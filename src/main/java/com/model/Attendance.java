package com.model;

import java.sql.Date;

public class Attendance {
	private int id;
	private String empId;
	private Date attendenceDate;
	private String status;
	
	public Attendance(String empId, Date attendenceDate, String status) {
		this.empId = empId;
		this.attendenceDate = attendenceDate;
		this.status = status;
	}

	public Attendance() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public Date getAttendenceDate() {
		return attendenceDate;
	}

	public void setAttendenceDate(Date attendenceDate) {
		this.attendenceDate = attendenceDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Attendance [id=" + id + ", empId=" + empId + ", attendenceDate=" + attendenceDate + ", status=" + status
				+ "]";
	}
}
