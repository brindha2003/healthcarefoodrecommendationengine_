package com.healthCareFoodRecommendation.DAO;

import com.healthCareFoodRecommendation.Model.DiabeticUser;

public interface DiabeticUserDAO {
	
	int addUser(DiabeticUser user);

	DiabeticUser getUser(String email);

}
