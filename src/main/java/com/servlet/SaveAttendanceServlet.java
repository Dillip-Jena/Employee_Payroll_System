package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.dao.AttendanceDAO;

@WebServlet("/saveAttendanceServlet")
public class SaveAttendanceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String empId = request.getParameter("empId");
		String adminId = request.getParameter("adminId");
		int days = Integer.parseInt(request.getParameter("days"));
		String month = request.getParameter("month");
		int year = Integer.parseInt(request.getParameter("year"));
		double salary = Double.parseDouble(request.getParameter("salary"));
		
		if (empId == null || adminId == null || month == null || empId.isEmpty() || adminId.isEmpty() || month.isEmpty()) {
            response.getWriter().write("error: missing parameters");
            return;
        }
		
		boolean isSaved = AttendanceDAO.saveOrUpdateAttendance(empId, adminId, days, month, year, salary);
		if (isSaved) {
            response.getWriter().write("success");
        } else {
            response.getWriter().write("error");
        }
	}
}
