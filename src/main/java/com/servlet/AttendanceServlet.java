package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

import com.dao.AttendanceDAO;
import com.model.Attendance;

@WebServlet("/attendanceServlet")
public class AttendanceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String empId = request.getParameter("empId");
		Date attendanceDate = Date.valueOf(request.getParameter("date"));
		String status = request.getParameter("status");
		
		Attendance attendance = new Attendance(empId, attendanceDate, status);
		
		boolean exists = AttendanceDAO.checkAttendanceExists(attendance);
		boolean success = AttendanceDAO.markAttendence(attendance);
		
		response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
		
        if (success) {
            if (exists) {
                response.getWriter().write("updated");  // Attendance was updated
            } else {
                response.getWriter().write("inserted"); // New attendance was inserted
            }
        } else {
            response.getWriter().write("error"); // Something went wrong
        }
	}

}
