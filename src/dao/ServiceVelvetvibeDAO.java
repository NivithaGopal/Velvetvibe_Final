package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import bean.ServiceVelvetvibeBean;
import dbconnection.DBConnection;

public class ServiceVelvetvibeDAO {


	public boolean addServiceVelvetvibe(ServiceVelvetvibeBean serviceVelvetvibe) {
	    String sql = "INSERT INTO service_velvetvibe (service_id, service_name, categoryId, categoryName, description, image1, image2, image3, amount_from, amount_to) "
	               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        // Ensure categoryId is valid
	        if (serviceVelvetvibe.getCategoryId() == 0) {
	            throw new SQLException("Invalid categoryId: " + serviceVelvetvibe.getCategoryId());
	        }

	        // Fetch service name and category name from their respective tables
	        String serviceName = getServiceName(serviceVelvetvibe.getService_id(), conn);
	        String categoryName = getCategoryName(serviceVelvetvibe.getCategoryId(), conn);

	        // Set values for the prepared statement
	        stmt.setInt(1, serviceVelvetvibe.getService_id());
	        stmt.setString(2, serviceName);
	        stmt.setInt(3, serviceVelvetvibe.getCategoryId());
	        stmt.setString(4, categoryName);
	        stmt.setString(5, serviceVelvetvibe.getDescription());
	        stmt.setString(6, serviceVelvetvibe.getImage1());
	        stmt.setString(7, serviceVelvetvibe.getImage2());
	        stmt.setString(8, serviceVelvetvibe.getImage3());
	        stmt.setInt(9, serviceVelvetvibe.getAmount_from());
	        stmt.setInt(10, serviceVelvetvibe.getAmount_to());

	        // Execute the update
	        int rowsInserted = stmt.executeUpdate();
	        return rowsInserted > 0;

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}


