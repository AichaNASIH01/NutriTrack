package ma.ac.esi.nutritrack.repository;
import ma.ac.esi.nutritrack.model.Meal;
import ma.ac.esi.nutritrack.model.Ingredient;
import ma.ac.esi.nutritrack.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MealRepository {
	public List<Meal> getAllMeals() {
	    List<Meal> meals = new ArrayList<>();
	    String query = "SELECT m.id as meal_id, m.name as meal_name, " +
	                  "i.id as ing_id, i.name as ing_name, i.calories " +
	                  "FROM meals m " +
	                  "LEFT JOIN meal_ingredients mi ON m.id = mi.meal_id " +
	                  "LEFT JOIN ingredients i ON mi.ingredient_id = i.id " +
	                  "ORDER BY m.id";

	    try (Connection connection = DBUtil.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(query);
	         ResultSet rs = stmt.executeQuery()) {

	        Meal currentMeal = null;
	        while (rs.next()) {
	            int mealId = rs.getInt("meal_id");
	            
	            // Create new meal if different from current
	            if (currentMeal == null || currentMeal.getMealId() != mealId) {
	                String mealName = rs.getString("meal_name");
	                currentMeal = new Meal(mealId, mealName, new ArrayList<>());
	                meals.add(currentMeal);
	            }
	            
	            // Add ingredient if exists
	            int ingId = rs.getInt("ing_id");
	            if (!rs.wasNull()) {
	                currentMeal.getIngredients().add(new Ingredient(
	                    ingId,
	                    rs.getString("ing_name"),
	                    rs.getInt("calories")
	                ));
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return meals;
	}
}