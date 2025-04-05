package ma.ac.esi.nutritrack.model;

import java.util.List;

public class Meal {
	private int mealId;
	private String name;
	private List<Ingredient> ingredients;
	// Constructeur
	public Meal(int mealId, String name, List<Ingredient> ingredients) {
	    this.mealId = mealId;
	    this.name = name;
	    this.ingredients = ingredients;
	}



    // Getters
    public String getName() {
        return name;
    }

    public List<Ingredient> getIngredients() {
        return ingredients;
    }
    public int getMealId() {
    	return mealId;
    }
    // Setters
    public void setName(String name) {
        this.name = name;
    }

    public void setIngredients(List<Ingredient> ingredients) {
        this.ingredients = ingredients;
    }
    public void setMealId(int mealId) {
    	this.mealId=mealId;
    }
}