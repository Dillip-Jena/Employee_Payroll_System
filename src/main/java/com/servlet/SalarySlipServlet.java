package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.dao.JobDAO;
import com.model.SalarySlip;

@WebServlet("/salarySlipServlet")
public class SalarySlipServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String empId = request.getParameter("emp_id");
		String month = request.getParameter("month");
		int year = Integer.parseInt(request.getParameter("year"));
		
		SalarySlip slip = JobDAO.getSalarySlip(empId, month, year);
		
		if (slip != null) {
           request.getSession().setAttribute("salarySlip", slip);
           response.sendRedirect(request.getContextPath() + "/dashboard/employee.jsp?page=salarySlip");
        } else {
           response.sendRedirect(request.getContextPath() + "/dashboard/employee.jsp?page=salarySlip&error1=Salary slip not found.");
        }
	}

}
