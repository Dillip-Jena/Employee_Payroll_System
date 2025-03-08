package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.dao.AdminDAO;
import com.model.Admin;

@WebServlet("/adminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String adminId = request.getParameter("id");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		Admin admin = AdminDAO.validateAdmin(adminId, email, password);
		if(admin != null) {
			HttpSession session = request.getSession();
			session.setAttribute("admin", admin);
			response.sendRedirect(request.getContextPath()+"/dashboard/admin.jsp");
		}else {
			response.sendRedirect(request.getContextPath()+"/page/login.jsp?id=0&error=Invalid Admin Credentials");
		}
	}

}
