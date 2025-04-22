package com.healthCareFoodRecommendation.DAOImplement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import com.healthCareFoodRecommendation.DAO.DiabeticUserDAO;
import com.healthCareFoodRecommendation.Model.DiabeticUser;

import jakarta.servlet.http.HttpSession;

@Component
public class DiabeticUserDAOImplement implements DiabeticUserDAO {
	SessionFactory sf;



	 Connection connection;

	 @Autowired
	 public DiabeticUserDAOImplement(@Qualifier("sf") SessionFactory sf) {
	     this.sf = sf;
	     try {
	         Class.forName("com.mysql.cj.jdbc.Driver");
	         connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/healthcaremanagement", "root", "Brindha@1200");
	     } catch (Exception e) {
	         e.printStackTrace();
	     }
	 }


	    /*------------------------------------ADD USER----------------------------------------------*/
	    @Override
	    public int addUser(DiabeticUser user) {
	        String query = "INSERT INTO `diabetic_users`(`name`,`age`, `gender`, `email`, `phone`,"
	        		+ " `Password`, `weight`, `height`, `food_preference`, `allergies`, `blood_sugar_range`, `job_profession`, `smoking_habit`, `alcohol_habit`, `insulin_usage`, `diabetes_type`) VALUES (?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?)";
	        PreparedStatement ps = null;
	        try {
	            ps = connection.prepareStatement(query);
	            ps.setString(1, user.getName());
	            ps.setInt(2, user.getAge());
	            ps.setString(3, user.getGender());
	            ps.setString(4, user.getEmail());
	            ps.setString(5, user.getPhone());
	            ps.setString(6, user.getPassword());
	            ps.setDouble(7, user.getWeight());
	            ps.setDouble(8, user.getHeight());
	            ps.setString(9, user.getFoodPreference());
	            ps.setString(10, user.getAllergies());
	            ps.setString(11, user.getBloodSugarRange());
	            ps.setString(12, user.getJobProfession());
	            ps.setString(13, user.getSmokingHabit());
	            ps.setString(14, user.getAlcoholHabit());
	            ps.setString(15, user.getInsulinUsage());
	            ps.setString(16, user.getDiabetesType());
	            return ps.executeUpdate();
	        } catch (Exception e) {
	            e.printStackTrace();
	            return 0;
	        }
	
	    }

	@Override
	public DiabeticUser getUser(String email) {
		String query = "SELECT * FROM diabetic_users WHERE email=?";
		DiabeticUser user = null;
        PreparedStatement ps = null;
        ResultSet res = null;
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            res = ps.executeQuery();
            if (res.next()) {
                user = print(res);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } 
//        finally {
//            closeResources(ps, res, null);
//        }
        return user;
	}
	
	
	
	public void updateUser(DiabeticUser user) {
		String query = "UPDATE diabetic_users set password=? where email=?";
        PreparedStatement ps = null;
        ResultSet res = null;
		try {
			ps = connection.prepareStatement(query);
			ps.setString(1, user.getPassword());
			ps.setString(2, user.getEmail());
			int x = ps.executeUpdate();
			System.out.println(" User password Updated.");
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	
	
	
	public DiabeticUser getUserById(int id) {
		DiabeticUser user = null;
		Session session = sf.openSession();
		
		try {
			
			user = session.get(DiabeticUser.class, id);
			
			if(user != null) {
				System.out.println("project data found :" );
			}
			else {
				System.out.println("can't get project data");
			}
		}
		finally {
			session.close();
		}

		
		return user;
	}
	
	
	
	public void UpdateUser(int id, String name, int age, String gender,
			String emai, String phone, String password, double weight,
			double height, String foodPreference,String allergies, String bloodSugarRange,
			String jobProfession, String smokingHabit, String alcoholHabit, String insulinUsage
			) {
		
		Session session = sf.openSession();
		Transaction t = session.beginTransaction();
		DiabeticUser ps = session.get(DiabeticUser.class,id);
		
		if(ps != null) {
			
			ps.setName(name);
			ps.setAge(age);
			ps.setGender(gender);
			ps.setEmail(emai);
			ps.setPhone(phone);
			ps.setPassword(password);
			ps.setWeight(weight);
			ps.setHeight(height);
			ps.setFoodPreference(foodPreference);
			ps.setAllergies(allergies);
			ps.setBloodSugarRange(bloodSugarRange);
			ps.setJobProfession(jobProfession);
			ps.setSmokingHabit(smokingHabit);
			ps.setAlcoholHabit(alcoholHabit);
			ps.setInsulinUsage(insulinUsage);
			
			session.update(ps);
			t.commit();
			System.out.println("id- "+id +"is projectsite edited");
		}
		else {
			System.out.println("Can;t Edit It");
		}
		session.close();
	}
	
	

    /*------------------------------------CALL THE METHOD-----------------------------------------------*/
    private DiabeticUser print(ResultSet res) throws Exception {
    	DiabeticUser user = new DiabeticUser();
        user.setId(res.getInt("id"));
        user.setName(res.getString("name"));
        user.setAge(res.getInt("age"));
        user.setGender(res.getString("gender"));
        user.setPhone(res.getString("phone"));
        user.setPassword(res.getString("password"));
        user.setWeight(res.getDouble("weight"));
        user.setHeight(res.getDouble("height"));
        user.setFoodPreference(res.getString("food_Preference"));
        user.setAllergies(res.getString("allergies"));
        user.setBloodSugarRange(res.getString("blood_Sugar_Range"));
        user.setJobProfession(res.getString("job_Profession"));
        user.setSmokingHabit(res.getString("smoking_habit"));
        user.setAlcoholHabit(res.getString("alcohol_habit"));
        user.setInsulinUsage(res.getString("insulin_usage"));
        user.setDiabetesType(res.getString("diabetes_type"));
        return user;
    }
	
	
}
