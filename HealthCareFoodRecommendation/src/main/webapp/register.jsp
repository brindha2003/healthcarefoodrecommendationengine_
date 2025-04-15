<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup - Food Recommendation App</title>
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
        
        .signup-container {
            max-width: 800px;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        }
        
        h2, h3 {
            text-align: center;
            margin-bottom: 20px;
            color: var(--secondary-color);
        }
        
        label {
            font-weight: bold;
            color: var(--secondary-color);
        }
        
        .form-control {
            margin-bottom: 15px;
            border-radius: 5px;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 12px;
            font-size: 16px;
            width: 100%;
            margin-top: 10px;
            transition: all 0.3s;
        }
        
        .btn-primary:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        .section-header {
            background-color: #f8f9fa;
            padding: 10px;
            margin: 20px 0 15px 0;
            border-radius: 5px;
            border-left: 5px solid var(--primary-color);
        }
        
        .login-link {
            text-align: center;
            margin-top: 20px;
        }
        
        .progress-container {
            margin: 20px 0;
        }
        
        .progress-thin {
            height: 6px;
        }
        
        @media (max-width: 767px) {
            .signup-container {
                margin: 10px;
                padding: 20px;
            }
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="signup-container">
            <h2><i class="fas fa-user-plus me-2"></i>Signup - Food Recommendation</h2>
            
            <div class="progress-container">
                <div class="progress progress-thin">
                    <div class="progress-bar bg-success" style="width: 0%" id="formProgress"></div>
                </div>
                <small class="text-muted">Complete all fields for personalized recommendations</small>
            </div>
            
            <form action="Signup" method="post" id="signupForm">
                <!-- Section 1: Basic Information -->
                <div class="section-header">
                    <h3><i class="fas fa-id-card me-2"></i>Basic Information</h3>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <label for="name">Full Name</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="col-md-3">
                        <label for="age">Age</label>
                        <input type="number" class="form-control" id="age" name="age" min="0" required>
                    </div>
                    <div class="col-md-3">
                        <label for="gender">Gender</label>
                        <select class="form-control" id="gender" name="gender" required>
                            <option value="">--Select--</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="col-md-6">
                        <label for="phone">Phone Number</label>
                        <input type="text" class="form-control" id="phone" name="phone" required>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="col-md-6">
                        <label for="confirmPassword">Confirm Password</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>
                </div>

                <!-- Section 2: Medical Information -->
                <div class="section-header">
                    <h3><i class="fas fa-heartbeat me-2"></i>Medical Information</h3>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <label for="weight">Weight (kg)</label>
                        <input type="number" step="0.01" class="form-control" id="weight" name="weight" required>
                    </div>
                    <div class="col-md-6">
                        <label for="height">Height (cm)</label>
                        <input type="number" step="0.01" class="form-control" id="height" name="height" required>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <label for="foodPreference">Food Preference</label>
                        <select class="form-control" id="foodPreference" name="foodPreference" required>
                            <option value="">--Select--</option>
                            <option value="Veg">Vegetarian</option>
                            <option value="Non-Veg">Non-Vegetarian</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="diabetesType">Diabetes Type</label>
                        <select class="form-control" id="diabetesType" name="diabetesType" required>
                            <option value="">--Select--</option>
                            <option value="Type 1">Type 1</option>
                            <option value="Type 2">Type 2</option>
                            <option value="Gestational">Gestational</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-12">
                        <label for="allergies">Allergies</label>
                        <input type="text" class="form-control" id="allergies" name="allergies" placeholder="E.g., peanuts, dairy">
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <label for="bloodSugarRange">Blood Sugar Range (e.g., 120-150 mg/dL)</label>
                        <input type="text" class="form-control" id="bloodSugarRange" name="bloodSugarRange">
                    </div>
                    <div class="col-md-6">
                        <label for="jobProfession">Job Profession</label>
                        <input type="text" class="form-control" id="jobProfession" name="jobProfession">
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-4">
                        <label for="smokingHabit">Smoking Habit</label>
                        <select class="form-control" id="smokingHabit" name="smokingHabit">
                            <option value="">--Select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="alcoholHabit">Alcohol Habit</label>
                        <select class="form-control" id="alcoholHabit" name="alcoholHabit">
                            <option value="">--Select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="insulinUsage">Insulin Usage</label>
                        <select class="form-control" id="insulinUsage" name="insulinUsage">
                            <option value="">--Select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>
                        </select>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary mt-4">
                    <i class="fas fa-user-plus me-2"></i>Register
                </button>
                
                <div class="login-link">
                    <p>Already have an account? <a href="login.jsp">Login here</a></p>
                </div>
            </form>
        </div>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    <script>
        // Simple form progress tracker
        const form = document.getElementById('signupForm');
        const progressBar = document.getElementById('formProgress');
        const inputs = form.querySelectorAll('input, select');
        
        function updateProgress() {
            let filledInputs = 0;
            inputs.forEach(input => {
                if (input.value.trim() !== '') {
                    filledInputs++;
                }
            });
            
            const progressPercentage = (filledInputs / inputs.length) * 100;
            progressBar.style.width = progressPercentage + '%';
        }
        
        inputs.forEach(input => {
            input.addEventListener('change', updateProgress);
            input.addEventListener('keyup', updateProgress);
        });
        
        // Check passwords match
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        
        function validatePassword() {
            if (password.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity("Passwords don't match");
            } else {
                confirmPassword.setCustomValidity('');
            }
        }
        
        password.addEventListener('change', validatePassword);
        confirmPassword.addEventListener('keyup', validatePassword);
    </script>
</body>
</html>