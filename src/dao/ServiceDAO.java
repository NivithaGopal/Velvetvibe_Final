package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.addServiceBean;
import dbconnection.DBConnection;


public class ServiceDAO {

	// Method to add a service
	public boolean addService(addServiceBean service) {
		if (isServiceNameExists(service.getServiceName())) {
			System.out.println("Service name already exists.");
			return false;
		}

		String sql = "INSERT INTO services (service_name) VALUES (?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setString(1, service.getServiceName());

			int rowsInserted = stmt.executeUpdate();
			return rowsInserted > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// Method to check if a service name already exists
	private boolean isServiceNameExists(String serviceName) {
		String sql = "SELECT COUNT(*) FROM services WHERE service_name = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setString(1, serviceName);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1) > 0;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<addServiceBean> getAllServices() {
		List<addServiceBean> services = new ArrayList<>();
		String sql = "SELECT * FROM services";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql);
				ResultSet rs = stmt.executeQuery()) {

			while (rs.next()) {
				addServiceBean service = new addServiceBean();
				service.setService_id(rs.getInt("service_id"));
				service.setServiceName(rs.getString("service_name"));
				services.add(service);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return services;
	}

	// Method to update a service
	public boolean updateService(addServiceBean service) {
		String sql = "UPDATE services SET service_name = ? WHERE service_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setString(1, service.getServiceName());
			stmt.setInt(2, service.getService_id());

			int rowsUpdated = stmt.executeUpdate();
			return rowsUpdated > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// Method to get a service by ID
	public addServiceBean getServiceById(int serviceId) {
		String sql = "SELECT * FROM services WHERE service_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setInt(1, serviceId);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				addServiceBean service = new addServiceBean();
				service.setService_id(rs.getInt("service_id"));
				service.setServiceName(rs.getString("service_name"));
				return service;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	// Method to delete a service
	public boolean deleteService(int serviceId) {
		String sql = "DELETE FROM services WHERE service_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setInt(1, serviceId);

			int rowsDeleted = stmt.executeUpdate();
			return rowsDeleted > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	 public int getServicesCount() throws SQLException {
	        String query = "SELECT COUNT(*) FROM services"; // Adjust table name if necessary
	        try (Connection conn = DBConnection.getConnection();
	        		PreparedStatement statement = conn.prepareStatement(query);
	             ResultSet resultSet = statement.executeQuery()) {
	            if (resultSet.next()) {
	                return resultSet.getInt(1);
	            }
	        }
	        return 0;
	    }
	    
	 public List<addServiceBean> getAllServices1() {
	        List<addServiceBean> services = new ArrayList<>();
	        String sql = "SELECT * FROM services";
	        try (Connection conn = DBConnection.getConnection();
	             PreparedStatement stmt = conn.prepareStatement(sql);
	             ResultSet rs = stmt.executeQuery()) {
	            while (rs.next()) {
	            	addServiceBean service = new addServiceBean();
	                service.setService_id(rs.getInt("service_id"));
	                service.setServiceName(rs.getString("service_name"));
	                services.add(service);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return services;
	    }

}
