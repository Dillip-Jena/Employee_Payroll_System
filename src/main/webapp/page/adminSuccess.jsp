<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Registration Success</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        .card {
            border-radius: 10px;
        }
        .table {
            margin-top: 20px;
        }
        .btn-login {
            width: auto;
            font-size: 18px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-lg">
                <div class="card-header bg-success text-white text-center">
                    <h3>Registration Successful! 🎉</h3>
                </div>
                <div class="card-body">
                    <p class="text-center">Here are your details:</p>
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <th>Admin ID:</th>
                                <td><strong><%= request.getAttribute("adminId") %></strong></td>
                            </tr>
                            <tr>
                                <th>Email:</th>
                                <td><%= request.getAttribute("email") %></td>
                            </tr>
                            <tr>
                                <th>Password:</th>
                                <td><%= request.getAttribute("password") %></td>
                            </tr>
                        </tbody>
                    </table>
                    <p class="text-danger text-center">⚠️ Please save this information securely.</p>
                    <a href="${pageContext.request.contextPath}/page/login.jsp?id=0" class="btn btn-success btn-login">Login Now</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
