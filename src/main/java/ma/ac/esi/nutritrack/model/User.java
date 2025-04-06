package ma.ac.esi.nutritrack.model;

public class User {
    private String email;
    private String password;
    private String firstName;  // Add this field
    private String role;      // Add this field

    // Existing getters and setters
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // Add new getters and setters for firstName
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    // Add new getters and setters for role
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}