package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.dao.AdminDAO;
import com.dao.EmployeeDAO;

@WebServlet("/removeProfilePicServlet")
public class RemoveProfilePicServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userId = request.getParameter("userId"); // Works for both admin and employee
        String userType = request.getParameter("userType"); // "admin" or "employee"
        
        boolean isRemoved = false;
        
        if ("admin".equalsIgnoreCase(userType)) {
            isRemoved = AdminDAO.removeProfilePicture(userId);
        } else if ("employee".equalsIgnoreCase(userType)) {
            isRemoved = EmployeeDAO.removeProfilePicture(userId);
        }
        
        if (isRemoved) {
            response.sendRedirect(request.getContextPath() + "/dashboard/" + userType + ".jsp?success=Profile picture removed successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/dashboard/" + userType + ".jsp?error=Failed to remove profile picture");
        }
	}

}
