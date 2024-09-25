package dao;

import java.sql.*;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import dao.*;
import bean.UserRegistration;
import dbconnection.DBConnection;

public class UserRegistrationDAO {
	
	
	 public void insertUser(UserRegistration user) throws SQLException {
	        String query = "INSERT INTO user_registration (fullName, dob, email, password) VALUES (?, ?, ?, ?)";

	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement statement = connection.prepareStatement(query)) {

	            statement.setString(1, user.getFullName());
	            statement.setDate(2, new java.sql.Date(user.getDob().getTime()));
	            statement.setString(3, user.getEmail());
	            statement.setString(4, user.getPassword());

	            statement.executeUpdate();
	        }
	    }

	 
	// Method to check if an email already exists
	    public boolean emailExists(String email) {
	        boolean exists = false;
	        String sql = "SELECT COUNT(*) FROM user_registration WHERE email = ?";

	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement statement = connection.prepareStatement(sql)) {
	            statement.setString(1, email);

	            try (ResultSet resultSet = statement.executeQuery()) {
	                if (resultSet.next() && resultSet.getInt(1) > 0) {
	                    exists = true;
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return exists;
	    }
	// Method to retrieve a user by email
	    public UserRegistration getUserByEmail(String email) throws SQLException {
	        String query = "SELECT * FROM user_registration WHERE email = ?";
	        UserRegistration user = null;

	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement statement = connection.prepareStatement(query)) {

	            statement.setString(1, email);
	            ResultSet resultSet = statement.executeQuery();

	            if (resultSet.next()) {
	                user = new UserRegistration();
	                user.setUser_id(resultSet.getInt("user_id"));
	                user.setFullName(resultSet.getString("fullName"));
	                user.setDob(resultSet.getDate("dob"));
	                user.setEmail(resultSet.getString("email"));
	                user.setPassword(resultSet.getString("password"));

	            }
	        }

	        return user;
	    }
	    
	    public int customerCount() throws SQLException {
	        String query = "SELECT COUNT(*) FROM user_registration";
	        
	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement statement = connection.prepareStatement(query);
	             ResultSet resultSet = statement.executeQuery()) {
	            
	            if (resultSet.next()) {
	                return resultSet.getInt(1); // Return the customer count
	            }
	        }
	        return 0; // Return 0 if no customers are found
	    }
	    public boolean updatePasswordByEmail(String email, String hashedPassword) {
	        String query = "UPDATE user_registration SET password = ? WHERE email = ?";
	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement statement = connection.prepareStatement(query)) {
	            
	            statement.setString(1, hashedPassword);
	            statement.setString(2, email);
	            
	            return statement.executeUpdate() > 0; // Returns true if the update was successful
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false; // In case of an error
	        }
	    }

	    
	    public List<UserRegistration> getAllUsers() throws SQLException {
	        List<UserRegistration> users = new ArrayList<>();
	        String query = "SELECT * FROM user_registration";

	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement statement = connection.prepareStatement(query);
	             ResultSet resultSet = statement.executeQuery()) {

	            while (resultSet.next()) {
	                UserRegistration user = new UserRegistration();
	                user.setUser_id(resultSet.getInt("user_id"));
	                user.setFullName(resultSet.getString("fullName"));
	                user.setDob(resultSet.getDate("dob"));
	                user.setEmail(resultSet.getString("email"));
	                users.add(user);
	            }
	        }

	        return users;
	    }

}
