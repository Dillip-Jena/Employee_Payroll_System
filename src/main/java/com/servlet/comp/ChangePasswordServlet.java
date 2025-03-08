package com.servlet.comp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.dao.AdminDAO;
import com.dao.EmployeeDAO;

@WebServlet("/changePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userType = request.getParameter("userType");
		String userId = request.getParameter("userId");
		String oldPassword = request.getParameter("oldPassword");
		String newPassword = request.getParameter("newPassword");
		
		boolean isUpdated = false;
		int id = -1;
		
		if("admin".equals(userType)) {
			isUpdated = AdminDAO.changePassword(userId, oldPassword, newPassword);
			id = 0;
		}
		else if("employee".equals(userType)) {
			isUpdated = EmployeeDAO.changePassword(userId, oldPassword, newPassword);
			id = 1;
		}
		
		if(isUpdated) {
			session.invalidate();
			response.sendRedirect(request.getContextPath()+"/page/login.jsp?&id="+id);
		}else {
			response.sendRedirect(request.getContextPath()+"/component/changePassword.jsp?error=Old Password incorrect or update failed. Try again.");
		}
	}

}
