<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, ma.ac.esi.nutritrack.model.Meal, ma.ac.esi.nutritrack.model.Ingredient" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Meal Plan - Gain Weight</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body {
  background-color: #fdfcfb; /* very soft cream */
  font-family: 'Segoe UI', sans-serif;
  color: #3e3e3e;
	}

	/* Sidebar */
	.sidebar {
  		position: fixed;
  		top: 0;
  		left: 0;
  		bottom: 0;
  		width: 125px;
  		background-color: #554c3b; /* deep earthy brown */
  		color: white;
  		padding-top: 20px;
  		box-shadow: 2px 0 6px rgba(0,0,0,0.1);
	}

	.sidebar a {
  		color: white;
  		display: block;
  		padding: 15px;
  		text-decoration: none;
  		text-align: center;
  		transition: background-color 0.3s;
	}

	.sidebar a:hover {
  		background-color: #776f5e;
	}

	.sidebar .user-info {
  		font-size: 0.9rem;
	}

	.sidebar form button:hover {
  		background-color: #6c6350;
	}

	/* Header Banner */
	.header-banner img {
  		width: 100%;
  		height: 300px;
  		object-fit: cover;
  		border-radius: 12px;
	}

	/* Main Content */
	.main-content {
  		margin-left: 200px;
  		padding: 30px;
	}

	/* Calories box */
	.kcal-box {
  		background-color: #fffbe6;
  		border-left: 6px solid #e0b146;
 		padding: 20px;
  		border-radius: 12px;
  		box-shadow: 0 2px 6px rgba(0,0,0,0.05);
	}

	.kcal-box h3 {
  		color: #b46b00;
	}

	.progress-bar {
  		background-color: #f2a541;
		}

	/* Meal card and items */
	.meal-item {
  		background-color: #fff;
  		padding: 12px;
  		margin-bottom: 10px;
  		text-align: center;
  		box-shadow: 0 2px 5px rgba(0,0,0,0.05);
  		border-radius: 10px;
  		position: relative;
  		transition: transform 0.2s ease;
	}

	.meal-item:hover {
  		transform: scale(1.02);
	}

	.meal-item img {
  		width: 40px;
  		height: 40px;
  		margin-bottom: 5px;
	}

	.meal-total {
  		font-weight: bold;
  		color: #28a745;
  		margin-top: 10px;
	}

	.meal-actions {
  		position: absolute;
  		top: 5px;
  		right: 5px;
	}

	.meal-actions button {
  		padding: 0.25rem 0.5rem;
  		font-size: 0.75rem;
	}

	/* Buttons */
	.btn-primary {
  		background-color: #f2a541;
  		border-color: #f2a541;
  		color: white;
	}

	.btn-primary:hover {
  		background-color: #e0912b;
  		border-color: #e0912b;
	}

	.btn-success {
  		background-color: #68a357;
  		border-color: #68a357;
	}

	.btn-success:hover {
  		background-color: #5a8f4d;
	}

	/* Modal Styling (optional if you want coherence) */
	.modal-content {
  		border-radius: 10px;
  		box-shadow: 0 5px 20px rgba(0,0,0,0.1);
	}
    
  </style>
  <script>
  	const modal = document.querySelectorAll('.modal');
  	modal.forEach(m => {
    	m.addEventListener('show.bs.modal', () => {
      		document.body.style.overflow = 'hidden';
    	});
    	m.addEventListener('hidden.bs.modal', () => {
      		document.body.style.overflow = 'auto';
    	});
  	});
	</script>
  
</head>
<body>
  <div class="container-fluid">
    <div class="row">
      <!-- Sidebar -->
	<div class="col-md-2 sidebar d-flex flex-column justify-content-between align-items-center">
	  <div class="pt-3 w-100 d-flex flex-column align-items-center">
	    <a href="#"><i class="bi bi-grid"></i></a>
	    <a href="#"><i class="bi bi-search"></i></a>
	    <a href="#"><i class="bi bi-people"></i></a>
	    <a href="#"><i class="bi bi-star"></i></a>
	    <a href="#"><i class="bi bi-calendar"></i></a>
	    <a href="#"><i class="bi bi-check-square"></i></a>
	    <a href="#"><i class="bi bi-chat"></i></a>
	    <a href="#"><i class="bi bi-envelope"></i></a>
	  </div>

  <!-- User Info & Logout -->
  <div class="mb-3 text-center">
    <div class="user-info text-white">
      <i class="bi bi-person-circle fs-4"></i><br>
      <span><%= session.getAttribute("login") != null ? session.getAttribute("login") : "Utilisateur" %></span>
    </div>
    <form action="LogoutController" method="post" class="mt-2">
      <button type="submit" class="btn btn-outline-light btn-sm">
        <i class="bi bi-box-arrow-right"></i> Déconnexion
      </button>
    </form>
  </div>
