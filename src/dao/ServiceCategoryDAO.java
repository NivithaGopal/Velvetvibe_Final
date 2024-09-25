package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.ServiceCategoryBean;
import dbconnection.DBConnection;
import bean.ServiceCategoryBean;

public class ServiceCategoryDAO {

    public String getServiceNameById(int serviceId) throws SQLException {
        String serviceName = null;
        String query = "SELECT service_name FROM services WHERE service_id = ?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, serviceId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                serviceName = rs.getString("service_name");
            }
        }
        return serviceName;
    }


    // Method to add a new category
    public void addCategory(ServiceCategoryBean category) throws SQLException {
        String query = "INSERT INTO service_category (categoryName, serviceCategory, servicePrice, serviceDescription) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, category.getCategoryName());
            stmt.setInt(2, category.getServiceCategory());
            stmt.setInt(3, category.getServicePrice());
            stmt.setString(4, category.getServiceDescription());
            stmt.executeUpdate();
        }
    }

    public List<ServiceCategoryBean> getAllCategories() throws SQLException {
        List<ServiceCategoryBean> categories = new ArrayList<>();
        String query = "SELECT sc.categoryId, sc.categoryName, s.service_name, sc.servicePrice, sc.serviceDescription " +
                       "FROM service_category sc " +
                       "JOIN services s ON sc.serviceCategory = s.service_id";
        
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                ServiceCategoryBean category = new ServiceCategoryBean();
                category.setCategoryId(rs.getInt("categoryId"));
                category.setCategoryName(rs.getString("categoryName"));
                category.setServiceName(rs.getString("service_name"));
                category.setServicePrice(rs.getInt("servicePrice"));
                category.setServiceDescription(rs.getString("serviceDescription"));

                categories.add(category);
            }
        }
        return categories;
    }

    public boolean updateCategory(ServiceCategoryBean category) throws SQLException {
        String query = "UPDATE service_category SET categoryName = ?, serviceCategory = ?, servicePrice = ?, serviceDescription = ? WHERE categoryId = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, category.getCategoryName());
            stmt.setInt(2, category.getServiceCategory());
            stmt.setInt(3, category.getServicePrice());
            stmt.setString(4, category.getServiceDescription());
            stmt.setInt(5, category.getCategoryId());
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        }
    }

    // Method to retrieve a single category by its ID
    public ServiceCategoryBean getCategoryById(int categoryId) throws SQLException {
        ServiceCategoryBean category = null;
        String query = "SELECT * FROM service_category WHERE categoryId = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    category = new ServiceCategoryBean();
                    category.setCategoryId(rs.getInt("categoryId"));
                    category.setCategoryName(rs.getString("categoryName"));
                    category.setServiceCategory(rs.getInt("serviceCategory"));
                    category.setServicePrice(rs.getInt("servicePrice"));
                    category.setServiceDescription(rs.getString("serviceDescription"));
                }
            }
        }
        return category;
    }
 // Method to delete a category by its ID
    public boolean deleteCategoryById(int categoryId) throws SQLException {
        String query = "DELETE FROM service_category WHERE categoryId = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, categoryId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        }
    }

    public List<ServiceCategoryBean> getAllCategoriesWithServiceNames() throws SQLException {
        List<ServiceCategoryBean> categories = new ArrayList<>();
        String query = "SELECT sc.categoryId, sc.categoryName, sc.serviceCategory, " +
                       "sc.servicePrice, sc.serviceDescription, s.service_name " +
                       "FROM service_category sc " +
                       "LEFT JOIN services s ON sc.serviceCategory = s.service_id";

        try (Connection conn = DBConnection.getConnection(); // Assuming DBConnection is a class to manage DB connection
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                ServiceCategoryBean category = new ServiceCategoryBean();
                category.setCategoryId(rs.getInt("categoryId"));
                category.setCategoryName(rs.getString("categoryName"));
                category.setServiceCategory(rs.getInt("serviceCategory"));
                category.setServicePrice(rs.getInt("servicePrice"));
                category.setServiceDescription(rs.getString("serviceDescription"));
                category.setServiceName(rs.getString("service_name")); // Assuming you added this field to the bean
                categories.add(category);
            }
        }
        return categories;
    }

    public List<ServiceCategoryBean> getServiceNamesWithCategories() throws SQLException {
        List<ServiceCategoryBean> serviceCategories = new ArrayList<>();
        
        String query = "SELECT s.service_id, s.service_name, sc.categoryId, sc.categoryName " +
                       "FROM services s " +
                       "JOIN service_category sc ON s.service_id = sc.serviceCategory";
        
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query); 
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ServiceCategoryBean category = new ServiceCategoryBean();
                category.setServiceCategory(rs.getInt("service_id"));  // Assuming you have a field to hold service_id
                category.setServiceName(rs.getString("service_name"));
                category.setCategoryId(rs.getInt("categoryId"));
                category.setCategoryName(rs.getString("categoryName"));

                serviceCategories.add(category);
            }
        }
        return serviceCategories;
    }
    
    public List<ServiceCategoryBean> getCategoriesByServiceId(int serviceId) throws SQLException {
        List<ServiceCategoryBean> categories = new ArrayList<>();
        String query = "SELECT sc.categoryId, sc.categoryName " +
                       "FROM service_category sc " +
                       "WHERE sc.serviceCategory = ?";

        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, serviceId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ServiceCategoryBean category = new ServiceCategoryBean();
                    category.setCategoryId(rs.getInt("categoryId"));
                    category.setCategoryName(rs.getString("categoryName"));
                    categories.add(category);
                }
            }
        }
        return categories;
    }
    
    public List<ServiceCategoryBean> getAllCategories1() {
        List<ServiceCategoryBean> categories = new ArrayList<>();
        String query = "SELECT sc.categoryId, sc.categoryName, s.service_name " +
                       "FROM service_category sc " +
                       "JOIN services s ON sc.serviceCategory = s.service_id";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                ServiceCategoryBean category = new ServiceCategoryBean();
                category.setCategoryId(rs.getInt("categoryId"));
                category.setCategoryName(rs.getString("categoryName"));
                category.setServiceName(rs.getString("service_name"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }
}
