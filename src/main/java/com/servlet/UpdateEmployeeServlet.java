package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

import com.dao.EmployeeDAO;
import com.model.Employee;

@WebServlet("/updateEmployeeServlet")
public class UpdateEmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String empId = request.getParameter("empId");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String contact = request.getParameter("contact");
		String address = request.getParameter("address");
		
		String joiningDateStr = request.getParameter("joiningDate");
		Date joiningDate = null;

		try {
		    if (joiningDateStr != null && !joiningDateStr.trim().isEmpty()) {
		        joiningDate = Date.valueOf(joiningDateStr); // Converts '2025-10-04' directly
		    }
		} catch (IllegalArgumentException e) {
		    System.out.println("Invalid Date Format Received: " + joiningDateStr);
		    e.printStackTrace();
		}
		
		Employee emp = new Employee();
		emp.setEmpId(empId);
		emp.setName(name);
		emp.setEmail(email);
		emp.setContact(contact);
		emp.setAddress(address);
		emp.setJoiningDate(joiningDate);
		
		EmployeeDAO.updateEmployee(emp);
	}

}
