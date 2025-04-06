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
	    String action = request.getParameter("action");
	    IngredientService service = new IngredientService();
	    
	    if ("update".equals(action)) {
	        // Update existing ingredient
	        int id = Integer.parseInt(request.getParameter("id"));
	        String name = request.getParameter("name");
	        int calories = Integer.parseInt(request.getParameter("calories"));
	        boolean success = service.updateIngredient(id, name, calories);
	        response.sendRedirect(success ? "MealController" : "error.html");
	    } else if ("delete".equals(action)) {
	        // Delete ingredient
	        int id = Integer.parseInt(request.getParameter("id"));
	        boolean success = service.deleteIngredient(id);
	        response.sendRedirect(success ? "MealController" : "error.html");
	    } else {
	        // Add new ingredient (existing code)
	        int mealId = Integer.parseInt(request.getParameter("mealId"));
	        String name = request.getParameter("name");
	        double calories = Double.parseDouble(request.getParameter("calories"));
	        boolean success = service.addIngredientToMeal(mealId, name, calories);
	        response.sendRedirect(success ? "MealController" : "error.html");
	    }
	}

}
