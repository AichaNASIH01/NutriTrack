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
    body { background-color: #f8f9fa; }
    /* Fixed Sidebar */
    .sidebar {
      position: fixed;
      top: 0;
      left: 0;
      bottom: 0;
      width: 200px; /* Adjust width as needed */
      background-color: #2c2c54;
      color: white;
      padding-top: 20px;
    }
    .sidebar a {
      color: white;
      display: block;
      padding: 15px;
      text-decoration: none;
      text-align: center;
    }
    .sidebar a:hover { background-color: #57577d; }
    .logout-btn {
      width: 100%;
      padding: 10px;
      background-color: #dc3545;
      color: white;
      border: none;
      border-radius: 5px;
      margin: 10px 0;
    }
    .logout-btn:hover { background-color: #c82333; }
    .meal-card { border-radius: 15px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
    .kcal-box { background-color: #fff; padding: 20px; border-radius: 15px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
    .meal-item { border-radius: 10px; background-color: #fff; padding: 10px; margin-bottom: 10px; text-align: center; box-shadow: 0 1px 3px rgba(0,0,0,0.1); position: relative; }
    .meal-item img { width: 40px; height: 40px; display: block; margin: 0 auto 5px; }
    .meal-total { font-weight: bold; color: #28a745; margin-top: 10px; }
    .meal-actions { position: absolute; top: 5px; right: 5px; }
    .meal-actions button { padding: 0.25rem 0.5rem; font-size: 0.75rem; }
    /* Header Banner Style */
    .header-banner img { 
      width: 100%; 
      height: 300px; /* Adjust height as needed */
      object-fit: cover; 
    }
    /* Main content margin to avoid sidebar overlap */
    .main-content {
      margin-left: 200px; /* Must match sidebar width */
      padding: 20px;
    }
  </style>
</head>
<body>
  <div class="container-fluid">
    <div class="row">
      <!-- Sidebar -->
      <div class="col-md-2 sidebar d-flex flex-column align-items-center">
        <!-- User Info and Logout -->
        <div class="user-info"> 
          <i class="bi bi-person-circle"></i> 
          <span><%= session.getAttribute("login") != null ? session.getAttribute("login") : "Utilisateur" %></span> 
        </div> 
        <form action="LogoutController" method="post"> 
          <button type="submit" class="logout-btn"><i class="bi bi-box-arrow-right"></i> Déconnexion</button> 
        </form>
        <!-- Navigation Links -->
        <a href="#"><i class="bi bi-grid"></i></a>
        <a href="#"><i class="bi bi-search"></i></a>
        <a href="#"><i class="bi bi-people"></i></a>
        <a href="#"><i class="bi bi-star"></i></a>
        <a href="#"><i class="bi bi-calendar"></i></a>
        <a href="#"><i class="bi bi-check-square"></i></a>
        <a href="#"><i class="bi bi-chat"></i></a>
        <a href="#"><i class="bi bi-envelope"></i></a>
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
