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
import java.time.LocalDate;

import com.dao.AdminDAO;
import com.model.Admin;

@WebServlet("/adminRegisterServlet")
@MultipartConfig(maxFileSize = 16177215)
public class AdminRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		try {
			// Get text fields properly
	        String name = getParameterValue(request.getPart("name"));
	        String email = getParameterValue(request.getPart("email"));
	        String password = getParameterValue(request.getPart("password"));
	        String company = getParameterValue(request.getPart("company"));

			Part profilePart = request.getPart("adminlogo");
			Part logoPart = request.getPart("companylogo");
			
			//convert images to inputstream
			InputStream profileStream = (profilePart != null) ? profilePart.getInputStream() : null;
			InputStream logoStream = (logoPart != null) ? logoPart.getInputStream() : null;
			
			String adminId;
			do {
				adminId = generateUniqueId();
			}while(AdminDAO.isAdminIdExists(adminId));
			
			Date activationDate = Date.valueOf(LocalDate.now());
			
			//create an admin object
			Admin admin = new Admin(adminId, name, email, password, activationDate, company);
			admin.setProfilePic(profileStream);
			admin.setCompanyLogo(logoStream);
			
			boolean isRegistered =  AdminDAO.registerAdmin(admin);
			if(isRegistered) {
				request.setAttribute("adminId", adminId);
				request.setAttribute("email", email);
				request.setAttribute("password", password);
				request.getRequestDispatcher("/page/adminSuccess.jsp").forward(request, response);
			}
			else {
				response.sendRedirect(request.getContextPath()+"/page/adminRegister.jsp?error=Registration failed.");
			}
		}catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath()+"/page/adminRegister.jsp?error=Something went wrong.");
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
	
	private String generateUniqueId() {
		return String.format("%04d", (int) (Math.random() * 10000));
	}
}