</div>
      
      
      <!-- Main Content -->
      <div class="col-md-10 main-content">
        <!-- Header Banner Image -->
        <div class="header-banner mb-3">
          <img src="https://www.weljii.com/wp-content/uploads/2024/06/apr-4.jpg" class="img-fluid rounded" alt="Banner Image">
        </div>

        <h2><strong>Meal plans</strong> / Gain weight</h2>
        
        <!-- Add Ingredient Button -->
        <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addIngredientModal">
          <i class="bi bi-plus-lg"></i> Ajouter un ingrédient
        </button>

        <!-- Calories Section -->
        <div class="row my-4">
          <div class="col-md-6 kcal-box">
            <h3><strong>
              <% 
                int totalCalories = 0;
                List<Meal> meals = (List<Meal>) request.getAttribute("meals");
                if(meals != null) {
                  for(Meal meal : meals) {
                    for(Ingredient ing : meal.getIngredients()) {
                      totalCalories += ing.getCalories();
                    }
                  }
                }
                out.print(totalCalories);
              %> kcal</strong></h3>
            <div class="progress my-3">
              <div class="progress-bar" role="progressbar" style="width: 60%" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
            </div>
            <p><i class="bi bi-fire"></i> 283 kcal burned</p>
          </div>
        </div>

        <!-- Dynamic Meals Section -->
        <div class="row">
          <%
            if(meals != null) {
              for(Meal meal : meals) {
                int mealTotal = 0;
          %>
          <div class="col-md-3">
            <h5><%= meal.getName() %></h5>
            <% for(Ingredient ing : meal.getIngredients()) { 
                 mealTotal += ing.getCalories(); %>
              <div class="meal-item">
                <div class="meal-actions">
                  <button class="btn btn-sm btn-warning" data-bs-toggle="modal" 
                          data-bs-target="#editIngredientModal" 
                          data-id="<%= ing.getId() %>"
                          data-name="<%= ing.getName() %>"
                          data-calories="<%= ing.getCalories() %>">
                    <i class="bi bi-pencil"></i>
                  </button>
                  <button class="btn btn-sm btn-danger" 
                          onclick="confirmDelete(<%= ing.getId() %>)">
                    <i class="bi bi-trash"></i>
                  </button>
                </div>
                <img src="img/<%= ing.getName().replaceAll(" ", "") %>.jpg" 
                     alt="<%= ing.getName() %>">
                <%= ing.getName() %><br>
                <small><%= ing.getCalories() %> kcal</small>
              </div>
            <% } %>
            <div class="meal-total">
              Total: <%= mealTotal %> kcal
            </div>
          </div>
          <% }
            } else { %>
              <div class="col-12">
                <p class="text-danger">No meals available. Please check back later.</p>
              </div>
          <% } %>
        </div>
      </div>
    </div>
  </div>

  <!-- Add Ingredient Modal -->
  <div class="modal fade" id="addIngredientModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Ajouter un nouvel ingrédient</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form action="IngredientController" method="POST">
            <input type="hidden" name="action" value="add">
            <div class="mb-3">
              <label class="form-label">Repas</label>
              <select class="form-control" name="mealId" required>
                <% for (Meal meal : meals) { %>
                  <option value="<%= meal.getMealId() %>"><%= meal.getName() %></option>
                <% } %>
              </select>
            </div>
            <div class="mb-3">
              <label class="form-label">Nom de l'ingrédient</label>
              <input type="text" class="form-control" name="name" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Calories</label>
              <input type="number" class="form-control" name="calories" required>
            </div>
            <button type="submit" class="btn btn-success">Ajouter</button>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- Edit Ingredient Modal -->
  <div class="modal fade" id="editIngredientModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Modifier l'ingrédient</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form action="IngredientController" method="POST">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" id="editIngredientId">
            <div class="mb-3">
              <label class="form-label">Nom</label>
              <input type="text" class="form-control" name="name" id="editIngredientName" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Calories</label>
              <input type="number" class="form-control" name="calories" id="editIngredientCalories" required>
            </div>
            <button type="submit" class="btn btn-primary">Sauvegarder</button>
          </form>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // Initialize edit modal
    document.getElementById('editIngredientModal').addEventListener('show.bs.modal', function (event) {
      var button = event.relatedTarget;
      document.getElementById('editIngredientId').value = button.getAttribute('data-id');
      document.getElementById('editIngredientName').value = button.getAttribute('data-name');
      document.getElementById('editIngredientCalories').value = button.getAttribute('data-calories');
    });

    function confirmDelete(id) {
      if (confirm("Êtes-vous sûr de vouloir supprimer cet ingrédient?")) {
        fetch('IngredientController?id=' + id + '&action=delete', {method: 'POST'})
          .then(response => {
            if (response.ok) {
              window.location.reload();
            } else {
              alert("Erreur lors de la suppression");
            }
          });
      }
    }
  </script>
</body>
</html>
