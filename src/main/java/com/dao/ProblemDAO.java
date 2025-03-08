package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.connection.DBConnection;
import com.model.Complaint;

public class ProblemDAO {
	
	public static boolean saveProblem(String empId, String adminId, String problemText) {
		try (Connection con = DBConnection.getConnection()) {
	        // Check if emp_id already exists
	        String checkQuery = "SELECT COUNT(*) FROM problems WHERE emp_id = ?";
	        PreparedStatement checkPs = con.prepareStatement(checkQuery);
	        checkPs.setString(1, empId);
	        
	        ResultSet rs = checkPs.executeQuery();
	        if (rs.next() && rs.getInt(1) > 0) {
	            // emp_id exists, update the problem_text
	            String updateQuery = "UPDATE problems SET problem_text = ?, admin_id = ?, created_at = CURRENT_TIMESTAMP WHERE emp_id = ?";
	            PreparedStatement updatePs = con.prepareStatement(updateQuery);
	            updatePs.setString(1, problemText);
	            updatePs.setString(2, adminId);
	            updatePs.setString(3, empId);
	            
	            int rowsUpdated = updatePs.executeUpdate();
	            return rowsUpdated > 0;
	        } else {
	            // emp_id does not exist, insert new record
	            String insertQuery = "INSERT INTO problems (emp_id, admin_id, problem_text) VALUES (?, ?, ?)";
	            PreparedStatement insertPs = con.prepareStatement(insertQuery);
	            insertPs.setString(1, empId);
	            insertPs.setString(2, adminId);
	            insertPs.setString(3, problemText);
	            
	            int rowsInserted = insertPs.executeUpdate();
	            return rowsInserted > 0;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	//Method to get the list of complaints
	public static List<Complaint> getComplaints(String adminId){
		List<Complaint> complaints = new ArrayList<>();
		
		try(Connection con = DBConnection.getConnection()){
			String query = "SELECT id, emp_id, problem_text, DATE(created_at) AS complaint_date FROM problems WHERE admin_id=? ORDER BY created_at DESC";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, adminId);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				complaints.add(new Complaint(
							rs.getInt("id"),
							rs.getString("emp_id"),
							rs.getString("problem_text"),
							rs.getString("complaint_date")
						));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return complaints;
	}
	
	//Method to delete complaint
	public static boolean deleteComplaint(int id) {
		try(Connection con = DBConnection.getConnection()){
			String query = "DELETE FROM problems WHERE id=?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);
			
			int rowAffect = ps.executeUpdate();
			if(rowAffect > 0) {
				return true;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}
