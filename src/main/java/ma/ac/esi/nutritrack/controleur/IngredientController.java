package ma.ac.esi.nutritrack.controleur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.ac.esi.nutritrack.service.IngredientService;

import java.io.IOException;

/**
 * Servlet implementation class IngredientController
 */
@WebServlet("/IngredientController")
public class IngredientController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IngredientController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les données du formulaire
        int mealId = Integer.parseInt(request.getParameter("mealId"));
        String name = request.getParameter("name");
        double calories = Double.parseDouble(request.getParameter("calories"));

        // Appeler le service pour ajouter l'ingrédient
        IngredientService ingredientService = new IngredientService();
        boolean success = ingredientService.addIngredientToMeal(mealId, name, calories);

        // Rediriger en fonction du résultat
        if (success) {
            response.sendRedirect("meals.jsp"); // Redirection vers une page de succès
        } else {
            response.sendRedirect("error.html");} // Redirection vers une page d'erreur
        }

}
