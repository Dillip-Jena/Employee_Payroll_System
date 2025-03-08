package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;

import com.dao.AdminDAO;
import com.dao.EmployeeDAO;

@WebServlet("/uploadProfilePicServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) //limit file size to 5MB
public class UploadProfilePicServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		String userId = request.getParameter("userId");
		String userType = request.getParameter("userType");
		Part filePart = request.getPart("profilePic");
		
		if (filePart != null && filePart.getSize() > 0) {
            InputStream fileContent = filePart.getInputStream();
            
            boolean isUpdated = false;
            
            if ("admin".equalsIgnoreCase(userType)) {
                isUpdated = AdminDAO.updateProfilePicture(userId, fileContent);
            } else if ("employee".equalsIgnoreCase(userType)) {
                isUpdated = EmployeeDAO.updateProfilePicture(userId, fileContent);
            }
            
            if (isUpdated) {
                response.sendRedirect(request.getContextPath() + "/dashboard/" + userType + ".jsp?success=Profile updated successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/dashboard/" + userType + ".jsp?error=Failed to update profile picture");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/dashboard/" + userType + ".jsp?error=No file selected");
        }
	}

}
