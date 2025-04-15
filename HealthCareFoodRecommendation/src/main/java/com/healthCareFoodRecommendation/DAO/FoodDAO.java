package com.healthCareFoodRecommendation.DAO;

import java.util.List;

import com.healthCareFoodRecommendation.Model.Food;

public interface FoodDAO {
    public List<Food> getRecommendedFoods(String foodPreference, String diabetesType, String allergies);


}
