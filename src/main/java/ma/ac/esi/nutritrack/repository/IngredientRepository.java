package ma.ac.esi.nutritrack.repository;
import ma.ac.esi.nutritrack.model.Meal;
import ma.ac.esi.nutritrack.util.DBUtil;
import ma.ac.esi.nutritrack.model.Ingredient;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class IngredientRepository {

    // Méthode pour ajouter un nouvel ingrédient
    public boolean addIngredient(int mealId, String name, double calories) {
        String sql = "INSERT INTO ingredients (meal_id, name, calories) VALUES (?, ?, ?)";

        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            // Définir les paramètres de la requête
            statement.setInt(1, mealId);
            statement.setString(2, name);
            statement.setDouble(3, calories);

            // Exécuter la requête
            int rowsAffected = statement.executeUpdate();

            // Retourner true si l'insertion a réussi
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
