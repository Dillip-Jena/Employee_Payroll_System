<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home Page</title>
	<%@ include file="../component/links.jsp" %>
	<style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            scroll-behavior: smooth;
        }
        .content {
            flex: 1;
        }
        .home-section {
            height: 100vh;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 20px;
        }
        .home-section h1 {
            font-size: 3rem;
            animation: fadeInDown 1s ease-in-out;
        }
        .home-section p {
            font-size: 1.3rem;
            animation: fadeInUp 1s ease-in-out;
        }
        .btn-custom {
		    background-color: #ff6b6b !important; /* Ensure the background color applies */
		    color: white !important;
		    padding: 12px 24px;
		    font-size: 18px;
		    border-radius: 5px;
		    transition: background-color 0.3s ease, transform 0.2s ease;
		    animation: fadeIn 1.5s ease-in-out;
		}
		
		.btn-custom:hover {
		    background-color: #3742fa !important; /* Ensure hover color change applies */
		    transform: scale(1.05);
		}

        /* About Section */
        .about-section {
            padding: 80px 20px;
            background-color: #f8f9fa;
        }
        .about-img {
            max-width: 100%;
            border-radius: 10px;
            /*box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);*/
        }
        .about-section h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }
        .about-section p {
            font-size: 1.2rem;
            color: #333;
        }

        /* Animations */
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>
</head>
<body>
	<%@ include file="../component/header.jsp" %>
	
	<div class="content">
		
		<!-- Home Section -->
	    <section id="home" class="home-section">
	        <div class="container">
	            <h1>Welcome to Employee PayRoll System</h1>
	            <p>Manage employee salaries, benefits, and tax deductions with ease. Our payroll system ensures accuracy, compliance, and efficiency.</p>
	            <a href="#about" class="btn btn-custom">Learn More</a>
	        </div>
	    </section>
	
	    <!-- About Section -->
	    <section id="about" class="about-section">
	        <div class="container">
	            <div class="row align-items-center">
	                <div class="col-md-6">
	                    <h2>About Us</h2>
	                    <p>
	                        Welcome to Employee Payroll System, your trusted solution for seamless and efficient employee payroll management. Our platform is designed to simplify payroll processing, ensuring accuracy, compliance, and timely payments for businesses of all sizes.
	                    </p>
	                    <p>
	                        With an intuitive interface and automated features, our payroll system eliminates manual errors, reduces administrative workload, and enhances employee satisfaction. Whether you're managing salaries, tax deductions, benefits, or attendance tracking, we provide a comprehensive solution tailored to your needs.
	                    </p>
	                    <a href="<%=request.getContextPath()%>/page/contact.jsp" class="btn btn-custom">Contact Us</a>
	                </div>
	                <div class="col-md-6">
	                    <img src="<%= request.getContextPath() %>/images/about-img.png" alt="About Us" class="about-img">
	                </div>
	            </div>
	        </div>
	    </section>
		
	</div>
	
	<%@ include file="../component/footer.jsp" %>
</body>
</html>