package ma.ac.esi.nutritrack.service;

import ma.ac.esi.nutritrack.repository.IngredientRepository;

public class IngredientService {

    private final IngredientRepository ingredientRepository;

    public IngredientService() {
        this.ingredientRepository = new IngredientRepository();
    }

    /**
     * Ajoute un nouvel ingrédient à un repas spécifique.
     *
     * @param mealId     L'ID du repas auquel l'ingrédient est associé.
     * @param name       Le nom de l'ingrédient.
     * @param calories   Le nombre de calories de l'ingrédient.
     * @return true si l'ingrédient a été ajouté avec succès, sinon false.
     */
    public boolean addIngredientToMeal(int mealId, String name, double calories) {
        return ingredientRepository.addIngredient(mealId, name, calories);}
}