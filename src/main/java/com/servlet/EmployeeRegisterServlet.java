package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Date;

import com.dao.EmployeeDAO;
import com.model.Employee;

@WebServlet("/employeeRegisterServlet")
@MultipartConfig(maxFileSize = 16177215)
public class EmployeeRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String name = getParameterValue(request.getPart("name"));
		String email = getParameterValue(request.getPart("email"));
		String contact = getParameterValue(request.getPart("contact_no"));
		String address = getParameterValue(request.getPart("address"));
		String joiningDateStr = request.getParameter("joining_date"); // Fetch as string
	    Date joiningDate = (joiningDateStr != null && !joiningDateStr.isEmpty()) ? Date.valueOf(joiningDateStr) : null;
		String password = getParameterValue(request.getPart("password"));
		String adminId = request.getParameter("admin_id");
		
		String employeeId = EmployeeDAO.generateUniqueEmployeeId();
		Part filePart = request.getPart("profile_pic");
		InputStream profilePic = filePart != null ? filePart.getInputStream() : null;
		
		Employee employee = new Employee(employeeId, name, email, password, contact, address, joiningDate, adminId, profilePic);
		
		boolean isInserted = EmployeeDAO.addEmployee(employee);
		if(isInserted) {
			String message = "Employee register successfully with ID: "+employeeId;
			response.sendRedirect(request.getContextPath()+"/dashboard/admin.jsp?success1="+message+ "&page=addEmployee");
		}else {
			response.sendRedirect(request.getContextPath()+"/dashboard/admin.jsp?error1=Failed to register employee.&page=addEmployee");
		}
	}
	
	private String getParameterValue(Part part) throws IOException {
        if (part == null) return null;
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), StandardCharsets
        		.UTF_8))) {
            StringBuilder value = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                value.append(line);
            }
            return value.toString().trim();
        }
    }

}
