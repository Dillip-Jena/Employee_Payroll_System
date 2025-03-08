package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import com.dao.AdminDAO;
import com.dao.EmployeeDAO;

@WebServlet("/imageServlet")
public class ImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String adminId = request.getParameter("adminId");
		String employeeId = request.getParameter("employeeId");
		String type = request.getParameter("type");
		
		InputStream imageStream = null;
		
		if(adminId != null) {
			imageStream = AdminDAO.getImageByAdminId(adminId, type);
		}else if(employeeId != null) {
			imageStream = EmployeeDAO.getImageByEmpId(employeeId, type);
		}
		
		if(imageStream != null) {
			response.setContentType("image/png");
			OutputStream output = response.getOutputStream();
			byte[] buffer = new byte[1024];
			int bytesRead;
			while((bytesRead = imageStream.read(buffer)) != -1) {
				output.write(buffer, 0, bytesRead);
			}
			imageStream.close();
			output.close();
		}else {
			response.sendRedirect(request.getContextPath()+"/images/admin-profile-pic.jpg");
		}
	}
}
