<%@ page import="com.healthCareFoodRecommendation.Model.DiabeticUser" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BMI Calculator - Diabetes Health App</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --success-color: #2ecc71;
            --danger-color: #e74c3c;
            --warning-color: #f39c12;
            --info-color: #1abc9c;
            --accent-color: #9b59b6;
        }
        
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        /* Logged In User Styles */
        .sidebar {
            background: linear-gradient(180deg, var(--secondary-color), var(--primary-color));
            color: white;
            height: 100vh;
            position: fixed;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            width: 250px;
            z-index: 1000;
        }
        
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        
        .dashboard-card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            margin-bottom: 20px;
            border: none;
            height: 100%;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        
        .nav-link {
            color: rgba(255,255,255,0.8);
            border-radius: 5px;
            margin-bottom: 5px;
            transition: all 0.3s;
        }
        
        .nav-link:hover, .nav-link.active {
            background-color: rgba(255,255,255,0.1);
            color: white;
            transform: translateX(5px);
        }
        
        .progress-thin {
            height: 6px;
        }
        
        .bmi-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .bmi-result {
            font-size: 24px;
            font-weight: bold;
            margin: 20px 0;
            text-align: center;
        }
        
        .bmi-category {
            text-align: center;
            padding: 10px;
            border-radius: 5px;
            margin: 10px 0;
            font-weight: bold;
        }
        
        .underweight {
            background-color: #3498db;
            color: white;
        }
        
        .normal {
            background-color: #2ecc71;
            color: white;
        }
        
        .overweight {
            background-color: #f39c12;
            color: white;
        }
        
        .obesity {
            background-color: #e74c3c;
            color: white;
        }
        
        .bmi-chart {
            width: 100%;
            height: 20px;
            margin: 20px 0;
            background: linear-gradient(to right, #3498db, #2ecc71, #f39c12, #e74c3c);
            position: relative;
            border-radius: 10px;
        }
        
        .bmi-pointer {
            position: absolute;
            width: a2px;
            height: 30px;
            top: -5px;
            background-color: #2c3e50;
            transform: translateX(-50%);
        }
        
        .bmi-form label {
            font-weight: bold;
        }
        
        .bmi-form input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        
        .bmi-form button {
            width: 100%;
            background-color: var(--primary-color);
            color: white;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        
        .bmi-form button:hover {
            background-color: #0056b3;
        }
        
        @media (max-width: 991px) {
            .main-content {
                margin-left: 0;
            }
            
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
                padding: 15px;
            }
            
            .sidebar .nav {
                display: flex;
                flex-wrap: wrap;
            }
            
            .sidebar .nav-item {
                width: 50%;
            }
        }
        
        @media (max-width: 767px) {
            .sidebar .nav-item {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<% 
    DiabeticUser user = (DiabeticUser) session.getAttribute("loggedInUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    double userHeight = user.getHeight(); // in cm
    double userWeight = user.getWeight(); // in kg
    double heightInMeters = userHeight / 100.0;
    double userBmi = userWeight / (heightInMeters * heightInMeters);
    String userBmiCategory = "";
    String categoryClass = "";

    if (userBmi < 18.5) {
        userBmiCategory = "Underweight";
        categoryClass = "underweight";
    } else if (userBmi >= 18.5 && userBmi < 24.9) {
        userBmiCategory = "Normal weight";
        categoryClass = "normal";
    } else if (userBmi >= 25 && userBmi < 29.9) {
        userBmiCategory = "Overweight";
        categoryClass = "overweight";
    } else {
        userBmiCategory = "Obesity";
        categoryClass = "obesity";
    }
    
    // For manual BMI calculation
    String manualHeight = request.getParameter("height");
    String manualWeight = request.getParameter("weight");
    
    double manualBmi = 0.0;
    String manualBmiCategory = "";
    String manualCategoryClass = "";
    boolean manualCalculation = false;
    
    if (manualHeight != null && !manualHeight.isEmpty() && manualWeight != null && !manualWeight.isEmpty()) {
        try {
            double height = Double.parseDouble(manualHeight);
            double weight = Double.parseDouble(manualWeight);
            double heightInM = height / 100.0;
            manualBmi = weight / (heightInM * heightInM);
            manualCalculation = true;
            
            if (manualBmi < 18.5) {
                manualBmiCategory = "Underweight";
                manualCategoryClass = "underweight";
            } else if (manualBmi >= 18.5 && manualBmi < 24.9) {
                manualBmiCategory = "Normal weight";
                manualCategoryClass = "normal";
            } else if (manualBmi >= 25 && manualBmi < 29.9) {
                manualBmiCategory = "Overweight";
                manualCategoryClass = "overweight";
            } else {
                manualBmiCategory = "Obesity";
                manualCategoryClass = "obesity";
            }
        } catch (NumberFormatException e) {
            // Handle invalid input
        }
    }
%>

    <div class="sidebar p-4">
        <div class="text-center mb-4">
            <h4><i class="fas fa-utensils me-2"></i>Food Recommendation</h4>
            <div class="progress progress-thin mb-2">
                <div class="progress-bar bg-success" style="width: 90%"></div>
            </div>
            <small>Profile completeness: 90%</small>
        </div>

        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="index.jsp"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="foodRecommendations"><i class="fas fa-utensils me-2"></i>Food Recommendations</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="bmi.jsp"><i class="fas fa-chart-line me-2"></i>BMI Calculator</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="nutritionGuide.jsp"><i class="fas fa-book me-2"></i>Nutrition Guide</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="profileUpdate?id=<%=user.getId()%>"><i class="fas fa-cog me-2"></i>Settings</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="logout.jsp"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
            </li>
        </ul>

        <div class="mt-4 pt-4 border-top">
            <small class="text-muted">Last login: Today</small>
        </div>
    </div>

    <div class="main-content">
        <div class="container">
            <h2 class="mb-4">BMI Calculator</h2>
            
            <div class="row">
                <div class="col-lg-6">
                    <div class="bmi-card">
                        <h3>Your BMI Details</h3>
                        <p>Height: <%= userHeight %> cm</p>
                        <p>Weight: <%= userWeight %> kg</p>
                        
                        <div class="bmi-result">
                            Your BMI: <%= String.format("%.2f", userBmi) %>
                        </div>
                        
                        <div class="bmi-category <%= categoryClass %>">
                            <%= userBmiCategory %>
                        </div>
                        
                        <div class="bmi-chart">
                            <div class="bmi-pointer" style="left: <%= Math.min(Math.max((userBmi / 40) * 100, 0), 100) %>%;"></div>
                        </div>
                        
                        <div class="d-flex justify-content-between small">
                            <span>Underweight<br>&lt;18.5</span>
                            <span>Normal<br>18.5-24.9</span>
                            <span>Overweight<br>25-29.9</span>
                            <span>Obesity<br>&gt;30</span>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6">
                    <div class="bmi-card">
                        <h3>Calculate BMI Manually</h3>
                        <form class="bmi-form" method="post">
                            <div class="mb-3">
                                <label for="height">Height (cm)</label>
                                <input type="number" id="height" name="height" required placeholder="Enter height in cm">
                            </div>
                            <div class="mb-3">
                                <label for="weight">Weight (kg)</label>
                                <input type="number" id="weight" name="weight" required placeholder="Enter weight in kg">
                            </div>
                            <button type="submit" class="btn">Calculate BMI</button>
                        </form>
                        
                        <% if (manualCalculation) { %>
                            <div class="mt-4">
                                <div class="bmi-result">
                                    Calculated BMI: <%= String.format("%.2f", manualBmi) %>
                                </div>
                                
                                <div class="bmi-category <%= manualCategoryClass %>">
                                    <%= manualBmiCategory %>
                                </div>
                                
                                <div class="bmi-chart">
                                    <div class="bmi-pointer" style="left: <%= Math.min(Math.max((manualBmi / 40) * 100, 0), 100) %>%;"></div>
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
            
            <div class="row mt-4">
                <div class="col-12">
                    <div class="bmi-card">
                        <h3>Understanding Your BMI</h3>
                        <p>Body Mass Index (BMI) is a measurement of a person's weight with respect to their height. It's a useful indicator of whether you're at a healthy weight.</p>
                        
                        <table class="table table-bordered mt-3">
                            <thead>
                                <tr>
                                    <th>BMI Range</th>
                                    <th>Weight Status</th>
                                    <th>Health Risk</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Below 18.5</td>
                                    <td>Underweight</td>
                                    <td>Higher risk for health problems</td>
                                </tr>
                                <tr>
                                    <td>18.5 - 24.9</td>
                                    <td>Normal weight</td>
                                    <td>Lower risk for health problems</td>
                                </tr>
                                <tr>
                                    <td>25.0 - 29.9</td>
                                    <td>Overweight</td>
                                    <td>Increased risk for health problems</td>
                                </tr>
                                <tr>
                                    <td>30.0 and above</td>
                                    <td>Obesity</td>
                                    <td>High risk for health problems</td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <h4 class="mt-4">For People with Diabetes</h4>
                        <p>Maintaining a healthy BMI is particularly important for managing diabetes. Weight management can help improve insulin sensitivity and blood glucose control.</p>
                        <p>Always consult with your healthcare provider for personalized advice on weight management and diabetes care.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>