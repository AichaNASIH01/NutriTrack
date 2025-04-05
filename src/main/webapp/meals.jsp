<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="ma.ac.esi.nutritrack.model.Meal" %>
<%@ page import="ma.ac.esi.nutritrack.model.Ingredient" %>
<%@ page import="ma.ac.esi.nutritrack.model.User" %>

<%
    User user = (User) session.getAttribute("user");
%>

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
        .sidebar { height: 100vh; background-color: #2c2c54; color: white; padding-top: 20px; }
        .sidebar a { color: white; display: block; padding: 15px; text-decoration: none; text-align: center; }
        .sidebar a:hover { background-color: #57577d; }
        .meal-card { border-radius: 15px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .kcal-box { background-color: #fff; padding: 20px; border-radius: 15px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .meal-item { border-radius: 10px; background-color: #fff; padding: 10px; margin-bottom: 10px; text-align: center; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .meal-item img { width: 40px; height: 40px; display: block; margin: 0 auto 5px; }
        .user-info { padding: 15px; text-align: center; }
        .logout-btn { width: 100%; padding: 10px; background-color: #dc3545; color: white; border: none; border-radius: 5px; }
        .logout-btn:hover { background-color: #c82333; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 sidebar d-flex flex-column align-items-center">
                <div class="user-info"> 
                    <i class="bi bi-person-circle"></i> 
                    <span><%= (user != null) ? user.getFirstName() : "Utilisateur" %></span>
                    <br>
                    <small><%= (user != null) ? user.getRole() : "Rôle non défini" %></small>
                </div>

                <form action="LogoutController" method="post">
                    <button type="submit" class="logout-btn">
                        <i class="bi bi-box-arrow-right"></i> Déconnexion
                    </button>
                </form>

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
            <div class="col-md-10 p-4">
                <h2><strong>Meal plans</strong> / Gain weight</h2>

                <div class="row my-4">
                    <div class="col-md-6">
                        <img src="https://via.placeholder.com/600x300" class="img-fluid rounded" alt="Meal Image">
                    </div>
                    <div class="col-md-6 kcal-box">
                        <h3><strong>823 kcal</strong></h3>
                        <div class="progress my-3">
                            <div class="progress-bar" role="progressbar" style="width: 60%" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <p><i class="bi bi-fire"></i> 283 kcal burned</p>
                    </div>
                </div>

                <!-- Meals List -->
                <div class="row">
                    <%
                        List<Meal> meals = (List<Meal>) request.getAttribute("meals");
                        if (meals != null) {
                            for (Meal meal : meals) {
                                int totalCalories = 0;
                    %>
                    <div class="col-md-3">
                        <h5><%= meal.getName() %></h5>
                        <% for (Ingredient ing : meal.getIngredients()) {
                            totalCalories += ing.getCalories();
                        %>
                        <div class="meal-item">
                            <img src="img/<%= ing.getName().replaceAll(" ", "") %>.jpg" alt="<%= ing.getName() %>">
                            <%= ing.getName() %><br>
                            <small><%= ing.getCalories() %> kcal</small>
                        </div>
                        <% } %>
                        <p><strong>Total Calories: <%= totalCalories %> kcal</strong></p>
                    </div>
                    <% 
                            } 
                        } else { 
                    %>
                    <p>Aucun repas disponible.</p>
                    <% } %>
                </div>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
