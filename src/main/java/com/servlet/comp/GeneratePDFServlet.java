package com.servlet.comp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;


@WebServlet("/generateSalarySlipPDF")
public class GeneratePDFServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {

        // Retrieve parameters
        String empId = request.getParameter("emp_id");
        String empName = request.getParameter("emp_name");
        String email = request.getParameter("email");
        String jobTitle = request.getParameter("job_title");
        String companyName = request.getParameter("company_name");
        String month = request.getParameter("month");
        String year = request.getParameter("year");
        String daysStr = request.getParameter("days");
        String salaryStr = request.getParameter("salary");

        // Validate data
        if (empId == null || empId.trim().isEmpty() || month == null || year == null || daysStr == null || salaryStr == null) {
            response.getWriter().write("Invalid Salary Slip Data");
            return;
        }

        // Convert numerical values
        int days = Integer.parseInt(daysStr);
        double salary = Double.parseDouble(salaryStr);

        try {
            // Set response headers for PDF download
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=SalarySlip_" + month + "_" + year + ".pdf");

            // Create PDF document
            Document document = new Document();
            OutputStream outStream = response.getOutputStream();
            PdfWriter.getInstance(document, outStream);

            document.open();

            // Add Company Logo 
            try {
                String logoUrl = "http://localhost:8082" + request.getContextPath() + "/imageServlet?adminId=" + request.getParameter("admin_id") + "&type=company_logo";
                System.out.println("Fetching logo from URL: " + logoUrl);
                // Open connection to imageServlet
                URI uri = new URI(logoUrl);
                URL url = uri.toURL();
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setRequestMethod("GET");
                connection.setDoInput(true);
                
                // Read image data into byte array
                InputStream inputStream = connection.getInputStream();
                ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    byteArrayOutputStream.write(buffer, 0, bytesRead);
                }
                
                byte[] imageBytes = byteArrayOutputStream.toByteArray();
                inputStream.close();
                connection.disconnect();
                
                // Convert byte array to Image object
                Image logo = Image.getInstance(imageBytes);
                logo.scaleToFit(100, 50);
                logo.setAlignment(Element.ALIGN_CENTER);
                logo.setSpacingAfter(20);
                document.add(logo);
            } catch (Exception e) {
                System.out.println("Company logo not found.");
            }

            // Add Salary Slip Title
            Font titleFont = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD, BaseColor.WHITE);
            Paragraph title = new Paragraph("Salary Slip - " + month + " " + year, titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(10);

            // Create header with background color
            PdfPTable headerTable = new PdfPTable(1);
            headerTable.setWidthPercentage(100);
            PdfPCell headerCell = new PdfPCell(title);
            headerCell.setBackgroundColor(BaseColor.BLUE);
            headerCell.setPadding(10);
            headerCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            headerTable.addCell(headerCell);
            document.add(headerTable);

            // Add Employee Info Table
            PdfPTable empTable = new PdfPTable(2);
            empTable.setWidthPercentage(100);
            empTable.setSpacingBefore(20);

            empTable.addCell("Employee ID:");
            empTable.addCell(empId);

            empTable.addCell("Name:");
            empTable.addCell(empName != null ? empName : "N/A");

            empTable.addCell("Job Title:");
            empTable.addCell(jobTitle != null ? jobTitle : "N/A");

            empTable.addCell("Email:");
            empTable.addCell(email != null ? email : "N/A");

            empTable.addCell("Company:");
            empTable.addCell(companyName != null ? companyName : "N/A");

            document.add(empTable);

            // Add Salary Details
            PdfPTable salaryTable = new PdfPTable(2);
            salaryTable.setWidthPercentage(100);
            salaryTable.setSpacingBefore(20);

            salaryTable.addCell("Month:");
            salaryTable.addCell(month);

            salaryTable.addCell("Year:");
            salaryTable.addCell(year);

            salaryTable.addCell("Working Days:");
            salaryTable.addCell(String.valueOf(days));

            PdfPCell salaryCell = new PdfPCell(new Phrase("Salary Amount"));
            salaryCell.setBackgroundColor(BaseColor.LIGHT_GRAY);
            salaryTable.addCell(salaryCell);
            salaryTable.addCell("₹ " + salary);

            document.add(salaryTable);

            // Closing document
            document.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error generating PDF");
        }
    }
}