    private String getServiceName(int serviceId, Connection conn) throws SQLException {
        String sql = "SELECT service_name FROM services WHERE service_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, serviceId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("service_name");
                }
            }
        }
        return null;
    }

    private String getCategoryName(int categoryId, Connection conn) throws SQLException {
        String sql = "SELECT categoryName FROM service_category WHERE categoryId = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("categoryName");
                }
            }
        }
        return null;
    }

    public List<ServiceVelvetvibeBean> getAllServiceVelvetvibe() {
        List<ServiceVelvetvibeBean> services = new ArrayList<>();
        String sql = "SELECT svv.servicevv_id, svv.service_id, svv.categoryId, svv.description, svv.image1, svv.image2, svv.image3, svv.amount_from, svv.amount_to, "
                   + "s.service_name, sc.categoryName "
                   + "FROM service_velvetvibe svv "
                   + "JOIN services s ON svv.service_id = s.service_id "
                   + "JOIN service_category sc ON svv.categoryId = sc.categoryId";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ServiceVelvetvibeBean service = new ServiceVelvetvibeBean();
                service.setServicevv_id(rs.getInt("servicevv_id"));
                service.setService_id(rs.getInt("service_id"));
                service.setService_name(rs.getString("service_name"));
                service.setCategoryId(rs.getInt("categoryId"));
                service.setCategoryName(rs.getString("categoryName"));
                service.setDescription(rs.getString("description"));
                service.setImage1(rs.getString("image1"));
                service.setImage2(rs.getString("image2"));
                service.setImage3(rs.getString("image3"));
                service.setAmount_from(rs.getInt("amount_from"));
                service.setAmount_to(rs.getInt("amount_to"));

                services.add(service);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    
    public boolean updateServiceVelvetvibe(ServiceVelvetvibeBean serviceVelvetvibe) {
        String sql = "UPDATE service_velvetvibe SET service_id = ?, categoryId = ?, description = ?, image1 = ?, image2 = ?, image3 = ?, "
                   + "amount_from = ?, amount_to = ? WHERE servicevv_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, serviceVelvetvibe.getService_id());
            stmt.setInt(2, serviceVelvetvibe.getCategoryId());
            stmt.setString(3, serviceVelvetvibe.getDescription());
            stmt.setString(4, serviceVelvetvibe.getImage1());
            stmt.setString(5, serviceVelvetvibe.getImage2());
            stmt.setString(6, serviceVelvetvibe.getImage3());
            stmt.setInt(7, serviceVelvetvibe.getAmount_from());
            stmt.setInt(8, serviceVelvetvibe.getAmount_to());
            stmt.setInt(9, serviceVelvetvibe.getServicevv_id());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    
    public List<ServiceVelvetvibeBean> getServicesByIds(List<Integer> serviceIds) {
        List<ServiceVelvetvibeBean> services = new ArrayList<>();
        
        if (serviceIds == null || serviceIds.isEmpty()) {
            return services; // Return empty list if no IDs are provided
        }

        // Create a comma-separated list of placeholders for the SQL query
        String placeholders = String.join(",", serviceIds.stream().map(id -> "?").toArray(String[]::new));
        
        String sql = "SELECT svv.servicevv_id, svv.service_id, svv.categoryId, svv.description, svv.image1, svv.image2, svv.image3, svv.amount_from, svv.amount_to, "
                   + "s.service_name, sc.categoryName "
                   + "FROM service_velvetvibe svv "
                   + "JOIN services s ON svv.service_id = s.service_id "
                   + "JOIN service_category sc ON svv.categoryId = sc.categoryId "
                   + "WHERE svv.servicevv_id IN (" + placeholders + ")";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set the service IDs in the PreparedStatement
            for (int i = 0; i < serviceIds.size(); i++) {
                stmt.setInt(i + 1, serviceIds.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ServiceVelvetvibeBean service = new ServiceVelvetvibeBean();
                    service.setServicevv_id(rs.getInt("servicevv_id"));
                    service.setService_id(rs.getInt("service_id"));
                    service.setService_name(rs.getString("service_name"));
                    service.setCategoryId(rs.getInt("categoryId"));
                    service.setCategoryName(rs.getString("categoryName"));
                    service.setDescription(rs.getString("description"));
                    service.setImage1(rs.getString("image1"));
                    service.setImage2(rs.getString("image2"));
                    service.setImage3(rs.getString("image3"));
                    service.setAmount_from(rs.getInt("amount_from"));
                    service.setAmount_to(rs.getInt("amount_to"));

                    services.add(service);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }


    public ServiceVelvetvibeBean getServiceById(int servicevv_id) {
        ServiceVelvetvibeBean service = null;
        String sql = "SELECT s.servicevv_id, s.service_id, s.categoryId, s.description, s.image1, s.image2, s.image3, s.amount_from, s.amount_to, "
                   + "s.service_name, c.categoryName "
                   + "FROM service_velvetvibe s "
                   + "JOIN service_category c ON s.categoryId = c.categoryId "
                   + "WHERE s.servicevv_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, servicevv_id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    service = new ServiceVelvetvibeBean();
                    service.setServicevv_id(rs.getInt("servicevv_id"));
                    service.setService_id(rs.getInt("service_id"));
                    service.setService_name(rs.getString("service_name"));
                    service.setCategoryId(rs.getInt("categoryId"));
                    service.setCategoryName(rs.getString("categoryName"));
                    service.setDescription(rs.getString("description"));
                    service.setImage1(rs.getString("image1"));
                    service.setImage2(rs.getString("image2"));
                    service.setImage3(rs.getString("image3"));
                    service.setAmount_from(rs.getInt("amount_from"));
                    service.setAmount_to(rs.getInt("amount_to"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return service;
    }
    
 // Method to get all services
    public List<ServiceVelvetvibeBean> getAllServiceVelvetvibe1() {
        List<ServiceVelvetvibeBean> services = new ArrayList<>();
        String sql = "SELECT * FROM service_velvetvibe"; // Adjust SQL query according to your database schema

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)){
        	 try (ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ServiceVelvetvibeBean service = new ServiceVelvetvibeBean();
                service.setServicevv_id(rs.getInt("servicevv_id"));
                service.setService_id(rs.getInt("service_id"));
                service.setService_name(rs.getString("service_name"));
                service.setCategoryId(rs.getInt("categoryId"));
                service.setCategoryName(rs.getString("categoryName"));
                service.setDescription(rs.getString("description"));
                service.setImage1(rs.getString("image1"));
                service.setImage2(rs.getString("image2"));
                service.setImage3(rs.getString("image3"));
                service.setAmount_from(rs.getInt("amount_from"));
                service.setAmount_to(rs.getInt("amount_to"));

                services.add(service);
            }}
        } catch (SQLException e) {
            e.printStackTrace(); // Handle SQL exceptions
        }

        return services;
    }
    public List<ServiceVelvetvibeBean> getServiceByIdAndName(int serviceId, String serviceName) {
        List<ServiceVelvetvibeBean> services = new ArrayList<>();
        String sql = "SELECT svv.servicevv_id, svv.service_id, svv.categoryId, svv.description, svv.image1, svv.image2, svv.image3, svv.amount_from, svv.amount_to, "
                   + "s.service_name, sc.categoryName "
                   + "FROM service_velvetvibe svv "
                   + "JOIN services s ON svv.service_id = s.service_id "
                   + "JOIN service_category sc ON svv.categoryId = sc.categoryId "
                   + "WHERE svv.service_id = ? AND s.service_name = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, serviceId);
            stmt.setString(2, serviceName);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ServiceVelvetvibeBean service = new ServiceVelvetvibeBean();
                    service.setServicevv_id(rs.getInt("servicevv_id"));
                    service.setService_id(rs.getInt("service_id"));
                    service.setService_name(rs.getString("service_name"));
                    service.setCategoryId(rs.getInt("categoryId"));
                    service.setCategoryName(rs.getString("categoryName"));
                    service.setDescription(rs.getString("description"));
                    service.setImage1(rs.getString("image1"));
                    service.setImage2(rs.getString("image2"));
                    service.setImage3(rs.getString("image3"));
                    service.setAmount_from(rs.getInt("amount_from"));
                    service.setAmount_to(rs.getInt("amount_to"));

                    services.add(service);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }
    
    
    public boolean deleteServiceVelvetvibe(int servicevvId) {
        String sql = "DELETE FROM service_velvetvibe WHERE servicevv_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)){
        	stmt.setInt(1, servicevvId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<ServiceVelvetvibeBean> searchServices(String searchTerm) {
        List<ServiceVelvetvibeBean> services = new ArrayList<>();
        String query = "SELECT svv.servicevv_id, svv.service_id, svv.categoryId, svv.description, svv.image1, svv.image2, svv.image3, "
                     + "svv.amount_from, svv.amount_to, s.service_name, sc.categoryName "
                     + "FROM service_velvetvibe svv "
                     + "JOIN services s ON svv.service_id = s.service_id "
                     + "JOIN service_category sc ON svv.categoryId = sc.categoryId "
                     + "WHERE s.service_name LIKE ? OR sc.categoryName LIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            // Set the search term for both service_name and categoryName
            String searchWildcard = "%" + searchTerm + "%";
            ps.setString(1, searchWildcard);
            ps.setString(2, searchWildcard);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ServiceVelvetvibeBean service = new ServiceVelvetvibeBean();
                service.setServicevv_id(rs.getInt("servicevv_id"));
                service.setService_id(rs.getInt("service_id"));
                service.setService_name(rs.getString("service_name"));
                service.setCategoryId(rs.getInt("categoryId"));
                service.setCategoryName(rs.getString("categoryName"));
                service.setDescription(rs.getString("description"));
                service.setImage1(rs.getString("image1"));
                service.setImage2(rs.getString("image2"));
                service.setImage3(rs.getString("image3"));
                service.setAmount_from(rs.getInt("amount_from"));
                service.setAmount_to(rs.getInt("amount_to"));
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return services;
    }


}
