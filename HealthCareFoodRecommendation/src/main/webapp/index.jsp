<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.healthCareFoodRecommendation.Model.DiabeticUser" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%
    // Get user from session
    DiabeticUser user = (DiabeticUser) session.getAttribute("loggedInUser");
    boolean isLoggedIn = (user != null);
    
    // Variables declared only if user is logged in
    double bmi = 0;
    String bmiCategory = "";
    String bmiBadgeClass = "";
    String bloodSugarStatus = "";
    String bloodSugarAlertClass = "";
    String foodRecommendation = "";
    String activityRecommendation = "";
    String mealTiming = "";
    
    // Food recommendations database - defined regardless of login status
    Map<String, Map<String, String>> foodRecommendations = new HashMap<>();
    
    // Type 1 diabetes recommendations
    Map<String, String> type1Recs = new HashMap<>();
    type1Recs.put("Veg", "Quinoa with roasted vegetables (45g carbs) + insulin dose as directed");
    type1Recs.put("Non-Veg", "Grilled salmon with asparagus (30g carbs) + insulin dose as directed");
    foodRecommendations.put("Type 1", type1Recs);
    
    // Type 2 diabetes recommendations
    Map<String, String> type2Recs = new HashMap<>();
    type2Recs.put("Veg", "Lentil soup with whole grain bread (Low glycemic)");
    type2Recs.put("Non-Veg", "Baked chicken with steamed broccoli and cauliflower rice");
    foodRecommendations.put("Type 2", type2Recs);
    
    // Gestational diabetes recommendations
    Map<String, String> gestationalRecs = new HashMap<>();
    gestationalRecs.put("Veg", "Greek yogurt with berries and nuts");
    gestationalRecs.put("Non-Veg", "Turkey and avocado wrap on whole wheat");
    foodRecommendations.put("Gestational", gestationalRecs);
    
    // Default recommendations
    Map<String, String> defaultRecs = new HashMap<>();
    defaultRecs.put("Veg", "Mixed vegetable curry with brown rice");
    defaultRecs.put("Non-Veg", "Grilled fish with quinoa and greens");
    foodRecommendations.put("Other", defaultRecs);
    
    // Calculate user-specific values if logged in
    if(isLoggedIn) {
        // Calculate BMI and category
        double heightInMeters = user.getHeight() / 100;
        bmi = user.getWeight() / (heightInMeters * heightInMeters);
        
        if(bmi < 18.5) {
            bmiCategory = "Underweight";
            bmiBadgeClass = "bg-info";
        } else if(bmi < 25) {
            bmiCategory = "Normal";
            bmiBadgeClass = "bg-success";
        } else if(bmi < 30) {
            bmiCategory = "Overweight";
            bmiBadgeClass = "bg-warning";
        } else {
            bmiCategory = "Obese";
            bmiBadgeClass = "bg-danger";
        }
        
        // Blood sugar analysis
        if(user.getBloodSugarRange() != null && user.getBloodSugarRange().contains("-")) {
            String[] rangeParts = user.getBloodSugarRange().split("-");
            try {
                int lowerRange = Integer.parseInt(rangeParts[0].trim());
                if(lowerRange > 140) {
                    bloodSugarStatus = "High blood sugar detected";
                    bloodSugarAlertClass = "alert-danger";
                } else if(lowerRange < 70) {
                    bloodSugarStatus = "Low blood sugar warning";
                    bloodSugarAlertClass = "alert-warning";
                } else {
                    bloodSugarStatus = "Normal range";
                    bloodSugarAlertClass = "alert-success";
                }
            } catch(NumberFormatException e) {
                bloodSugarStatus = "Monitor regularly";
                bloodSugarAlertClass = "alert-secondary";
            }
        } else {
            bloodSugarStatus = "Monitor regularly";
            bloodSugarAlertClass = "alert-secondary";
        }
        
        // Get appropriate food recommendation
        foodRecommendation = foodRecommendations
            .getOrDefault(user.getDiabetesType(), defaultRecs)
            .get(user.getFoodPreference());
        
        // Activity recommendations based on profession and BMI
        if(user.getJobProfession() != null && user.getJobProfession().toLowerCase().contains("desk")) {
            activityRecommendation = "Desk job detected: Take a 5-minute walk every hour";
            if(bmi >= 25) {
                activityRecommendation += " and aim for 30 minutes of cardio after work";
            }
        } else {
            activityRecommendation = "Aim for 30 minutes of moderate exercise daily";
            if(bmi >= 25) {
                activityRecommendation += ", including strength training twice weekly";
            }
        }
        
        // Meal timing suggestion based on insulin usage
        if("Yes".equals(user.getInsulinUsage())) {
            mealTiming = "Space meals 4-5 hours apart to match insulin peaks";
        } else if(bmi >= 25) {
            mealTiming = "Consider smaller, more frequent meals to manage weight";
        } else {
            mealTiming = "Standard 3 meals per day recommended";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Food Recommendation app</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
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
        
        .bmi-indicator {
            height: 10px;
            border-radius: 5px;
            background: linear-gradient(90deg, 
                var(--primary-color), 
                var(--success-color), 
                var(--warning-color), 
                var(--danger-color));
            margin-top: 5px;
            position: relative;
        }
        
        .bmi-marker {
            position: absolute;
            top: -20px;
            transform: translateX(-50%);
            color: var(--secondary-color);
            font-weight: bold;
            background: white;
            padding: 2px 6px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            font-size: 0.8rem;
        }
        
        .progress-thin {
            height: 6px;
        }
        
        /* Non-Logged In User Styles */
        .public-navbar {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .public-logo {
            font-size: 1.8rem;
            font-weight: 700;
            color: white;
        }
        
        .public-nav-link {
            color: white;
            font-weight: 500;
            margin-left: 20px;
            transition: all 0.3s;
            position: relative;
        }
        
        .public-nav-link:hover {
            color: rgba(255,255,255,0.8);
        }
        
        .public-nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            background: white;
            bottom: -5px;
            left: 0;
            transition: width 0.3s;
        }
        
        .public-nav-link:hover::after {
            width: 100%;
        }
        
        .hero-section {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            padding: 80px 0 60px;
            border-radius: 0 0 15% 15%;
            margin-bottom: 40px;
        }
        
        .feature-card {
            border-radius: 15px;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            height: 100%;
            transition: transform 0.3s;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
        }
        
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: var(--primary-color);
        }
        
        .testimonial-card {
            border-radius: 15px;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 25px;
            margin-bottom: 20px;
            position: relative;
        }
        
        .testimonial-card::before {
            content: '\201C';
            font-size: 5rem;
            position: absolute;
            top: -20px;
            left: 10px;
            color: rgba(52, 152, 219, 0.1);
            font-family: Georgia, serif;
        }
        
        .auth-btn {
            border-radius: 30px;
            padding: 8px 25px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .auth-btn-login {
            background-color: transparent;
            border: 2px solid white;
            color: white;
        }
        
        .auth-btn-login:hover {
            background-color: white;
            color: var(--primary-color);
        }
        
        .auth-btn-signup {
            background-color: white;
            border: 2px solid white;
            color: var(--primary-color);
        }
        
        .auth-btn-signup:hover {
            background-color: rgba(255,255,255,0.9);
        }
        
        .food-recommendation-card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            border: none;
        }
        
        .food-recommendation-header {
            color: white;
            padding: 15px 20px;
        }
        
        .type1-header {
            background: linear-gradient(45deg, #3498db, #2980b9);
        }
        
        .type2-header {
            background: linear-gradient(45deg, #27ae60, #2ecc71);
        }
        
        .gestational-header {
            background: linear-gradient(45deg, #f39c12, #f1c40f);
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
    <% if(isLoggedIn) { %>
    <!-- LOGGED IN USER VIEW -->
    <!-- Sidebar Navigation -->
    <div class="sidebar p-4">
        <div class="text-center mb-4">
            <h4><i class="fas fa-utensils me-2"></i>Food Recommendation </h4>
            <p class="small">Welcome back, <strong><%= user.getName() %></strong>!</p>
            <div class="progress progress-thin mb-2">
                <div class="progress-bar bg-success" style="width: 75%"></div>
            </div>
            <small>Profile completeness: 75%</small>
        </div>
        
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link active" href="index.jsp"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="foodRecommendations"><i class="fas fa-utensils me-2"></i>Food Recommendations</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="bmi.jsp"><i class="fas fa-chart-line me-2"></i>BMI Calculater</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="nutritionGuide.jsp"><i class="fas fa-book me-2"></i>Nutrition Guide</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="profileUpdate?id=<%=user.getId()%>"><i class="fas fa-cog me-2"></i>Settings</a>
            </li>
             <li class="nav-item">
                <a class="nav-link" href="logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
            </li>
        </ul>
        
        <div class="mt-4 pt-4 border-top">
            <small class="text-muted">Last login: Today</small>
        </div>
    </div>

    <!-- Main Content Area -->
    <div class="main-content">
        <!-- Header with Logout -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="text-primary"><i class="fas fa-tachometer-alt me-2"></i>Your Dashboard</h3>
                <p class="text-muted mb-0"><%= user.getDiabetesType() %> Diabetes Management</p>
            </div>
            <a href="logout" class="btn btn-outline-danger"><i class="fas fa-sign-out-alt me-1"></i> Logout</a>
        </div>

        <!-- Dashboard Cards Row 1 -->
        <div class="row">
            <!-- Profile Summary Card -->
            <div class="col-lg-4 col-md-6">
                <div class="card dashboard-card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title"><i class="fas fa-user-circle me-2"></i>Profile Summary</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <div class="flex-shrink-0">
                                <div class="bg-primary text-white rounded-circle p-3 text-center" 
                                     style="width: 60px; height: 60px; line-height: 40px;">
                                    <i class="fas fa-user fa-2x"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5><%= user.getName() %></h5>
                                <p class="mb-0"><%= user.getAge() %> years • <%= user.getGender() %></p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-6 mb-3">
                                <strong>Diabetes Type:</strong> 
                                <span class="badge bg-info mt-1 d-block"><%= user.getDiabetesType() %></span>
                            </div>
                            <div class="col-6 mb-3">
                                <strong>Food Pref:</strong> 
                                <span class="badge bg-success mt-1 d-block"><%= user.getFoodPreference() %></span>
                            </div>
                            <div class="col-6">
                                <strong>Allergies:</strong> 
                                <span class="badge <%= (user.getAllergies() == null || user.getAllergies().isEmpty()) ? 
                                    "bg-secondary" : "bg-warning text-dark" %> mt-1 d-block">
                                    <%= (user.getAllergies() == null || user.getAllergies().isEmpty()) ? 
                                        "None" : user.getAllergies() %>
                                </span>
                            </div>
                            <div class="col-6">
                                <strong>Insulin:</strong> 
                                <span class="badge <%= user.getInsulinUsage().equals("Yes") ? 
                                    "bg-info" : "bg-secondary" %> mt-1 d-block">
                                    <%= user.getInsulinUsage() %>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Health Metrics Card -->
            <div class="col-lg-4 col-md-6">
                <div class="card dashboard-card">
                    <div class="card-header bg-info text-white">
                        <h5 class="card-title"><i class="fas fa-heartbeat me-2"></i>Health Metrics</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-4">
                            <div class="d-flex justify-content-between mb-2">
                                <h6 class="mb-0">Body Mass Index</h6>
                                <span class="badge <%= bmiBadgeClass %>"><%= String.format("%.1f", bmi) %> (<%= bmiCategory %>)</span>
                            </div>
                            <div class="d-flex justify-content-between small text-muted mb-1">
                                <span>Underweight</span>
                                <span>Normal</span>
                                <span>Overweight</span>
                                <span>Obese</span>
                            </div>
                            <div class="bmi-indicator">
                                <div class="bmi-marker" id="bmiMarker">
                                    <%= String.format("%.1f", bmi) %>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <div class="text-center p-2 bg-light rounded">
                                    <h6>Weight</h6>
                                    <h4 class="text-primary"><%= user.getWeight() %> <small class="text-muted">kg</small></h4>
                                    <% if(bmi >= 25) { %>
                                        <small class="text-danger">Consider reducing by 5-10%</small>
                                    <% } else if(bmi < 18.5) { %>
                                        <small class="text-info">Consider healthy weight gain</small>
                                    <% } %>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="text-center p-2 bg-light rounded">
                                    <h6>Height</h6>
                                    <h4 class="text-primary"><%= user.getHeight() %> <small class="text-muted">cm</small></h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Blood Sugar Card -->
            <div class="col-lg-4 col-md-12">
                <div class="card dashboard-card">
                    <div class="card-header bg-warning text-dark">
                        <h5 class="card-title"><i class="fas fa-tint me-2"></i>Blood Sugar</h5>
                    </div>
                    <div class="card-body">
                        <div class="text-center mb-3">
                            <% if(user.getBloodSugarRange() != null && !user.getBloodSugarRange().isEmpty()) { %>
                                <h1 class="display-4"><%= user.getBloodSugarRange() %></h1>
                                <p class="mb-0 text-muted">mg/dL</p>
                            <% } else { %>
                                <div class="alert alert-secondary">No blood sugar data recorded</div>
                            <% } %>
                        </div>
                        <div class="alert <%= bloodSugarAlertClass %>">
                            <i class="fas <%= bloodSugarAlertClass.equals("alert-danger") ? "fa-exclamation-triangle" : 
                                          bloodSugarAlertClass.equals("alert-warning") ? "fa-exclamation-circle" : 
                                          "fa-check-circle" %> me-2"></i>
                            <%= bloodSugarStatus %>
                        </div>
                        <div class="progress progress-thin mb-2">
                            <div class="progress-bar bg-success" style="width: 30%"></div>
                            <div class="progress-bar bg-warning" style="width: 40%"></div>
                            <div class="progress-bar bg-danger" style="width: 30%"></div>
                        </div>
                        <div class="d-flex justify-content-between small text-muted">
                            <span>Low</span>
                            <span>Normal</span>
                            <span>High</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Dashboard Cards Row 2 -->
        <div class="row mt-4">
            <!-- Lifestyle Factors Card -->
            <div class="col-lg-6">
                <div class="card dashboard-card">
                    <div class="card-header bg-secondary text-white">
                        <h5 class="card-title"><i class="fas fa-running me-2"></i>Lifestyle Factors</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <div class="p-3 bg-light rounded">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-smoking <%= user.getSmokingHabit().equals("Yes") ? "text-danger" : "text-success" %> fa-2x"></i>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-1">Smoking</h6>
                                            <p class="mb-0 small"><%= user.getSmokingHabit().equals("Yes") ? 
                                                "<span class='text-danger'>Consider quitting</span> - increases diabetes complications" : 
                                                "<span class='text-success'>Good!</span> No smoking detected" %></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="p-3 bg-light rounded">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-wine-glass-alt <%= user.getAlcoholHabit().equals("Yes") ? "text-warning" : "text-success" %> fa-2x"></i>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-1">Alcohol</h6>
                                            <p class="mb-0 small"><%= user.getAlcoholHabit().equals("Yes") ? 
                                                "<span class='text-warning'>Limit to 1 drink/day</span> - can affect blood sugar" : 
                                                "<span class='text-success'>Good!</span> No alcohol detected" %></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="p-3 bg-light rounded">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-syringe <%= user.getInsulinUsage().equals("Yes") ? "text-info" : "text-secondary" %> fa-2x"></i>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-1">Insulin Usage</h6>
                                            <p class="mb-0 small"><%= user.getInsulinUsage().equals("Yes") ? 
                                                "<span class='text-info'>Monitor closely</span> - track carb intake" : 
                                                "No insulin usage reported" %></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="p-3 bg-light rounded">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-briefcase text-primary fa-2x"></i>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-1">Profession</h6>
                                            <p class="mb-0 small"><%= user.getJobProfession() != null ? 
                                                user.getJobProfession() : "Not specified" %></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="alert alert-info">
                            <h6><i class="fas fa-clock me-2"></i>Meal Timing</h6>
                            <p class="mb-0"><%= mealTiming %></p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Recommendations Card -->
            <div class="col-lg-6">
                <div class="card dashboard-card">
                    <div class="card-header bg-success text-white">
                        <h5 class="card-title"><i class="fas fa-lightbulb me-2"></i>Personalized Recommendations</h5>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-info">
                            <div class="d-flex align-items-start">
                                <i class="fas fa-utensils mt-1 me-3"></i>
                                <div>
                                    <h6>Today's Food Suggestion</h6>
                                    <p class="mb-1"><%= foodRecommendation %></p>
                                    <% if(user.getAllergies() != null && !user.getAllergies().isEmpty()) { %>
                                        <small class="text-muted">(Allergy note: Avoid <%= user.getAllergies() %>)</small>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                        
                        <div class="alert alert-warning">
                            <div class="d-flex align-items-start">
                                <i class="fas fa-dumbbell mt-1 me-3"></i>
                                <div>
                                    <h6>Activity Plan</h6>
                                    <p class="mb-1"><%= activityRecommendation %></p>
                                    <% if(bmi >= 25) { %>
                                        <small class="text-muted">Weight loss of 5-10% can significantly improve outcomes</small>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                        
                        <div class="alert alert-secondary">
                            <div class="d-flex align-items-start">
                                <i class="fas fa-book-medical mt-1 me-3"></i>
                                <div>
                                    <h6>Educational Tip</h6>
                                    <% if(user.getDiabetesType().equals("Type 1")) { %>
                                        <p class="mb-1">For Type 1 diabetes: Focus on carb counting and insulin timing</p>
                                    <% } else if(user.getDiabetesType().equals("Type 2")) { %>
                                        <p class="mb-1">For Type 2 diabetes: Consistent meal times help maintain stable blood sugar levels</p>
                                    <% } else if(user.getDiabetesType().equals("Gestational")) { %>
                                        <p class="mb-1">For Gestational diabetes: Regular monitoring is essential for both mother and baby's health</p>
                                    <% } else { %>
                                        <p class="mb-1">Regular monitoring and balanced diet are key for managing diabetes</p>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                        
                        <div class="text-center mt-3">
                            <a href="foodRecommendations" class="btn btn-primary">
                                <i class="fas fa-utensils me-2"></i>Get Detailed Food Plan
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        

        
        <!-- Footer -->
        <footer class="mt-5 mb-3 text-center text-muted">
            <p>&copy; 2025 DiabeticCare. All rights reserved.</p>
        </footer>
    </div>
    <% } else { %>
    <!-- NON-LOGGED IN USER VIEW -->
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg public-navbar">
        <div class="container">
            <a class="navbar-brand public-logo" href="#"><i class="fas fa-utensils me-2"></i>Food Recommendation</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link public-nav-link active" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link public-nav-link" href="#features">Features</a>
                    </li>
 
                    <li class="nav-item">
                        <a class="nav-link public-nav-link" href="#recommendations">Recommendations</a>
                    </li>
                </ul>
                <div class="ms-lg-4">
                    <a href="login.jsp" class="btn auth-btn auth-btn-login me-2">Login</a>
                    <a href="register.jsp" class="btn auth-btn auth-btn-signup">Sign Up</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold mb-4">Manage Diabetes with Smart Food Choices</h1>
                    <p class="lead mb-4">Get personalized meal recommendations based on your diabetes type, preferences, and health metrics.</p>
                    <div class="mt-5">
                        <a href="register.jsp" class="btn btn-light btn-lg me-3">Get Started</a>
                        <a href="#features" class="btn btn-outline-light btn-lg">Learn More</a>
                    </div>
                </div>
                <div class="col-lg-6 d-none d-lg-block">
                    <div class="text-center">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5" id="features">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">Our Features</h2>
                <p class="lead text-muted">Tools designed for better diabetes management</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card feature-card p-4">
                        <div class="text-center">
                            <i class="fas fa-utensils feature-icon"></i>
                            <h4>Personalized Food Recommendations</h4>
                            <p class="text-muted">Get meal suggestions tailored to your diabetes type, BMI, and preferences.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card feature-card p-4">
                        <div class="text-center">
                            <i class="fas fa-chart-line feature-icon"></i>
                            <h4>Health Metrics Tracking</h4>
                            <p class="text-muted">Monitor your BMI, blood sugar levels, and other health indicators.</p>
                        </div>
                    </div>
                </div>
  
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="py-5 bg-light" id="testimonials">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">What Our Users Say</h2>
                <p class="lead text-muted">Success stories from people managing diabetes effectively</p>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="testimonial-card">
                        <div class="mb-3">
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                        </div>
                        <p class="mb-4">"The food recommendations have helped me maintain stable blood sugar levels. I've lost 15 pounds and my A1C dropped!"</p>
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <div class="bg-primary text-white rounded-circle p-2 text-center" style="width: 40px; height: 40px; line-height: 25px;">
                                    <i class="fas fa-user"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="mb-0">Sarah Johnson</h6>
                                <small class="text-muted">Type 2 Diabetes, 45</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="testimonial-card">
                        <div class="mb-3">
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                        </div>
                        <p class="mb-4">"As someone with Type 1 diabetes, this app has been a game-changer. The carb counting guidance has made insulin dosing so much easier."</p>
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <div class="bg-primary text-white rounded-circle p-2 text-center" style="width: 40px; height: 40px; line-height: 25px;">
                                    <i class="fas fa-user"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="mb-0">Michael Davis</h6>
                                <small class="text-muted">Type 1 Diabetes, 32</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="testimonial-card">
                        <div class="mb-3">
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star-half-alt text-warning"></i>
                        </div>
                        <p class="mb-4">"During my pregnancy, managing gestational diabetes was stressful. This app provided essential guidance that kept both me and my baby healthy."</p>
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <div class="bg-primary text-white rounded-circle p-2 text-center" style="width: 40px; height: 40px; line-height: 25px;">
                                    <i class="fas fa-user"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="mb-0">Emily Rodriguez</h6>
                                <small class="text-muted">Gestational Diabetes, 29</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Food Recommendations Section -->
    <section class="py-5" id="recommendations">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">Sample Food Recommendations</h2>
                <p class="lead text-muted">See what personalized meal plans look like</p>
            </div>
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <div class="food-recommendation-card">
                        <div class="food-recommendation-header type1-header">
                            <h4><i class="fas fa-utensils me-2"></i>Type 1 Diabetes</h4>
                        </div>
                        <div class="card-body">
                            <h5>Vegetarian Option</h5>
                            <p>Quinoa with roasted vegetables (45g carbs) + insulin dose as directed</p>
                            <hr>
                            <h5>Non-Vegetarian Option</h5>
                            <p>Grilled salmon with asparagus (30g carbs) + insulin dose as directed</p>
                            <div class="alert alert-info mt-3">
                                <small><i class="fas fa-info-circle me-1"></i> Type 1 recommendations include carb counting to assist with insulin dosing</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-4">
                    <div class="food-recommendation-card">
                        <div class="food-recommendation-header type2-header">
                            <h4><i class="fas fa-utensils me-2"></i>Type 2 Diabetes</h4>
                        </div>
                        <div class="card-body">
                            <h5>Vegetarian Option</h5>
                            <p>Lentil soup with whole grain bread (Low glycemic)</p>
                            <hr>
                            <h5>Non-Vegetarian Option</h5>
                            <p>Baked chicken with steamed broccoli and cauliflower rice</p>
                            <div class="alert alert-success mt-3">
                                <small><i class="fas fa-info-circle me-1"></i> Type 2 recommendations focus on low glycemic index foods</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-4">
                    <div class="food-recommendation-card">
                        <div class="food-recommendation-header gestational-header">
                            <h4><i class="fas fa-utensils me-2"></i>Gestational Diabetes</h4>
                        </div>
                        <div class="card-body">
                            <h5>Vegetarian Option</h5>
                            <p>Greek yogurt with berries and nuts</p>
                            <hr>
                            <h5>Non-Vegetarian Option</h5>
                            <p>Turkey and avocado wrap on whole wheat</p>
                            <div class="alert alert-warning mt-3">
                                <small><i class="fas fa-info-circle me-1"></i> Gestational recommendations prioritize maternal and baby health</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center mt-4">
                <p>Want personalized recommendations based on your health profile?</p>
                <a href="register.jsp" class="btn btn-primary btn-lg">Create Your Account</a>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section class="py-5 bg-primary text-white">
        <div class="container text-center">
            <h2 class="mb-4">Ready to Take Control of Your Diabetes?</h2>
            <p class="lead mb-4">Join thousands of users who are managing their diabetes effectively with our personalized approach.</p>
            <a href="register.jsp" class="btn btn-light btn-lg">Sign Up Now - It's Free!</a>
        </div>
    </section>

    <!-- Footer -->
    <footer class="py-4 bg-dark text-white">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5><i class="fas fa-utensils me-2"></i>DiabeticCare</h5>
                    <p>Helping you manage diabetes through smart food choices.</p>
                </div>
                <div class="col-md-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Home</a></li>
                        <li><a href="#features" class="text-white">Features</a></li>
                        <li><a href="#testimonials" class="text-white">Testimonials</a></li>
                        <li><a href="#recommendations" class="text-white">Recommendations</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Contact Us</h5>
                    <p><i class="fas fa-envelope me-2"></i>support@diabeticcare.com</p>

                </div>
            </div>
            <hr class="my-4">
            <div class="text-center">
                <p class="mb-0">&copy; 2025 DiabeticCare. All rights reserved.</p>
            </div>
        </div>
    </footer>
    <% } %>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set BMI marker position
        window.onload = function() {
            <% if(isLoggedIn) { %>
                var bmiMarker = document.getElementById('bmiMarker');
                // Position based on BMI (18.5, 25, 30 are the thresholds)
                // Calculate position percentage
                var bmiValue = <%= bmi %>;
                var position = 0;
                
                if(bmiValue < 18.5) {
                    position = (bmiValue / 18.5) * 25;
                } else if(bmiValue < 25) {
                    position = 25 + ((bmiValue - 18.5) / 6.5) * 25;
                } else if(bmiValue < 30) {
                    position = 50 + ((bmiValue - 25) / 5) * 25;
                } else {
                    position = 75 + Math.min(((bmiValue - 30) / 10) * 25, 25);
                }
                
                // Ensure position is within bounds
                position = Math.max(0, Math.min(100, position));
                bmiMarker.style.left = position + '%';
            <% } %>
        };
    </script>
</body>
</html>