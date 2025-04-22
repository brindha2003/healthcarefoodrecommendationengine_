<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.healthCareFoodRecommendation.Model.DiabeticUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile - Diabetes Health App</title>
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
        
        /* Profile Update Form Styles */
        .profile-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            padding: 25px;
            margin-bottom: 20px;
        }
        
        .form-section {
            border-bottom: 1px solid #eee;
            padding-bottom: 20px;
            margin-bottom: 20px;
        }
        
        .form-section:last-child {
            border-bottom: none;
        }
        
        .section-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
            color: var(--secondary-color);
        }
        
        .form-label {
            font-weight: 600;
            color: #555;
        }
        
        .form-control {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }
        
        .form-select {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            transition: all 0.3s;
        }
        
        .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }
        
        .update-btn {
            background: linear-gradient(to right, var(--primary-color), var(--info-color));
            color: white;
            border: none;
            border-radius: 5px;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
        }
        
        .update-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
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
    DiabeticUser user = (DiabeticUser) request.getAttribute("user");
    if (user == null) {
        // Try to get from session if not in request
        user = (DiabeticUser) session.getAttribute("loggedInUser");
    }
    
    if (user == null) {
%>
    <div class="container mt-5">
        <div class="alert alert-danger" role="alert">
            No user data available. Please <a href="login.jsp">login</a> to update your profile.
        </div>
    </div>
<%
    } else {
%>

    <div class="sidebar p-4">
        <div class="text-center mb-4">
            <h4><i class="fas fa-utensils me-2"></i>Food Recommendation</h4>
            <div class="progress progress-thin mb-2">
                <div class="progress-bar bg-success" style="width: 100%"></div>
            </div>
            <small>Profile completeness: 100%</small>
        </div>

        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="index.jsp"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="foodRecommendation.jsp"><i class="fas fa-utensils me-2"></i>Food Recommendations</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="bmi.jsp"><i class="fas fa-chart-line me-2"></i>BMI Calculator</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="nutritionGuide.jsp"><i class="fas fa-book me-2"></i>Nutrition Guide</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="updateProfile.jsp"><i class="fas fa-user-edit me-2"></i>Update Profile</a>
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
            <h2 class="mb-4">Update Your Profile</h2>
            
            <form action="saveProfileUser" method="post">
                <input type="hidden" name="id" value="<%= user.getId() %>">
                
                <div class="profile-card">
                    <div class="form-section">
                        <div class="section-title"><i class="fas fa-user me-2"></i>Personal Information</div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="name" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="age" class="form-label">Age</label>
                                <input type="number" class="form-control" id="age" name="age" value="<%= user.getAge() %>" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="gender" class="form-label">Gender</label>
                                <select class="form-select" id="gender" name="gender" required>
                                    <option value="Male" <%= user.getGender().equals("Male") ? "selected" : "" %>>Male</option>
                                    <option value="Female" <%= user.getGender().equals("Female") ? "selected" : "" %>>Female</option>
                                    <option value="Other" <%= user.getGender().equals("Other") ? "selected" : "" %>>Other</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="jobProfession" class="form-label">Job Profession</label>
                                <input type="text" class="form-control" id="jobProfession" name="jobProfession" value="<%= user.getJobProfession() %>">
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <div class="section-title"><i class="fas fa-envelope me-2"></i>Contact Information</div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="phone" class="form-label">Phone Number</label>
                                <input type="text" class="form-control" id="phone" name="phone" value="<%= user.getPhone() %>" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="password" class="form-label">Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="password" name="password" value="<%= user.getPassword() %>" required>
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <div class="section-title"><i class="fas fa-weight me-2"></i>Physical Measurements</div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="weight" class="form-label">Weight (kg)</label>
                                <input type="number" step="0.1" class="form-control" id="weight" name="weight" value="<%= user.getWeight() %>" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="height" class="form-label">Height (cm)</label>
                                <input type="number" step="0.1" class="form-control" id="height" name="height" value="<%= user.getHeight() %>" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <div class="section-title"><i class="fas fa-apple-alt me-2"></i>Food & Allergies</div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="foodPreference" class="form-label">Food Preference</label>
                                <input type="text" class="form-control" id="foodPreference" name="foodPreference" value="<%= user.getFoodPreference() %>" placeholder="e.g., Vegetarian, Non-vegetarian, Vegan">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="allergies" class="form-label">Allergies</label>
                                <input type="text" class="form-control" id="allergies" name="allergies" value="<%= user.getAllergies() %>" placeholder="e.g., Nuts, Dairy, Gluten">
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <div class="section-title"><i class="fas fa-heartbeat me-2"></i>Health Information</div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="bloodSugarRange" class="form-label">Blood Sugar Range</label>
                                <input type="text" class="form-control" id="bloodSugarRange" name="bloodSugarRange" value="<%= user.getBloodSugarRange() %>" placeholder="e.g., 80-120 mg/dL">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="diabetesType" class="form-label">Diabetes Type</label>
                                <select class="form-select" id="diabetesType" name="diabetesType" required>
                                    <option value="Type 1" <%= user.getDiabetesType().equals("Type 1") ? "selected" : "" %>>Type 1</option>
                                    <option value="Type 2" <%= user.getDiabetesType().equals("Type 2") ? "selected" : "" %>>Type 2</option>
                                    <option value="Gestational" <%= user.getDiabetesType().equals("Gestational") ? "selected" : "" %>>Gestational</option>
                                    <option value="Prediabetes" <%= user.getDiabetesType().equals("Prediabetes") ? "selected" : "" %>>Prediabetes</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-4 mb-3">
                                <label for="smokingHabit" class="form-label">Smoking Habit</label>
                                <select class="form-select" id="smokingHabit" name="smokingHabit">
                                    <option value="Yes" <%= user.getSmokingHabit().equals("Yes") ? "selected" : "" %>>Yes</option>
                                    <option value="No" <%= user.getSmokingHabit().equals("No") ? "selected" : "" %>>No</option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="alcoholHabit" class="form-label">Alcohol Habit</label>
                                <select class="form-select" id="alcoholHabit" name="alcoholHabit">
                                    <option value="Yes" <%= user.getAlcoholHabit().equals("Yes") ? "selected" : "" %>>Yes</option>
                                    <option value="No" <%= user.getAlcoholHabit().equals("No") ? "selected" : "" %>>No</option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="insulinUsage" class="form-label">Insulin Usage</label>
                                <select class="form-select" id="insulinUsage" name="insulinUsage">
                                    <option value="Yes" <%= user.getInsulinUsage().equals("Yes") ? "selected" : "" %>>Yes</option>
                                    <option value="No" <%= user.getInsulinUsage().equals("No") ? "selected" : "" %>>No</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <div class="text-center mt-4">
                        <button type="submit" class="update-btn">
                            <i class="fas fa-save me-2"></i>Update Profile
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    </script>

<% } %>

</body>
</html>