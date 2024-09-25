package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import bean.*;
import java.util.*;
import java.sql.*;

import dbconnection.*;

public class FavoriteDAO {

	public boolean addFavourite(int userId, int servicevvId) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    try {
	        // Establish connection
	        conn = DBConnection.getConnection(); // Ensure this returns a valid connection

	        // Prepare SQL statement
	        String sql = "INSERT INTO favourite (user_id, servicevv_id) VALUES (?, ?)";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, userId);
	        pstmt.setInt(2, servicevvId);

	        // Execute update
	        int rowsAffected = pstmt.executeUpdate();
	        return rowsAffected > 0;
	    } catch (SQLException e) {
	        e.printStackTrace(); // Print detailed error for debugging
	        return false;
	    } finally {
	        // Close resources
	        try {
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}


    
	public boolean removeFavorite(int userId, int serviceVvId) {
	    String query = "DELETE FROM favourite WHERE user_id = ? AND servicevv_id = ?";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(query)) {
	         
	        ps.setInt(1, userId);
	        ps.setInt(2, serviceVvId);
	        
	        int rowsAffected = ps.executeUpdate();
	        System.out.println("Rows affected by delete: " + rowsAffected); // Debug line
	        return rowsAffected > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

    public List<Integer> getFavoriteServiceIds(int userId) {
        List<Integer> serviceIds = new ArrayList<>();
        String query = "SELECT servicevv_id FROM favourite WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    serviceIds.add(rs.getInt("servicevv_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return serviceIds;
    }
    
    public List<ServiceVelvetvibeBean> getFavoriteServices(int userId) {
        List<Integer> favoriteServiceIds = getFavoriteServiceIds(userId);
        ServiceVelvetvibeDAO serviceDAO = new ServiceVelvetvibeDAO();
        return serviceDAO.getServicesByIds(favoriteServiceIds);
    }
    
    
   

}
