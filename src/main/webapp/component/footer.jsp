<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="links.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">

<footer style="background: linear-gradient(90deg, #004085, #0056b3); color: #fff; padding: 20px 0;"> <!-- Reduced padding -->
    <div class="container-fluid px-5">
        <div class="row text-center">
            <!-- About Section -->
            <div class="col-lg-4 col-md-6 col-12">
                <h5 class="fw-bold">Employee Payroll System</h5>
                <p class="text-light mb-1">  <!-- Reduced bottom margin -->
                    A secure and efficient system to manage employee salaries, benefits, and tax calculations seamlessly.
                </p>
            </div>

            <!-- Useful Links - Aligned Horizontally -->
            <div class="col-lg-4 col-md-6 col-12">
                <h5 class="fw-bold">Useful Links</h5>
                <ul class="list-unstyled d-flex justify-content-center gap-3 flex-wrap mb-1">  <!-- Reduced spacing -->
                    <li><a href="index.jsp" class="footer-link"><i class="fa fa-home"></i> Home</a></li>
                    <li><a href="about.jsp" class="footer-link"><i class="fa fa-info-circle"></i> About</a></li>
                    <li><a href="contact.jsp" class="footer-link"><i class="fa fa-envelope"></i> Contact</a></li>
                    <li><a href="help.jsp" class="footer-link"><i class="fa fa-question-circle"></i> Help</a></li>
                </ul>
            </div>

            <!-- Social Media Links -->
            <div class="col-lg-4 col-md-12 col-12">
                <h5 class="fw-bold">Follow Us</h5>
                <div class="social-icons d-flex justify-content-center gap-3 mb-1">
                    <a href="#" class="social-link"><i class="fab fa-facebook"></i> Facebook</a>
                    <a href="#" class="social-link"><i class="fab fa-twitter"></i> Twitter</a>
                    <a href="#" class="social-link"><i class="fab fa-linkedin"></i> Linkedin</a>
                    <a href="#" class="social-link"><i class="fab fa-instagram"></i> Instagram</a>
                </div>
            </div>
        </div>

        <!-- Footer Bottom -->
        <div class="text-center mt-2 footer-bottom"> <!-- Reduced top margin -->
            <p class="mb-0 text-light">&copy; 2025 Employee Payroll System. All Rights Reserved.</p>
        </div>
    </div>
</footer>

