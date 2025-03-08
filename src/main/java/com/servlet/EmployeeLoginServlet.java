package com.servlet;

import java.io.IOException;

import com.dao.EmployeeDAO;
import com.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/employeeLoginServlet")
public class EmployeeLoginServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String empId = request.getParameter("id");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		
		Employee employee = EmployeeDAO.validateEmployee(empId, email, password);
		if(employee != null) {
			HttpSession session = request.getSession();
			session.setAttribute("employee", employee);
			response.sendRedirect(request.getContextPath()+"/dashboard/employee.jsp");
		}else {
			response.sendRedirect(request.getContextPath()+"/page/login.jsp?id=1&error=Invalid Employee Credentials");
		}
		
	}
}
