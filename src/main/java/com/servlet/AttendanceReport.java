package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.dao.AttendanceDAO;
import com.google.gson.JsonObject;

@WebServlet("/attendanceReport")
public class AttendanceReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		String empId = request.getParameter("empId");
		String month = request.getParameter("month");
		int year = Integer.parseInt(request.getParameter("year"));
		
		JsonObject jsonResponse = new JsonObject();
		
		try {
			int daysPresent = AttendanceDAO.getPresentDays(empId, month, year);
			double totalSalary = AttendanceDAO.calculateSalary(empId, daysPresent);
			
			jsonResponse.addProperty("success", true);
			jsonResponse.addProperty("daysPresent", daysPresent);
			jsonResponse.addProperty("totalSalary", totalSalary);
		}catch(Exception e) {
			jsonResponse.addProperty("success", false);
			jsonResponse.addProperty("message", "Error fetching data: "+e.getMessage());
		}
		
		out.print(jsonResponse);
		out.flush();
	}

}
