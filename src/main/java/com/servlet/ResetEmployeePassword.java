package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.dao.EmployeeDAO;

@WebServlet("/resetEmpPassword")
public class ResetEmployeePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String empId = request.getParameter("empId");
		
		boolean success = EmployeeDAO.resetEmployeePassword(empId);
		if(success) {
			response.getWriter().write("Password reset successfully");
		}
		else {
			response.getWriter().write("Error resetting password");
		}
	}

}
