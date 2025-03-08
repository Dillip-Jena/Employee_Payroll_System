<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Contact - Employee Payroll System</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body, html {
            height: 100%;
        }
        .wrapper {
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Full height */
        }
        .content {
            flex: 1; /* Pushes footer to bottom */
        }
        .card {
            transition: 0.3s;
        }
        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>

    <div class="wrapper">
        <%@ include file="../component/header.jsp" %>

        <!-- Page Content -->
        <div class="content">
            <div class="container mt-4 text-center">
                <h2>Contact &amp; Information</h2>
                <p class="text-muted">Explore options below to learn more about our system.</p>
            </div>

            <!-- Cards Section -->
            <div class="container mt-4">
                <div class="row">
                    <!-- Register New Company -->
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <h5 class="card-title">Register New Company</h5>
                                <p class="card-text">Start managing payroll efficiently by registering your company and get new admin credentials.</p>
                                <a href="<%=request.getContextPath()%>/page/adminRegister.jsp" class="btn btn-primary">Register Now</a>
                            </div>
                        </div>
                    </div>

                    <!-- Services -->
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <h5 class="card-title">Our Services</h5>
                                <p class="card-text">Explore payroll management, tax calculations, and salary processing services.</p>
                                <a href="#" class="btn btn-success">View Services</a>
                            </div>
                        </div>
                    </div>

                    <!-- About Employee Payroll System -->
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <h5 class="card-title">About This Platform</h5>
                                <p class="card-text">Learn more about how our Employee Payroll System helps organizations.</p>
                                <a href="#" class="btn btn-info">Read More</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Back Button -->
            <div class="container text-center mt-4">
                <a href="home.jsp" class="btn btn-danger"><i class="fa-solid fa-arrow-left"></i> Back to Home</a>
            </div>
        </div>

        <!-- Footer -->
        <div class="mt-auto">
            <%@ include file="../component/footer.jsp" %>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
