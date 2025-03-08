package com.servlet.comp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.dao.ProblemDAO;
import com.model.Employee;

@WebServlet("/raiseProblemServlet")
public class RaiseProbelmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		Employee emp = (Employee) request.getSession().getAttribute("employee");
		
		if(emp == null) {
			response.sendRedirect("/page/home.jsp");
			return;
		}
		
		String problemText = request.getParameter("problemText");
        if (problemText == null || problemText.trim().isEmpty()) {
            response.getWriter().write("error");
            return;
        }
        
        boolean isSaved = ProblemDAO.saveProblem(emp.getEmpId(), emp.getAdminId(), request.getParameter("problemText"));
        if(isSaved) {
        	response.getWriter().write("success");
        }
        else {
        	response.getWriter().write("error");
        }
	}

}
