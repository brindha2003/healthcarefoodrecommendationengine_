package com.healthCareFoodRecommendation.Model;


import org.springframework.stereotype.Component;

import jakarta.persistence.*;

@Entity
@Component
@Table(name = "foods")
public class Food {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false)
    private String name;

    @Column(name = "food_type", nullable = false)
    private String foodType; // Veg or Non-Veg

    @Column(name = "diabetes_type", nullable = false)
    private String diabetesType; // Type 1, Type 2, Gestational, All

    @Column(name = "carbs")
    private double carbs;

    private String allergens;

    @Column(name = "glycemic_index")
    private int glycemicIndex;

    // Constructors
    public Food() {}

    public Food(String name, String foodType, String diabetesType, double carbs, String allergens, int glycemicIndex) {
        this.name = name;
        this.foodType = foodType;
        this.diabetesType = diabetesType;
        this.carbs = carbs;
        this.allergens = allergens;
        this.glycemicIndex = glycemicIndex;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFoodType() {
        return foodType;
    }

    public void setFoodType(String foodType) {
        this.foodType = foodType;
    }

    public String getDiabetesType() {
        return diabetesType;
    }

    public void setDiabetesType(String diabetesType) {
        this.diabetesType = diabetesType;
    }

    public double getCarbs() {
        return carbs;
    }

    public void setCarbs(double carbs) {
        this.carbs = carbs;
    }

    public String getAllergens() {
        return allergens;
    }

    public void setAllergens(String allergens) {
        this.allergens = allergens;
    }

    public int getGlycemicIndex() {
        return glycemicIndex;
    }

    public void setGlycemicIndex(int glycemicIndex) {
        this.glycemicIndex = glycemicIndex;
    }
}
