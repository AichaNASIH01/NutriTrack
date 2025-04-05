package ma.ac.esi.nutritrack.util;

import java.sql.Connection;
import java.sql.SQLException;

public class DBUtilTest {
    public static void main(String[] args) {
        try {
            Connection connection = DBUtil.getConnection();
            if (connection != null) {
                System.out.println("Connection successful!");
                connection.close();
            } else {
                System.err.println("Failed to establish connection.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
