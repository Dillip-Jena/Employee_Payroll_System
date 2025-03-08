package com.servlet.comp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.dao.ProblemDAO;

@WebServlet("/DeleteComplaintServlet")
public class DeleteComplaintServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		int complaintId = Integer.parseInt(request.getParameter("complaintId"));
		System.out.println("debug complaintId: "+complaintId);
		
		boolean deleted = ProblemDAO.deleteComplaint(complaintId);
		
		if(deleted) {
			response.sendRedirect(request.getContextPath()+"/dashboard/admin.jsp?page=complaints&success1=Complaint resolved successfully.");
		}
		else {
			response.sendRedirect(request.getContextPath()+"/dashboard/admin.jsp?page=complaints&error1=Failed to resolve complaint");
		}
	}

}
