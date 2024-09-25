package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import bean.UserProfileBean;
import dbconnection.DBConnection;

public class UserProfileDAO {

    // Method to get user by email	
	public UserProfileBean getUserByEmail(String email) {
	    UserProfileBean user = null;
	    String sqlProfile = "SELECT ur.fullName, ur.dob, ur.email, ur.address, ur.mobile_number FROM user_profile ur WHERE ur.email = ?";
	    String sqlRegistration = "SELECT ur.fullName, ur.dob, ur.email, ur.password FROM user_registration ur WHERE ur.email = ?";

	    try (Connection conn = DBConnection.getConnection()) {
	        // Check user_profile table first
	        try (PreparedStatement stmt = conn.prepareStatement(sqlProfile)) {
	            stmt.setString(1, email);
	            ResultSet rs = stmt.executeQuery();

	            if (rs.next()) {
	                user = new UserProfileBean();
	                user.setFullName(rs.getString("fullName"));
	                user.setDob(rs.getDate("dob"));
	                user.setEmail(rs.getString("email"));
	                user.setAddress(rs.getString("address"));
	                user.setMobileNumber(rs.getString("mobile_number")); // Set mobile number
	                return user; // Return if found in user_profile
	            }
	        }

	        // If not found in user_profile, check user_registration table
	        try (PreparedStatement stmt = conn.prepareStatement(sqlRegistration)) {
	            stmt.setString(1, email);
	            ResultSet rs = stmt.executeQuery();

	            if (rs.next()) {
	                user = new UserProfileBean();
	                user.setFullName(rs.getString("fullName"));
	                user.setDob(rs.getDate("dob"));
	                user.setEmail(rs.getString("email"));
	                // In user_registration, there might not be an address or mobile_number, handle accordingly
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return user;
	}


    public boolean insertOrUpdateUserProfile(UserProfileBean userProfile) {
        boolean isInsertedOrUpdated = false;
        String checkQuery = "SELECT COUNT(*) FROM user_profile WHERE email = ?";
        String insertQuery = "INSERT INTO user_profile (email, fullName, dob, address, mobile_number) VALUES (?, ?, ?, ?, ?)";
        String updateQuery = "UPDATE user_profile SET fullName = ?, dob = ?, address = ?, mobile_number = ? WHERE email = ?";

        try (Connection conn = DBConnection.getConnection()) {

            // Check if the user profile already exists
            try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                checkStmt.setString(1, userProfile.getEmail());
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        // User exists, update the profile
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                            updateStmt.setString(1, userProfile.getFullName());
                            updateStmt.setDate(2, userProfile.getDob());
                            updateStmt.setString(3, userProfile.getAddress());
                            updateStmt.setString(4, userProfile.getMobileNumber());
                            updateStmt.setString(5, userProfile.getEmail());

                            int rowsAffected = updateStmt.executeUpdate();
                            isInsertedOrUpdated = rowsAffected > 0;
                        }
                    } else {
                        // User does not exist, insert a new profile
                        try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                            insertStmt.setString(1, userProfile.getEmail());
                            insertStmt.setString(2, userProfile.getFullName());
                            insertStmt.setDate(3, userProfile.getDob());
                            insertStmt.setString(4, userProfile.getAddress());
                            insertStmt.setString(5, userProfile.getMobileNumber());

                            int rowsAffected = insertStmt.executeUpdate();
                            isInsertedOrUpdated = rowsAffected > 0;
                        }
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isInsertedOrUpdated;
    }

    
    public UserProfileBean getUserByEmailId(String email) {
        UserProfileBean user = null;
        String query = "SELECT * FROM users WHERE email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                user = new UserProfileBean();
                user.setUserId(rs.getInt("user_id")); // Ensure this column name matches your DB
                // Set other properties as needed
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return user;
    }

}
