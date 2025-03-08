package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.dao.EmployeeDAO;

@WebServlet("/saveOrUpdateEmpSalary")
public class UpdateEmployeeSalaryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String empId = request.getParameter("empId");
		String jobTitle = request.getParameter("jobTitle");
		double salary = Double.parseDouble(request.getParameter("salary"));
		
		boolean success = EmployeeDAO.updateEmployeeJob(empId, jobTitle, salary);
		if(success) {
			response.setStatus(HttpServletResponse.SC_OK); // 200 Success
            response.getWriter().write("Employee details updated successfully");
		}
		else {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404 Not Found
            response.getWriter().write("Error: Employee not found or update failed.");
		}
	}

}
