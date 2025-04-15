package com.healthCareFoodRecommendation.DAOImplement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.healthCareFoodRecommendation.DAO.FoodDAO;
import com.healthCareFoodRecommendation.Model.Food;

@Component
public class FoodDAOImplement implements FoodDAO {

	SessionFactory sf;

	@Autowired
	public FoodDAOImplement(@Qualifier("sf") SessionFactory sf) { // calling this sf method from my APPconfig class.
		super();
		this.sf = sf;
	}

	@Override
	public List<Food> getRecommendedFoods(String foodPreference, String diabetesType, String allergies) {
		Session session = sf.openSession();

		String hql = "FROM Food WHERE foodType = :foodType "
				+ "AND (diabetesType = :diabetesType OR diabetesType = 'All')";

		if (allergies != null && !allergies.isEmpty()) {
			hql += " AND allergens NOT LIKE :allergies";
		}

		Query<Food> query = session.createQuery(hql, Food.class);
		query.setParameter("foodType", foodPreference);
		query.setParameter("diabetesType", diabetesType);

		if (allergies != null && !allergies.isEmpty()) {
			query.setParameter("allergies", "%" + allergies + "%");
		}

		return query.getResultList();
	}

	public List<Food> getAllFoods() {

		Session session = sf.openSession();
		Transaction t = session.beginTransaction();
		Query<Food> q = session.createQuery("FROM Food", Food.class);
		List<Food> list = q.getResultList();
		t.commit();
		session.close();
		return list;

	}

	
	
	
	public List<Food> filterFoods(String foodType, String glycemicIndex, String carbs) {
	    List<Food> foodList = new ArrayList<>();
	    try (Session session = sf.openSession()) {
	        StringBuilder hql = new StringBuilder("FROM Food WHERE 1=1");

	        if (!foodType.equals("All Types")) {
	            hql.append(" AND foodType = :foodType");
	        }

	        if (!glycemicIndex.equals("All Ranges")) {
	            if (glycemicIndex.contains("Low")) {
	                hql.append(" AND glycemicIndex BETWEEN 0 AND 55");
	            } else if (glycemicIndex.contains("Medium")) {
	                hql.append(" AND glycemicIndex BETWEEN 56 AND 69");
	            } else if (glycemicIndex.contains("High")) {
	                hql.append(" AND glycemicIndex >= 70");
	            }
	        }

	        if (!carbs.equals("Any")) {
	            if (carbs.contains("Low")) {
	                hql.append(" AND carbs BETWEEN 0 AND 10");
	            } else if (carbs.contains("Medium")) {
	                hql.append(" AND carbs BETWEEN 11 AND 20");
	            } else if (carbs.contains("High")) {
	                hql.append(" AND carbs >= 21");
	            }
	        }

	        Query<Food> query = session.createQuery(hql.toString(), Food.class);

	        if (!foodType.equals("All Types")) {
	            query.setParameter("foodType", foodType.equals("Vegetarian") ? "Veg" : "Non-Veg");
	        }

	        foodList = query.getResultList();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return foodList;
	}

}
