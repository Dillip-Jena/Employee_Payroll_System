package com.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import com.connection.DBConnection;
import com.model.Employee;

public class EmployeeDAO {
	
	//this method below is to validate the employee
	public static Employee validateEmployee(String empId, String email, String password) {
		Employee employee = null;
		try(Connection con = DBConnection.getConnection()){
			PreparedStatement ps = con.prepareStatement("SELECT * FROM employee WHERE emp_id=? AND email=? AND password=?");
			ps.setString(1, empId);
			ps.setString(2, email);
			ps.setString(3, password);
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()) {
				employee = new Employee(
						rs.getString("emp_id"),
						rs.getString("name"),
						rs.getString("email"),
						rs.getString("password"),
						rs.getString("contact"),
						rs.getString("address"),
						rs.getDate("joining_date"),
						rs.getString("admin_id"),
						rs.getBinaryStream("profile_pic")
						);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return employee;
	}
	
	//Fetch all employees form the database
	public static List<Employee> getAllEmployees(String adminId){
		List<Employee> employees = new ArrayList<>();
		try(Connection conn = DBConnection.getConnection()){
			String query = "SELECT emp_id, name, email, contact, address, joining_date, profile_pic FROM employee WHERE admin_id=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, adminId);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				Employee emp = new Employee(
							rs.getString("emp_id"),
							rs.getString("name"),
							rs.getString("email"),
							null,
							rs.getString("contact"),
							rs.getString("address"),
							rs.getDate("joining_date"),
							null,
							rs.getBinaryStream("profile_pic")
						);
				employees.add(emp);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return employees;
	}
	
	//Method to insert employee into the database
	public static boolean addEmployee(Employee employee) {
		boolean status = false;
		try(Connection conn = DBConnection.getConnection()){
			String query = "INSERT INTO employee (emp_id, name, email, contact, address, joining_date, password, admin_id, profile_pic) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = conn.prepareStatement(query);
			
			ps.setString(1, employee.getEmpId());
			ps.setString(2, employee.getName());
			ps.setString(3, employee.getEmail());
			ps.setString(4, employee.getContact());
			ps.setString(5, employee.getAddress());
			ps.setDate(6, employee.getJoiningDate());
			ps.setString(7, employee.getPassword());
			ps.setString(8, employee.getAdminId());
			
			if (employee.getProfilePic() != null) {
			    ps.setBlob(9, employee.getProfilePic());
			} else {
			    ps.setNull(9, java.sql.Types.BLOB);
			}
			
			int rowAffect = ps.executeUpdate();
			if(rowAffect > 0) {
				status = true;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return status;
	}
		
	//Method to generate a unique employee ID
	public static String generateUniqueEmployeeId() {
		String empId = null;
		try(Connection conn = DBConnection.getConnection()){
			Random random = new Random();
			boolean isUnique = false;
			
			while(!isUnique) {
				int randomNum = 10000 + random.nextInt(90000);
				empId = "E" + randomNum;
				
				String query = "SELECT emp_id from employee where emp_id=?";
				PreparedStatement ps = conn.prepareStatement(query);
				ps.setString(1, empId);
				
				ResultSet rs = ps.executeQuery();
				
				if(!rs.next()) {
					isUnique = true;
				}
				rs.close();
				ps.close();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return empId;
	}
	
	//Update Employee Details
	public static boolean updateEmployee(Employee emp) {
		boolean isUpdate = false;
		try(Connection conn = DBConnection.getConnection()){
			String query = "UPDATE employee SET name=?, email=?, contact=?, address=?, joining_date=? WHERE emp_id=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, emp.getName());
			ps.setString(2, emp.getEmail());
			ps.setString(3, emp.getContact());
			ps.setString(4, emp.getAddress());
			ps.setDate(5, emp.getJoiningDate());
			ps.setString(6, emp.getEmpId());
			
			int rows = ps.executeUpdate();
			if(rows > 0) {
				isUpdate = true;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return isUpdate;
	}
	
	//Delete Employee
	public static boolean deleteEmployee(String empId) {
		boolean isDeleted = false;
		try(Connection conn = DBConnection.getConnection()){
			String query = "DELETE FROM employee WHERE emp_id=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, empId);
			
			int rows = ps.executeUpdate();
			if(rows > 0) {
				isDeleted = true;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return isDeleted;
	}
	
	//update employee Job and salary
	public static boolean updateEmployeeJob(String empId, String jobTitle, double salary) {
	    // Check if employee exists in the 'employee' table
	    String checkEmployeeSql = "SELECT COUNT(*) FROM employee WHERE emp_id = ?";
	    String checkJobSql = "SELECT COUNT(*) FROM job_details WHERE emp_id = ?";
	    String updateSql = "UPDATE job_details SET job_title = ?, salary = ? WHERE emp_id = ?";
	    String insertSql = "INSERT INTO job_details (emp_id, job_title, salary) VALUES (?, ?, ?)";
	    
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement checkEmpStmt = conn.prepareStatement(checkEmployeeSql)) {
	        
	        checkEmpStmt.setString(1, empId);
	        ResultSet empRs = checkEmpStmt.executeQuery();
	        
	        if (empRs.next() && empRs.getInt(1) > 0) {
	            // Employee exists, now check if job_details exist for that employee
	            try (PreparedStatement checkJobStmt = conn.prepareStatement(checkJobSql)) {
	                checkJobStmt.setString(1, empId);
	                ResultSet jobRs = checkJobStmt.executeQuery();
	                
	                if (jobRs.next() && jobRs.getInt(1) > 0) {
	                    // Job details exist, update the record
	                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
	                        updateStmt.setString(1, jobTitle);
	                        updateStmt.setDouble(2, salary);
	                        updateStmt.setString(3, empId);
	                        
	                        int rowsUpdated = updateStmt.executeUpdate();
	                        return rowsUpdated > 0;
	                    }
	                } else {
	                    // Job details do not exist, insert a new record
	                    try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
	                        insertStmt.setString(1, empId);
	                        insertStmt.setString(2, jobTitle);
	                        insertStmt.setDouble(3, salary);
	                        
	                        int rowsInserted = insertStmt.executeUpdate();
	                        return rowsInserted > 0;
	                    }
	                }
	            }
	        } else {
	            // Employee ID does not exist in the employee table
	            System.out.println("Employee ID " + empId + " not found. Operation aborted.");
	            return false;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	//reset employee password
	public static boolean resetEmployeePassword(String empId) {
		String sql = "UPDATE employee SET password = ? WHERE emp_id = ?";
        String defaultPassword = "def123";  // Set a default password

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, defaultPassword);
            pstmt.setString(2, empId);
            
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
	}
	
	//Get the image through id
	public static InputStream getImageByEmpId(String empId, String type) {
		InputStream imageStream = null;
		try(Connection conn = DBConnection.getConnection()){
			String query = "SELECT "+type+ " FROM employee WHERE emp_id=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, empId);
			
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				imageStream = rs.getBinaryStream(1);
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return imageStream;
	}
	
	//Method to update profile picture
	public static boolean updateProfilePicture(String empId, InputStream profilePic) {
		boolean status = false;
		try(Connection conn = DBConnection.getConnection()){
			String query = "UPDATE employee SET profile_pic=? WHERE emp_id=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setBinaryStream(1, profilePic);
			ps.setString(2, empId);
			
			int rowAffect = ps.executeUpdate();
			if(rowAffect > 0) {
				status = true;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return status;
	}
	
	//Method to remove profile picture
	public static boolean removeProfilePicture(String empId) {
		boolean status = false;
		try(Connection conn = DBConnection.getConnection()){
			String query = "UPDATE employee SET profile_pic = NULL WHERE emp_id=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, empId);
			
			return ps.executeUpdate() > 0;
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return status;
	}
	
	//Method to change password
	public static boolean changePassword(String empId, String oldPassword, String newPassword) {
		try(Connection con = DBConnection.getConnection()){
			String query = "SELECT password FROM employee WHERE emp_id=?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, empId);
			
			ResultSet rs = ps.executeQuery();
			if(rs.next() && rs.getString("password").equals(oldPassword)) {
				String updateQuery = "UPDATE employee SET password=? WHERE emp_id=?";
				PreparedStatement updatePs = con.prepareStatement(updateQuery);
				updatePs.setString(1, newPassword);
				updatePs.setString(2, empId);
				
				int update = updatePs.executeUpdate();
				if(update > 0) {
					return true;
				}
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}
