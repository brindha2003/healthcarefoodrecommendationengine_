<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.healthCareFoodRecommendation.Model.DiabeticUser" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nutrition Guide - Diabetes Health App</title>
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
        
        .login-container {
            width: 400px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        }
        
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        
        label {
            font-weight: bold;
        }
        
        input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        
        button {
            width: 100%;
            background-color: var(--primary-color);
            color: white;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        
        button:hover {
            background-color: #0056b3;
        }
        
        .signup-link {
            text-align: center;
            margin-top: 15px;
        }
        
        /* Nutrition Guide Specific Styles */
        .section-card {
            border-left: 5px solid var(--primary-color);
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 25px;
            background-color: white;
            box-shadow: 0 3px 6px rgba(0,0,0,0.1);
        }
        
        .food-item {
            display: flex;
            align-items: center;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 10px;
            background-color: #f8f9fa;
            transition: all 0.2s;
        }
        
        .food-item:hover {
            background-color: #edf2f7;
            transform: translateX(5px);
        }
        
        .food-icon {
            width: 40px;
            height: 40px;
            margin-right: 15px;
            background-color: var(--info-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
        }
        
        .food-info {
            flex-grow: 1;
        }
        
        .food-title {
            font-weight: 600;
            margin-bottom: 2px;
        }
        
        .food-desc {
            font-size: 14px;
            color: #666;
        }
        
        .tip-box {
            background-color: rgba(52, 152, 219, 0.1);
            border-left: 4px solid var(--primary-color);
            padding: 15px;
            margin: 20px 0;
            border-radius: 4px;
        }
        
        .water-tracker {
            background: linear-gradient(to right, #3498db, #1abc9c);
            border-radius: 10px;
            padding: 20px;
            color: white;
            margin-bottom: 25px;
        }
        
        .glass-count {
            display: flex;
            margin-top: 15px;
        }
        
        .glass {
            width: 30px;
            height: 40px;
            margin-right: 10px;
            background-color: rgba(255,255,255,0.3);
            border-radius: 5px;
            position: relative;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .glass.filled {
            background-color: rgba(255,255,255,0.9);
        }
        
        .exercise-item {
            display: flex;
            align-items: center;
            background-color: white;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .exercise-icon {
            width: 50px;
            height: 50px;
            background-color: var(--accent-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
            margin-right: 15px;
        }
        
        .sleep-chart {
            height: 200px;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
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


    // Get user from session
    DiabeticUser user = (DiabeticUser) session.getAttribute("loggedInUser");
 
    boolean isLoggedIn = session.getAttribute("user") != null;
    %>

    <!-- Sidebar Navigation -->
    <div class="sidebar p-4">
        <div class="text-center mb-4">
            <h4><i class="fas fa-utensils me-2"></i>Food Recommendation</h4>
            <div class="progress progress-thin mb-2">
                <div class="progress-bar bg-success" style="width: 75%"></div>
            </div>
            <small>Profile completeness: 99%</small>
        </div>

        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="index.jsp"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="foodRecommendations"><i class="fas fa-utensils me-2"></i>Food Recommendations</a>
            </li>
             <li class="nav-item">
                <a class="nav-link" href="bmi.jsp"><i class="fas fa-chart-line me-2"></i>BMI Calculater</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="nutritionGuide.jsp"><i class="fas fa-book me-2"></i>Nutrition Guide</a>
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

    <!-- Main Content -->
    <div class="main-content">
        <div class="container-fluid">
            <h1 class="mb-4">Nutrition Guide for Diabetes Management</h1>
            
            <div class="row mb-4">
                <div class="col-lg-8">
                    <div class="alert alert-info">
                        <strong><i class="fas fa-info-circle me-2"></i>Personalized Guidance:</strong> This nutrition guide is tailored to help you manage diabetes through proper diet, hydration, exercise, and lifestyle habits.
                    </div>
                </div>
            </div>
            
            <!-- Diabetes Food Control Section -->
            <div class="section-card">
                <h3><i class="fas fa-apple-alt me-2 text-success"></i>Foods to Control Diabetes</h3>
                <p>Managing blood sugar levels is crucial for diabetes control. Focus on these food groups:</p>
                
                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="food-item">
                            <div class="food-icon bg-success">
                                <i class="fas fa-leaf"></i>
                            </div>
                            <div class="food-info">
                                <div class="food-title">Non-Starchy Vegetables</div>
                                <div class="food-desc">Spinach, broccoli, green beans, cauliflower, and tomatoes</div>
                            </div>
                        </div>
                        
                        <div class="food-item">
                            <div class="food-icon" style="background-color: #3498db;">
                                <i class="fas fa-fish"></i>
                            </div>
                            <div class="food-info">
                                <div class="food-title">Lean Proteins</div>
                                <div class="food-desc">Chicken, fish, tofu, eggs, and legumes</div>
                            </div>
                        </div>
                        
                        <div class="food-item">
                            <div class="food-icon" style="background-color: #f39c12;">
                                <i class="fas fa-seedling"></i>
                            </div>
                            <div class="food-info">
                                <div class="food-title">Whole Grains</div>
                                <div class="food-desc">Brown rice, quinoa, barley, and oats (in moderation)</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="food-item">
                            <div class="food-icon" style="background-color: #9b59b6;">
                                <i class="fas fa-apple-alt"></i>
                            </div>
                            <div class="food-info">
                                <div class="food-title">Low-glycemic Fruits</div>
                                <div class="food-desc">Berries, apples, pears, and cherries</div>
                            </div>
                        </div>
                        
                        <div class="food-item">
                            <div class="food-icon" style="background-color: #1abc9c;">
                                <i class="fas fa-cheese"></i>
                            </div>
                            <div class="food-info">
                                <div class="food-title">Healthy Fats</div>
                                <div class="food-desc">Avocados, nuts, seeds, and olive oil</div>
                            </div>
                        </div>
                        
                        <div class="food-item">
                            <div class="food-icon" style="background-color: #e74c3c;">
                                <i class="fas fa-ban"></i>
                            </div>
                            <div class="food-info">
                                <div class="food-title">Foods to Avoid</div>
                                <div class="food-desc">Sugary drinks, sweets, refined carbs, and processed foods</div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="tip-box mt-4">
                    <h5><i class="fas fa-lightbulb me-2"></i>Smart Tip</h5>
                    <p>Use the plate method: Fill half your plate with non-starchy vegetables, one quarter with lean protein, and one quarter with whole grains or starchy vegetables.</p>
                </div>
            </div>
            
            <!-- Water Consumption Section -->
            <div class="section-card">
                <h3><i class="fas fa-tint me-2 text-primary"></i>Daily Water Intake</h3>
                <p>Proper hydration helps regulate blood sugar levels and supports overall health. Aim for 8-10 glasses (2-2.5 liters) of water daily.</p>
                
                <div class="water-tracker mt-4">
                    <h5>Today's Water Tracker</h5>
                    <p>Track your daily water intake by clicking on each glass</p>
                    
                    <div class="glass-count">
                        <div class="glass" onclick="toggleGlass(this)"></div>
                        <div class="glass" onclick="toggleGlass(this)"></div>
                        <div class="glass" onclick="toggleGlass(this)"></div>
                        <div class="glass" onclick="toggleGlass(this)"></div>
                        <div class="glass" onclick="toggleGlass(this)"></div>
                        <div class="glass" onclick="toggleGlass(this)"></div>
                        <div class="glass" onclick="toggleGlass(this)"></div>
                        <div class="glass" onclick="toggleGlass(this)"></div>
                    </div>
                </div>
                
                <div class="row mt-3">
                    <div class="col-md-6">
                        <div class="card dashboard-card">
                            <div class="card-body">
                                <h5 class="card-title"><i class="fas fa-check-circle me-2 text-success"></i>Benefits of Proper Hydration</h5>
                                <ul>
                                    <li>Helps kidneys flush out excess sugar through urine</li>
                                    <li>Prevents dehydration, which can worsen blood sugar levels</li>
                                    <li>Reduces sugar cravings and aids in weight management</li>
                                    <li>Improves energy levels and cognitive function</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="card dashboard-card">
                            <div class="card-body">
                                <h5 class="card-title"><i class="fas fa-exclamation-triangle me-2 text-warning"></i>Signs of Dehydration</h5>
                                <ul>
                                    <li>Thirst and dry mouth</li>
                                    <li>Dark yellow urine</li>
                                    <li>Fatigue and dizziness</li>
                                    <li>Headaches</li>
                                    <li>Elevated blood glucose levels</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Exercise Section -->
            <div class="section-card">
                <h3><i class="fas fa-running me-2 text-warning"></i>Exercise Recommendations</h3>
                <p>Regular physical activity helps improve insulin sensitivity and blood sugar control. Aim for at least 150 minutes of moderate exercise per week.</p>
                
                <div class="row mt-4">
                    <div class="col-lg-4 col-md-6 mb-3">
                        <div class="exercise-item">
                            <div class="exercise-icon" style="background-color: #2ecc71;">
                                <i class="fas fa-walking"></i>
                            </div>
                            <div>
                                <h5>Walking</h5>
                                <p>30 minutes daily, 5 days a week</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6 mb-3">
                        <div class="exercise-item">
                            <div class="exercise-icon" style="background-color: #3498db;">
                                <i class="fas fa-swimmer"></i>
                            </div>
                            <div>
                                <h5>Swimming</h5>
                                <p>30-45 minutes, 2-3 times weekly</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6 mb-3">
                        <div class="exercise-item">
                            <div class="exercise-icon" style="background-color: #9b59b6;">
                                <i class="fas fa-dumbbell"></i>
                            </div>
                            <div>
                                <h5>Strength Training</h5>
                                <p>20-30 minutes, 2-3 times weekly</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6 mb-3">
                        <div class="exercise-item">
                            <div class="exercise-icon" style="background-color: #f39c12;">
                                <i class="fas fa-biking"></i>
                            </div>
                            <div>
                                <h5>Cycling</h5>
                                <p>30 minutes, 3-4 times weekly</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6 mb-3">
                        <div class="exercise-item">
                            <div class="exercise-icon" style="background-color: #1abc9c;">
                                <i class="fas fa-heart"></i>
                            </div>
                            <div>
                                <h5>Aerobic Dance</h5>
                                <p>20-30 minutes, 2-3 times weekly</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6 mb-3">
                        <div class="exercise-item">
                            <div class="exercise-icon" style="background-color: #e74c3c;">
                                <i class="fas fa-medal"></i>
                            </div>
                            <div>
                                <h5>Interval Training</h5>
                                <p>15-20 minutes, 2 times weekly</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="tip-box mt-3">
                    <h5><i class="fas fa-exclamation-circle me-2"></i>Important Safety Note</h5>
                    <p>Always check your blood sugar before, during, and after exercise. Carry fast-acting carbohydrates like glucose tablets in case of hypoglycemia. Stay hydrated and wear appropriate footwear to protect your feet.</p>
                </div>
            </div>
            
            <!-- Healthy Habits Section -->
            <div class="section-card">
                <h3><i class="fas fa-heart me-2 text-danger"></i>Healthy Habits for Diabetes Management</h3>
                <p>These daily habits support blood sugar control and overall health:</p>
                
                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="card dashboard-card">
                            <div class="card-body">
                                <h5 class="card-title"><i class="fas fa-clock me-2 text-primary"></i>Consistent Meal Timing</h5>
                                <p>Eat meals at the same time each day to maintain steady blood sugar levels. Avoid skipping meals.</p>
                                <div class="progress progress-thin mt-3">
                                    <div class="progress-bar bg-primary" style="width: 80%"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="card dashboard-card">
                            <div class="card-body">
                                <h5 class="card-title"><i class="fas fa-balance-scale me-2 text-warning"></i>Portion Control</h5>
                                <p>Use measuring cups, food scales, or the plate method to control portion sizes and carbohydrate intake.</p>
                                <div class="progress progress-thin mt-3">
                                    <div class="progress-bar bg-warning" style="width: 75%"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6 mt-3">
                        <div class="card dashboard-card">
                            <div class="card-body">
                                <h5 class="card-title"><i class="fas fa-stethoscope me-2 text-danger"></i>Regular Blood Sugar Monitoring</h5>
                                <p>Check your blood glucose levels regularly as recommended by your healthcare provider.</p>
                                <div class="progress progress-thin mt-3">
                                    <div class="progress-bar bg-danger" style="width: 90%"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6 mt-3">
                        <div class="card dashboard-card">
                            <div class="card-body">
                                <h5 class="card-title"><i class="fas fa-ban me-2 text-secondary"></i>Limit Alcohol & Smoking</h5>
                                <p>Reduce or avoid alcohol consumption and quit smoking to improve insulin sensitivity.</p>
                                <div class="progress progress-thin mt-3">
                                    <div class="progress-bar bg-secondary" style="width: 85%"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Sleep Section -->
            <div class="section-card">
                <h3><i class="fas fa-moon me-2 text-info"></i>Importance of Quality Sleep</h3>
                <p>Poor sleep can affect blood sugar control. Adults with diabetes should aim for 7-8 hours of quality sleep each night.</p>
                
                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="card dashboard-card">
                            <div class="card-body">
                                <h5 class="card-title">How Sleep Affects Diabetes</h5>
                                <ul>
                                    <li>Lack of sleep increases insulin resistance</li>
                                    <li>Sleep deprivation can raise blood sugar levels</li>
                                    <li>Poor sleep may increase appetite and cravings</li>
                                    <li>Sleep disorders are common in people with diabetes</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="card dashboard-card">
                            <div class="card-body">
                                <h5 class="card-title">Tips for Better Sleep</h5>
                                <ul>
                                    <li>Maintain a consistent sleep schedule</li>
                                    <li>Create a relaxing bedtime routine</li>
                                    <li>Keep your bedroom cool, dark, and quiet</li>
                                    <li>Limit screen time before bed</li>
                                    <li>Avoid caffeine and large meals before bedtime</li>
                                    <li>Consider using a continuous glucose monitor to track overnight blood sugar</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Final Tips Section -->
            <div class="section-card">
                <h3><i class="fas fa-star me-2 text-warning"></i>Key Takeaways</h3>
                <div class="row">
                    <div class="col-md-8">
                        <ol>
                            <li><strong>Balance your plate</strong> with non-starchy vegetables, lean proteins, and controlled portions of whole grains.</li>
                            <li><strong>Stay hydrated</strong> with at least 8 glasses of water daily.</li>
                            <li><strong>Exercise regularly</strong> for at least 30 minutes, 5 days a week.</li>
                            <li><strong>Monitor blood sugar</strong> as recommended by your healthcare provider.</li>
                            <li><strong>Prioritize quality sleep</strong> of 7-8 hours each night.</li>
                            <li><strong>Take medications</strong> as prescribed and attend regular check-ups.</li>
                            <li><strong>Manage stress</strong> through mindfulness, deep breathing, or other relaxation techniques.</li>
                        </ol>
                    </div>
                </div>
                
                <div class="alert alert-success mt-4">
                    <strong><i class="fas fa-check-circle me-2"></i>Remember:</strong> Small, consistent changes lead to significant improvements in diabetes management. Track your progress and celebrate your successes!
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleGlass(glass) {
            glass.classList.toggle('filled');
        }
    </script>
</body>
</html>