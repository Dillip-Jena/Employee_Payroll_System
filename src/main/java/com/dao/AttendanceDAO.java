package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.connection.DBConnection;
import com.model.Attendance;

public class AttendanceDAO {
	
	public static boolean checkAttendanceExists(Attendance attendance) {
		boolean exists = false;
		try(Connection conn = DBConnection.getConnection()){
			String query = "SELECT COUNT(*) FROM attendance WHERE emp_id=? AND attendance_date=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, attendance.getEmpId());
			ps.setDate(2, attendance.getAttendenceDate());
			
			ResultSet rs = ps.executeQuery();
			if(rs.next()&&rs.getInt(1)>0) {
				exists = true;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return exists;
	}
	
	public static boolean markAttendence(Attendance attendance) {
		boolean result = false;
		try(Connection conn = DBConnection.getConnection()){
			if(checkAttendanceExists(attendance)) {
				String updateQuery = "UPDATE attendance SET status=? WHERE emp_id=? AND attendance_date=?";
				PreparedStatement ps = conn.prepareStatement(updateQuery);
				ps.setString(1, attendance.getStatus());
				ps.setString(2, attendance.getEmpId());
				ps.setDate(3, attendance.getAttendenceDate());
				
				int rowAffect = ps.executeUpdate();
				if(rowAffect > 0) {
					result = true;
				}
			}
			else {
				String insertQuery = "INSERT INTO attendance(emp_id, attendance_date, status) VALUES(?, ?, ?)";
				PreparedStatement ps = conn.prepareStatement(insertQuery);
				ps.setString(1, attendance.getEmpId());
				ps.setDate(2, attendance.getAttendenceDate());
				ps.setString(3, attendance.getStatus());
				
				int rowAffect = ps.executeUpdate();
				if(rowAffect > 0) {
					result = true;
				}
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//Get number of present days for the given employee, month and year
	public static int getPresentDays(String empId, String month, int year) {
		int presentDays = 0;
		try(Connection conn = DBConnection.getConnection()){
			String query = "SELECT COUNT(*) FROM attendance " +
                    "WHERE emp_id = ? " +
                    "AND DATE_FORMAT(attendance_date, '%M') = ? " +
                    "AND YEAR(attendance_date) = ? " +
                    "AND status = 'Present'";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, empId);
			ps.setString(2, month);
			ps.setInt(3, year);
			
			System.out.println("Executing SQL: " + query);
	        System.out.println("Parameters: empId=" + empId + ", month=" + month + ", year=" + year);
			
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				presentDays = rs.getInt(1);
			}
			System.out.println("Present Days: " + presentDays);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return presentDays;
	}
	
	//Get the employee's salary form the job_detail table
	public static double getSalary(String empId) {
		double salary = 0;
		try(Connection conn = DBConnection.getConnection()){
			String query = "SELECT salary FROM job_details WHERE emp_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, empId);
			
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				salary = rs.getDouble("salary");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return salary;
	}
	
	//Calculate the total salary based on present days
	public static double calculateSalary(String empId, int daysPresent) {
		double monthlySalary = getSalary(empId);
		int totalWorkingDays = 26;
		double dailySalary = monthlySalary / totalWorkingDays;
		double totalSalary = daysPresent * dailySalary;
		
		return Math.round(totalSalary * 100.0) / 100.0;
	}
	
	public static boolean saveOrUpdateAttendance(String empId, String adminId, int days, String month, int year, double salary) {
		boolean isSaved = false;
        String checkSql = "SELECT COUNT(*) FROM salary_slip WHERE emp_id = ? AND month = ? AND year = ?";
        String updateSql = "UPDATE salary_slip SET days = ? WHERE emp_id = ? AND month = ? AND year = ?";
        String insertSql = "INSERT INTO salary_slip (emp_id, admin_id, days, month, year, salary) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {

            checkStmt.setString(1, empId);
            checkStmt.setString(2, month);
            checkStmt.setInt(3, year);

            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) { 
                    // If record exists, update days only
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setInt(1, days);
                        updateStmt.setString(2, empId);
                        updateStmt.setString(3, month);
                        updateStmt.setInt(4, year);
                        int rowsUpdated = updateStmt.executeUpdate();
                        isSaved = rowsUpdated > 0;
                    }
                } else {
                    // If no record exists, insert a new one
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                        insertStmt.setString(1, empId);
                        insertStmt.setString(2, adminId);
                        insertStmt.setInt(3, days);
                        insertStmt.setString(4, month);
                        insertStmt.setInt(5, year);
                        insertStmt.setDouble(6, salary);
                        int rowsInserted = insertStmt.executeUpdate();
                        isSaved = rowsInserted > 0;
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSaved;
	}
	
	//method to get list of attendence 
	public static List<Attendance> getAttendence(String empId, int year, int month){
		List<Attendance> attendanceList = new ArrayList<>();
		try(Connection conn = DBConnection.getConnection()){
			String query = "SELECT * FROM attendance WHERE emp_id=? AND YEAR(attendance_date)=? AND MONTH(attendance_date)=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, empId);
			ps.setInt(2, year);
			ps.setInt(3, month);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				Attendance attendance = new Attendance();
				attendance.setAttendenceDate(rs.getDate("attendance_date"));
				attendance.setStatus(rs.getString("status"));
				attendanceList.add(attendance);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return attendanceList;
	}
}
