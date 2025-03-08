package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.connection.DBConnection;
import com.model.JobDetails;
import com.model.SalarySlip;

public class JobDAO {
	
	public static JobDetails getJobDetails(String empId) {
		JobDetails details = null;
		try(Connection conn = DBConnection.getConnection()){
			String query = "SELECT job_title, salary FROM job_details WHERE emp_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, empId);
			
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				details = new JobDetails(rs.getString("job_title"), rs.getDouble("salary"));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return details;
	}
	
	public static String getJobTitle(String empId) {
		String title = null;
		try(Connection conn = DBConnection.getConnection()){
			String query = "SELECT job_title FROM job_details WHERE emp_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, empId);
			
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				title = rs.getString("job_title");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return title;
	}
	
	public static SalarySlip getSalarySlip(String empId, String month, int year) {
		SalarySlip slip = null;
		try(Connection conn = DBConnection.getConnection()){
			String query = "SELECT * FROM salary_slip WHERE emp_id=? AND month=? AND year=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, empId);
			ps.setString(2, month);
			ps.setInt(3, year);
			
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				slip = new SalarySlip(rs.getString("emp_id"), rs.getString("admin_id"), rs.getInt("year"), rs.getString("month"), rs.getInt("days"), rs.getDouble("salary"));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return slip;
	}
}
