package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.dao.AttendanceDAO;
import com.model.Attendance;

@WebServlet("/employeeAttendance")
public class EmployeeAttendance extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String empId = request.getParameter("empId");
		int year = Integer.parseInt(request.getParameter("year"));
		int month = Integer.parseInt(request.getParameter("month"));
		
		List<Attendance> list = AttendanceDAO.getAttendence(empId, year, month);
		
		// Store the attendance list in session so it persists after redirect
		request.getSession().setAttribute("attendanceList", list);
		request.getSession().setAttribute("empId", empId);

		// Redirect to employee.jsp with page=attendance to load attendance.jsp dynamically
		response.sendRedirect(request.getContextPath() + "/dashboard/employee.jsp?page=attendance");
	}

}
