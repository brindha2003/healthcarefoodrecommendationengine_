<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.healthCareFoodRecommendation.Model.DiabeticUser" %>
<%@ page import="java.util.List" %>
<%@ page import="com.healthCareFoodRecommendation.Model.Food" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Food Recommendations | DiabeticCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        
        /* Redesigned Food Card */
        .food-card {
            transition: all 0.3s ease;
            height: 100%;
            background-color: white;
            border-radius: 15px;
            overflow: hidden;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            position: relative;
        }
        
        .food-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.15);
        }
        
        .food-card-header {
            padding: 15px;
            background: linear-gradient(45deg, var(--primary-color), var(--info-color));
            color: white;
        }
        
        .food-card-header.vegetarian {
            background: linear-gradient(45deg, var(--success-color), var(--info-color));
        }
        
        .food-card-header.non-vegetarian {
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
        }
        
        .gi-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 0.8rem;
            font-weight: bold;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 3px 6px rgba(0,0,0,0.1);
        }
        
        .nutrition-info {
            display: flex;
            justify-content: space-between;
            margin: 15px 0;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }
        
        .nutrition-item {
            text-align: center;
            flex: 1;
        }
        
        .nutrition-value {
            font-weight: bold;
            font-size: 1.2rem;
            color: var(--secondary-color);
        }
        
        .nutrition-label {
            font-size: 0.8rem;
            color: #777;
        }
        
        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }
        
        .action-button {
            flex: 1;
            margin: 0 5px;
            padding: 8px 0;
            border-radius: 30px;
            font-weight: 500;
            font-size: 0.9rem;
            text-align: center;
            cursor: pointer;
        }
        
        .food-tag {
            display: inline-block;
            background-color: rgba(52, 152, 219, 0.1);
            color: var(--primary-color);
            border-radius: 12px;
            padding: 3px 8px;
            font-size: 0.7rem;
            margin-right: 5px;
            margin-bottom: 5px;
        }
        
        .food-description {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 15px;
            height: 40px;
            overflow: hidden;
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
        
        .filter-section {
            background-color: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .filter-row {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .filter-item {
            flex: 1;
            min-width: 180px;
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
            
            .filter-item {
                flex: 100%;
            }
        }
    </style>
</head>
<body>

<%
    // Get user from session
    DiabeticUser user = (DiabeticUser) session.getAttribute("loggedInUser");
    boolean isLoggedIn = (user != null);
    %>

    <!-- Sidebar Navigation -->
    <div class="sidebar p-4">
        <div class="text-center mb-4">
            <h4><i class="fas fa-utensils me-2"></i>DiabeticCare</h4>
            <p class="small">Welcome back, <strong><%=user.getName() %></strong>!</p>
            <div class="progress progress-thin mb-2" style="height: 6px;">
                <div class="progress-bar bg-success" style="width: 80%"></div>
            </div>
            <small>Profile completeness: 80%</small>
        </div>
        
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="index.jsp"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href=foodRecommendations><i class="fas fa-utensils me-2"></i>Food Recommendations</a>
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
        <div class="container-fluid">
            <div class="row mb-4">
                <div class="col-md-8">
                    <h2><i class="fas fa-utensils me-2"></i> Personalized Food Recommendations</h2>
                    <p class="text-muted">Based on your diabetic profile and preferences</p>
                </div>
                
            </div>

            <!-- Filter Section -->
            <div class="filter-section">
                <h5 class="mb-3"><i class="fas fa-sliders-h me-2"></i>Quick Filters</h5>
                <form method="post" action="FoodController">
                    <div class="filter-row">
                        <div class="filter-item">
                            <label class="form-label">Food Type</label>
                            <select class="form-select" name="foodType">
                                <option>All Types</option>
                                <option>Vegetarian</option>
                                <option>Non-Vegetarian</option>
                            </select>
                        </div>
                        <div class="filter-item">
                            <label class="form-label">Glycemic Index</label>
                            <select class="form-select" name="glycemicIndex">
                                <option>All Ranges</option>
                                <option>Low (0-55)</option>
                                <option>Medium (56-69)</option>
                                <option>High (70+)</option>
                            </select>
                        </div>
                        <div class="filter-item">
                            <label class="form-label">Carbohydrates</label>
                            <select class="form-select" name="carbs">
                                <option>Any</option>
                                <option>Low (0-10g)</option>
                                <option>Medium (11-20g)</option>
                                <option>High (21g+)</option>
                            </select>
                        </div>
                        <div class="filter-item d-flex align-items-end">
                            <button class="btn btn-success w-100" type="submit">
                                <i class="fas fa-search me-2"></i> Apply Filters
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Food Recommendations -->
            <div class="row">
                <c:forEach items="${foods}" var="food">
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card food-card">
                            <div class="food-card-header ${food.foodType.toLowerCase()}">
                                <h5 class="mb-0">${food.name}</h5>
                                <div class="mt-2">
                                    <span class="food-tag">
                                        <i class="fas ${food.foodType eq 'Vegetarian' ? 'fa-leaf' : 'fa-drumstick-bite'} me-1"></i>
                                        ${food.foodType}
                                    </span>
                                    <span class="food-tag">
                                        <i class="fas fa-weight me-1"></i>
                                        100g
                                    </span>
                                </div>
                            </div>
                            
                            <span class="gi-badge badge <c:choose>
                                <c:when test="${food.glycemicIndex < 55}">bg-success</c:when>
                                <c:when test="${food.glycemicIndex < 70}">bg-warning</c:when>
                                <c:otherwise>bg-danger</c:otherwise>
                            </c:choose>">GI ${food.glycemicIndex}</span>
                            
                            <div class="card-body">
                                <p class="food-description">A healthy option recommended for your diabetic condition.</p>
                                
                                <div class="nutrition-info">
                                    <div class="nutrition-item">
                                        <div class="nutrition-value">${food.carbs}g</div>
                                        <div class="nutrition-label">Carbs</div>
                                    </div>
                                    <div class="nutrition-item">
                                        <div class="nutrition-value">
                                            <c:choose>
                                                <c:when test="${food.glycemicIndex < 55}">Low</c:when>
                                                <c:when test="${food.glycemicIndex < 70}">Medium</c:when>
                                                <c:otherwise>High</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="nutrition-label">GI Level</div>
                                    </div>
                                    <div class="nutrition-item">
                                        <div class="nutrition-value">
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas <c:choose>
                                                <c:when test="${food.glycemicIndex < 55}">fa-star</c:when>
                                                <c:when test="${food.glycemicIndex < 70}">fa-star-half-alt</c:when>
                                                <c:otherwise>fa-star-o</c:otherwise>
                                            </c:choose> text-warning"></i>
                                        </div>
                                        <div class="nutrition-label">Rating</div>
                                    </div>
                                </div>
                                
                                <c:if test="${not empty food.allergens && food.allergens != 'None'}">
                                    <div class="alert alert-warning py-2">
                                        <i class="fas fa-exclamation-triangle me-1"></i>
                                        <small>Contains : ${food.allergens}</small>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- No Results Message (will display if no foods are available) -->
            <c:if test="${empty foods}">
                <div class="text-center py-5">
                    <i class="fas fa-search fa-3x text-muted mb-3"></i>
                    <h4>No food items found</h4>
                    <p class="text-muted">Try adjusting your filters or check back later for more recommendations.</p>
                </div>
            </c:if>
        </div>
    </div>

    

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add click event for food cards
            document.querySelectorAll('.food-card').forEach(card => {
                card.addEventListener('click', function(e) {
                    if(!e.target.closest('button')) {
                        // Navigate to food detail page
                        console.log('Showing details for food item');
                    }
                });
            });
        });
    </script>
</body>
</html>