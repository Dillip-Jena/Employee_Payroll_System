package com.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.connection.DBConnection;
import com.model.Admin;

public class AdminDAO {
	
	//To validate the admin and get the admin object
	public static Admin validateAdmin(String adminId, String email, String password) {
		Admin admin = null;
		try(Connection con = DBConnection.getConnection()){
			PreparedStatement ps = con.prepareStatement("SELECT * FROM admin WHERE admin_id = ? AND email = ? AND password = ?");
			ps.setString(1, adminId);
			ps.setString(2, email);
			ps.setString(3, password);
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()) {
				admin = new Admin(
						rs.getString("admin_id"),
						rs.getString("name"),
						rs.getString("email"),
						rs.getString("password"),
						rs.getDate("activation_date"),
						rs.getString("company_name")
						);	
				
				//Fetching image streams from the database
				InputStream profilePicStream = rs.getBinaryStream("profile_pic");
				InputStream companyLogoStream = rs.getBinaryStream("company_logo");
				
				admin.setProfilePic(profilePicStream);
				admin.setCompanyLogo(companyLogoStream);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return admin;
	}
	
	//Check if Admin ID exists
	public static boolean isAdminIdExists(String adminId) {
		boolean exists = false;
		try(Connection con = DBConnection.getConnection()){
			String query = "SELECT admin_id FROM admin WHERE admin_id = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, adminId);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return exists;
	}
	
	//Register a New Admin
	public static boolean registerAdmin(Admin admin) {
		boolean status = false;
		try(Connection con = DBConnection.getConnection()){
			String query = "INSERT INTO admin (admin_id, name, email, password, activation_date, company_name, profile_pic, company_logo) VALUES (?,?,?,?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, admin.getAdminId());
			ps.setString(2, admin.getName());
			ps.setString(3, admin.getEmail());
			ps.setString(4, admin.getPassword());
			ps.setDate(5, admin.getActivation_date());
			ps.setString(6, admin.getCompany_name());
			
			//For storing the binary data
			if(admin.getProfilePic() != null) {
				ps.setBinaryStream(7, admin.getProfilePic());
			}else {
				ps.setNull(7, java.sql.Types.BLOB);
			}
			if(admin.getCompanyLogo() != null) {
				ps.setBinaryStream(8, admin.getCompanyLogo());
			}else {
				ps.setNull(8, java.sql.Types.BLOB);
			}
			
			int rowAffected = ps.executeUpdate();
			if(rowAffected > 0) {
				status = true;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return status;
	}
	
	//Get the formatted image through id
	public static InputStream getImageByAdminId(String adminId, String type){
		InputStream imageStream = null;
		try(Connection con = DBConnection.getConnection()){
			String query = "SELECT " + type + " FROM admin WHERE admin_id=?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, adminId);
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()) {
				imageStream = rs.getBinaryStream(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return imageStream;
	}
	
	//Method to update profile picture
	public static boolean updateProfilePicture(String adminId, InputStream profilePic) {
		boolean status = false;
		try(Connection con = DBConnection.getConnection()){
			String query = "UPDATE admin SET profile_pic=? WHERE admin_id=?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setBinaryStream(1, profilePic);
			ps.setString(2, adminId);
			
			int rowAffect = ps.executeUpdate();
			if(rowAffect > 0) {
				status = true;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return status;
	}
	
	//Method to Remove Profile Picture
	public static boolean removeProfilePicture(String adminId) {
		boolean status = false;
		try(Connection con = DBConnection.getConnection()){
			String query = "UPDATE admin SET profile_pic = NULL WHERE admin_id=?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, adminId);
			
			int rowAffect = ps.executeUpdate();
			if(rowAffect > 0) {
				status = true;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return status;
	}
	
	//method to fetch company name using admin_id
	public static String getCompanyName(String adminId) {
		String name = null;
		try(Connection conn = DBConnection.getConnection()){
			String query = "SELECT company_name FROM admin WHERE admin_id=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, adminId);
			
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				name = rs.getString("company_name");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return name;
	}
	
	//method to change password
	public static boolean changePassword(String adminId, String oldPassword, String newPassword) {
		try(Connection con = DBConnection.getConnection()){
			String query = "SELECT password FROM admin WHERE admin_id=?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, adminId);
			
			ResultSet rs = ps.executeQuery();
			if(rs.next() && rs.getString("password").equals(oldPassword)) {
				String updateQuery = "UPDATE admin SET password=? WHERE admin_id=?";
				PreparedStatement updatePs = con.prepareStatement(updateQuery);
				updatePs.setString(1, newPassword);
				updatePs.setString(2, adminId);
				
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
