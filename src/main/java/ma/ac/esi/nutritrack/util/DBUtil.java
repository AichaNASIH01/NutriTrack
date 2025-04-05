package ma.ac.esi.nutritrack.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtil {

    // Informations de connexion à la base de données
    private static final String URL = "jdbc:mysql://localhost:3306/nutriwise";
    private static final String USER = "root";
    private static final String PASSWORD = "bfAhbm123456 /"; // Remplacez par votre mot de passe correct

    // Chargement du pilote JDBC MySQL
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Erreur : Pilote JDBC MySQL introuvable !");
            e.printStackTrace();
        }
    }

    /**
     * Obtient une connexion à la base de données.
     *
     * @return Une instance de Connection, ou null en cas d'échec.
     */
    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Établir la connexion
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Connexion à la base de données établie avec succès !");
        } catch (SQLException e) {
            System.err.println("Erreur lors de la connexion à la base de données !");
            e.printStackTrace();
        }
        return connection;
    }

    /**
     * Ferme une connexion à la base de données.
     *
     * @param connection La connexion à fermer.
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Connexion à la base de données fermée avec succès !");
            } catch (SQLException e) {
                System.err.println("Erreur lors de la fermeture de la connexion !");
                e.printStackTrace();
            }
        }
    }

    /**
     * Ferme un PreparedStatement.
     *
     * @param statement Le PreparedStatement à fermer.
     */
    public static void closeStatement(PreparedStatement statement) {
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                System.err.println("Erreur lors de la fermeture du PreparedStatement !");
                e.printStackTrace();
            }
        }
    }

    /**
     * Ferme un ResultSet.
     *
     * @param resultSet Le ResultSet à fermer.
     */
    public static void closeResultSet(ResultSet resultSet) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                System.err.println("Erreur lors de la fermeture du ResultSet !");
                e.printStackTrace();
            }
        }
    }
}