package dao;

import bean.GalleryBean;
import dbconnection.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GalleryDAO {

    // Method to add a new gallery entry
    public boolean addGallery(GalleryBean gallery) {
        String query = "INSERT INTO gallery (image1, image2) VALUES (?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, gallery.getImage1());
            ps.setString(2, gallery.getImage2());
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Method to retrieve all gallery entries
    public List<GalleryBean> getAllGalleries() {
        List<GalleryBean> galleries = new ArrayList<>();
        String query = "SELECT * FROM gallery";
        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                GalleryBean gallery = new GalleryBean();
                gallery.setGalleryId(rs.getInt("gallery_id"));
                gallery.setImage1(rs.getString("image1"));
                gallery.setImage2(rs.getString("image2"));
                galleries.add(gallery);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return galleries;
    }

    // Method to update gallery details
    public boolean updateGallery(GalleryBean gallery) throws SQLException {
        String query = "UPDATE gallery SET image1 = ?, image2 = ? WHERE gallery_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, gallery.getImage1());
            ps.setString(2, gallery.getImage2());
            ps.setInt(3, gallery.getGalleryId()); // This was missing in the original code

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Return true if the update was successful
        }
    }

    // Method to get gallery by ID
    public GalleryBean getGalleryById(int galleryId) throws SQLException {
        String query = "SELECT * FROM gallery WHERE gallery_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, galleryId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    GalleryBean gallery = new GalleryBean();
                    gallery.setGalleryId(rs.getInt("gallery_id"));
                    gallery.setImage1(rs.getString("image1"));
                    gallery.setImage2(rs.getString("image2"));
                    return gallery;
                }
            }
        }
        return null;
    }
    
 // Method to delete a gallery entry
    public boolean deleteGallery(int galleryId) throws SQLException {
        String query = "DELETE FROM gallery WHERE gallery_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, galleryId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Return true if the delete was successful
        }
    }
    
    public int galleryCount() throws SQLException {
        String query = "SELECT COUNT(image1) AS count_image1, COUNT(image2) AS count_image2 FROM gallery";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int countImage1 = rs.getInt("count_image1");
                int countImage2 = rs.getInt("count_image2");
                int totalImages = countImage1 + countImage2; // Sum the counts
                System.out.println("Count Image1: " + countImage1); // Debug print
                System.out.println("Count Image2: " + countImage2); // Debug print
                System.out.println("Total Images: " + totalImages); // Debug print
                return totalImages;
            } else {
                System.out.println("No data found"); // Debug print
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Print stack trace to identify any SQL errors
            throw e; // Re-throw the exception to ensure it's not swallowed
        }
        return 0; // Return 0 if no rows are found or an exception occurs
    }




}
