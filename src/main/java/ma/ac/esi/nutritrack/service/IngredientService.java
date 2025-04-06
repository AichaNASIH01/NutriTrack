package ma.ac.esi.nutritrack.service;

import ma.ac.esi.nutritrack.model.Ingredient;
import ma.ac.esi.nutritrack.repository.IngredientRepository;
import ma.ac.esi.nutritrack.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class IngredientService {

    private final IngredientRepository ingredientRepository;

    public IngredientService() {
        this.ingredientRepository = new IngredientRepository();
    }

    /**
     * Adds a new ingredient to a specific meal.
     *
     * @param mealId   The ID of the meal to which the ingredient is associated.
     * @param name     The name of the ingredient.
     * @param calories The number of calories of the ingredient.
     * @return true if the ingredient was added successfully, otherwise false.
     */
    public boolean addIngredientToMeal(int mealId, String name, double calories) {
        // Create an Ingredient object using the overloaded constructor (id is omitted because it will be auto-generated)
        Ingredient ingredient = new Ingredient(name, (int) calories);
        // Delegate to the repository method that links the ingredient to the meal
        return ingredientRepository.addIngredientToMeal(mealId, ingredient);
    }

    /**
     * Updates an existing ingredient.
     *
     * @param id       The ID of the ingredient to update.
     * @param name     The new name for the ingredient.
     * @param calories The new calorie count for the ingredient.
     * @return true if the ingredient was updated successfully, otherwise false.
     */
    public boolean updateIngredient(int id, String name, int calories) {
        String sql = "UPDATE ingredients SET name = ?, calories = ? WHERE id = ?";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setInt(2, calories);
            stmt.setInt(3, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Deletes an ingredient by its ID.
     *
     * @param id The ID of the ingredient to delete.
     * @return true if the ingredient was deleted successfully, otherwise false.
     */
    public boolean deleteIngredient(int id) {
        String sql = "DELETE FROM ingredients WHERE id = ?";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
