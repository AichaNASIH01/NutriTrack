package ma.ac.esi.nutritrack.repository;

import ma.ac.esi.nutritrack.model.Meal;
import ma.ac.esi.nutritrack.util.DBUtil;
import ma.ac.esi.nutritrack.model.Ingredient;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement; // ✅ This was missing

public class IngredientRepository {

    public boolean addIngredientToMeal(int mealId, Ingredient ingredient) {
        String ingredientSql = "INSERT INTO ingredients (name, calories) VALUES (?, ?)";
        String junctionSql = "INSERT INTO meal_ingredients (meal_id, ingredient_id) VALUES (?, ?)";

        try (Connection connection = DBUtil.getConnection();
             PreparedStatement ingStmt = connection.prepareStatement(ingredientSql, Statement.RETURN_GENERATED_KEYS)) {

            // Insert ingredient
            ingStmt.setString(1, ingredient.getName());
            ingStmt.setInt(2, ingredient.getCalories());
            ingStmt.executeUpdate();

            // Get generated ingredient ID
            ResultSet rs = ingStmt.getGeneratedKeys();
            if (rs.next()) {
                int ingredientId = rs.getInt(1);

                // Link to meal
                try (PreparedStatement junctionStmt = connection.prepareStatement(junctionSql)) {
                    junctionStmt.setInt(1, mealId);
                    junctionStmt.setInt(2, ingredientId);
                    return junctionStmt.executeUpdate() > 0;
                }
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
