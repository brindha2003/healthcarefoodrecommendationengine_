package com.healthCareFoodRecommendation.Model;


import jakarta.persistence.*;

import org.springframework.stereotype.Component;



@Entity
@Component
@Table(name = "diabetic_users")
public class DiabeticUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "age")
    private int age;

    @Column(name = "gender")
    private String gender;;

    
    @Column(name = "email")
    private String email;

    @Column(name = "phone")
    private String phone;

    @Column(name = "password")
    private String password;

    @Column(name = "weight")
    private double weight;

    @Column(name = "height")
    private double height;

    @Column(name = "food_Preference")
    private String foodPreference;

    @Column(name = "allergies")
    private String allergies;

    @Column(name = "blood_Sugar_Range")
    private String bloodSugarRange;

    @Column(name = "job_Profession")
    private String jobProfession;

    @Column(name = "smoking_habit", columnDefinition = "ENUM('Yes','No') DEFAULT 'No'")
    private String smokingHabit = "No";

    @Column(name = "alcohol_habit", columnDefinition = "ENUM('Yes','No') DEFAULT 'No'")
    private String alcoholHabit = "No";

    @Column(name = "insulin_usage", columnDefinition = "ENUM('Yes','No') DEFAULT 'No'")
    private String insulinUsage = "No";

    @Column(name = "diabetes_type", nullable = false)
    private String diabetesType;



    
    
    
    public DiabeticUser() {
    	
    }
    
    public DiabeticUser(String name, int age, String gender, String email, String phone, String password, double weight,
			double height, String foodPreference, String allergies, String bloodSugarRange, String jobProfession,
			String smokingHabit, String alcoholHabit, String insulinUsage,String diabetesType) {
		super();
		
		this.name = name;
		this.age = age;
		this.gender = gender;
		this.email = email;
		this.phone = phone;
		this.password = password;
		this.weight = weight;
		this.height = height;
		this.foodPreference = foodPreference;
		this.allergies = allergies;
		this.bloodSugarRange = bloodSugarRange;
		this.jobProfession = jobProfession;
		this.smokingHabit = smokingHabit;
		this.alcoholHabit = alcoholHabit;
		this.insulinUsage = insulinUsage;
		this.diabetesType = diabetesType;
    
    // --- Getters and Setters ---


	}
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

    public int getAge() {
        return age;
    }
    public void setAge(int age) {
        this.age = age;
    }

    
    
    public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public double getWeight() {
        return weight;
    }
    public void setWeight(double weight) {
        this.weight = weight;
    }

    public double getHeight() {
        return height;
    }
    public void setHeight(double height) {
        this.height = height;
    }

    public String getFoodPreference() {
        return foodPreference;
    }
    public void setFoodPreference(String foodPreference) {
        this.foodPreference = foodPreference;
    }

    public String getAllergies() {
        return allergies;
    }
    public void setAllergies(String allergies) {
        this.allergies = allergies;
    }

    public String getBloodSugarRange() {
        return bloodSugarRange;
    }
    public void setBloodSugarRange(String bloodSugarRange) {
        this.bloodSugarRange = bloodSugarRange;
    }

    public String getJobProfession() {
        return jobProfession;
    }
    public void setJobProfession(String jobProfession) {
        this.jobProfession = jobProfession;
    }

    public String getSmokingHabit() {
        return smokingHabit;
    }
    public void setSmokingHabit(String smokingHabit) {
        this.smokingHabit = smokingHabit;
    }

    public String getAlcoholHabit() {
        return alcoholHabit;
    }
    public void setAlcoholHabit(String alcoholHabit) {
        this.alcoholHabit = alcoholHabit;
    }

    public String getInsulinUsage() {
        return insulinUsage;
    }
    public void setInsulinUsage(String insulinUsage) {
        this.insulinUsage = insulinUsage;
    }

    public String getDiabetesType() {
        return diabetesType;
    }
    public void setDiabetesType(String diabetesType) {
        this.diabetesType = diabetesType;
    }

	@Override
	public String toString() {
		return "DiabeticUser [id=" + id + ", name=" + name + ", age=" + age + ", gender=" + gender + ", email=" + email
				+ ", phone=" + phone + ", password=" + password + ", weight=" + weight + ", height=" + height
				+ ", foodPreference=" + foodPreference + ", allergies=" + allergies + ", bloodSugarRange="
				+ bloodSugarRange + ", jobProfession=" + jobProfession + ", smokingHabit=" + smokingHabit
				+ ", alcoholHabit=" + alcoholHabit + ", insulinUsage=" + insulinUsage + ", diabetesType=" + diabetesType
				+ "]";
	}
    


}
