package com.healthCareFoodRecommendation.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.healthCareFoodRecommendation.DAOImplement.DiabeticUserDAOImplement;
import com.healthCareFoodRecommendation.DAOImplement.FoodDAOImplement;
import com.healthCareFoodRecommendation.Model.DiabeticUser;
import com.healthCareFoodRecommendation.Model.Food;
import com.healthCareFoodRecommendation.configuration.AppConfiguration;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@Controller
public class UserController {
	
	AnnotationConfigApplicationContext ac = new AnnotationConfigApplicationContext(AppConfiguration.class);

	DiabeticUserDAOImplement udi = (DiabeticUserDAOImplement) ac.getBean("diabeticUserDAOImplement");
	FoodDAOImplement fdi = (FoodDAOImplement) ac.getBean("foodDAOImplement");

	
	
	@RequestMapping("/Signup")
	public String SignupUser(@RequestParam("name") String name,
							@RequestParam("age") int age,
							@RequestParam("gender") String gender,
							@RequestParam("email") String email,
							@RequestParam("phone") String phone,
							@RequestParam("password") String password,
							@RequestParam("confirmPassword") String confirmPassword,
							@RequestParam("weight") double weight,
							@RequestParam("height") double height,
							@RequestParam("foodPreference") String foodPreference,
							@RequestParam("allergies") String allergies,
							@RequestParam("bloodSugarRange") String bloodSugar,
							@RequestParam("jobProfession") String jobProfession,
							@RequestParam("smokingHabit") String smokingHabit,
							@RequestParam("alcoholHabit") String alcoholHabit,
							@RequestParam("insulinUsage") String insulinUsage,
							@RequestParam("diabetesType") String diabetesType,
							Model model
							
							
			) {
		System.out.println(diabetesType);
		if (password.equals(confirmPassword)) {
		DiabeticUser diabeticUser = new DiabeticUser(name, age, gender, email, phone, password, weight, height, foodPreference, allergies, bloodSugar, jobProfession, smokingHabit, alcoholHabit, insulinUsage, diabetesType);
		
		int x = udi.addUser(diabeticUser);
		if (x != 0) {
			return "login";
			
		}

	} else {
		return "PasswordError.jsp";
	}
		return name;
	}
	
	
	
    @RequestMapping("/LoginUser")
    public String userLogin(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session) {
    	
    	System.out.println("email :"+ email);
    	System.out.println("password :"+ password);
    	DiabeticUser user = udi.getUser(email);
    	if(user == null) {
    		return "login";
    	}
    	if(user.getPassword() != null && user.getPassword().equals(password)) {
    		session.setAttribute("loggedInUser", user);
    		System.out.println("weigth" );
    		System.out.println("weigth"+ user.getName());
    		System.out.println("weigth" + user.getWeight());
    		return "index";
    	}
    	else {
    		return "login";
    	}
    }
    
    
    
    @RequestMapping("/forgetPassword")
    public String forgetPassword(@RequestParam("email") String email, @RequestParam("password") String password,@RequestParam("confirmPassword") String confirmPassword, Model model, HttpSession session) {
    	
    	System.out.println("email :"+ email);
    	System.out.println("password :"+ password);
    	System.out.println("confirmPassword :"+ confirmPassword);
    	

    	if(confirmPassword.equals(password)) {
        	DiabeticUser user = new DiabeticUser();
        	user.setEmail(email);
        	user.setPassword(password);
        	udi.updateUser(user);

    
    		return "login";
    	}
    	else {
    		return "forgetPassword";
    	}
    }
    
    
    
    
    
    @RequestMapping("/foodRecommendations")
    public String showFoodRecommendations(HttpSession session, Model model) {
        DiabeticUser user = (DiabeticUser) session.getAttribute("loggedInUser");
        
        List<Food> recommendedFoods = fdi.getRecommendedFoods(
            user.getFoodPreference(),
            user.getDiabetesType(),
            user.getAllergies()
        );
        
        model.addAttribute("foods", recommendedFoods);
        return "food_recommendations";
    }
    
    
    
    
    
    @RequestMapping("/getAllFoods")
    public String getAllFoods(HttpSession session, Model model) {
        
        List<Food> recommendedFoods = fdi.getAllFoods();
        
        model.addAttribute("foods", recommendedFoods);
        return "food_recommendations";
    }
    
    
    
    
    @RequestMapping("/FoodController")
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String foodType = request.getParameter("foodType");
            String glycemicIndex = request.getParameter("glycemicIndex");
            String carbs = request.getParameter("carbs");

            List<Food> filteredFoods = fdi.filterFoods(foodType, glycemicIndex, carbs);
            request.setAttribute("foods", filteredFoods);
            RequestDispatcher dispatcher = request.getRequestDispatcher("food_recommendations.jsp");
            dispatcher.forward(request, response);
        
    }
    
    
    
	@RequestMapping("/profileUpdate")
	public String editProject(@RequestParam("id") int id, Model model) {

		DiabeticUser user = udi.getUserById(id);
		if (user != null) {
			model.addAttribute("user", user);
			System.out.println("from edit project" + user);
			return "updateUser";
		} else {
			return "errorPage";
		}
	}
	
	
	@RequestMapping("/saveProfileUser")
	public String saveProfileeUser(@RequestParam("id") int id,
			@RequestParam("name") String name,
			@RequestParam("age") int age, 
			@RequestParam("gender") String gender,
			@RequestParam("email") String email,
			@RequestParam("phone") String phone,
			@RequestParam("password") String password, 
			@RequestParam("weight") double weight,
			@RequestParam("height") double height,
			@RequestParam("foodPreference") String foodPreference,
			@RequestParam("allergies") String allergies,
			@RequestParam("bloodSugarRange") String bloodSugarRange,
			@RequestParam("jobProfession") String jobProfession,
			@RequestParam("smokingHabit") String smokingHabit,
			@RequestParam("alcoholHabit") String alcoholHabit,
			@RequestParam("insulinUsage") String insulinUsage,
			Model model,
			HttpSession session) {
		System.out.println("saveprojectmethod " + id);
		System.out.println("saveprojectmethod " + name);
		System.out.println("saveprojectmethod " + age);


		udi.UpdateUser(id, name, age, gender, email, phone, password, weight, height, foodPreference, allergies, bloodSugarRange, jobProfession, smokingHabit, alcoholHabit, insulinUsage);

    	
    	DiabeticUser user = udi.getUserById(id);
		session.setAttribute("loggedInUser", user);
		System.out.println("---- saveUser " + user);

		
		
//		pdi.UpdateProjectSite(id, projectName, location, startDate, endDate, status, manager, budget, projectImage);
//
//		List<ProjectSite> projectSites = pdi.getAllProjectSite();
//		session.setAttribute("projectSites", projectSites);
//		System.out.println("saveproject " + projectSites);
//
//		
		return "index";
	}
    

    
    
    
    
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // This will remove all session attributes and logout the user
        return "index"; // Redirecting to index.jsp
    }
    

}



















