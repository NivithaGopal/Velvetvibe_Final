package dao;

import bean.BookingBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import dbconnection.DBConnection; // Assume you have a DBConnection class for getting the connection.

public class BookingDAO {

    private static final String INSERT_BOOKING_SQL = "INSERT INTO bookings (service_id, service_name, amount_from, amount_to, appointment_date, appointment_time, user_email, payment_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    
    public boolean saveBooking(BookingBean booking) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(INSERT_BOOKING_SQL);
            stmt.setInt(1, booking.getServiceId());
            stmt.setString(2, booking.getServiceName());
            stmt.setInt(3, booking.getAmountFrom());
            stmt.setInt(4, booking.getAmountTo());
            stmt.setDate(5, java.sql.Date.valueOf(booking.getAppointmentDate())); // Ensure the format is correct
            stmt.setString(6, booking.getAppointmentTime());
            stmt.setString(7, booking.getUserEmail());
            stmt.setString(8, booking.getPaymentId());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            // Close resources
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    public List<BookingBean> getBookingsByUserEmail(String email) {
        List<BookingBean> bookings = new ArrayList<>();
        
        String sql = "SELECT * FROM bookings WHERE user_email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    BookingBean booking = new BookingBean();
                    booking.setBookingId(rs.getInt("booking_id")); // Assuming there's a booking_id column
                    booking.setServiceId(rs.getInt("service_id"));
                    booking.setServiceName(rs.getString("service_name"));
                    booking.setAmountFrom(rs.getInt("amount_from"));
                    booking.setAmountTo(rs.getInt("amount_to"));

                    // Handle potential null for appointment_date
                    java.sql.Date sqlDate = rs.getDate("appointment_date");
                    if (sqlDate != null) {
                        booking.setAppointmentDate(sqlDate.toString()); // Use toString() to convert to String format
                    }

                    booking.setAppointmentTime(rs.getString("appointment_time"));
                    booking.setUserEmail(rs.getString("user_email"));
                    booking.setPaymentId(rs.getString("payment_id"));
                    
                    // Uncomment if you have a payment_status column in your bookings table
                    // booking.setPaymentStatus(rs.getString("payment_status"));

                    bookings.add(booking);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return bookings;
    }


    public String getPaymentStatusById(String paymentId) {
        String paymentStatus = null;
        String sql = "SELECT status FROM payments WHERE payment_id = ?"; // Adjust table and column names as necessary

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
             
        	stmt.setString(1, paymentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                paymentStatus = rs.getString("status"); // Adjust if necessary
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exceptions appropriately in production code
        }

        return paymentStatus;
    }
    
    
    public List<BookingBean> getAllBookings() {
        List<BookingBean> bookings = new ArrayList<>();
        
        String sql = "SELECT * FROM bookings"; // Adjust this query if needed
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                BookingBean booking = new BookingBean();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setServiceId(rs.getInt("service_id"));
                booking.setServiceName(rs.getString("service_name"));
                booking.setAmountFrom(rs.getInt("amount_from"));
                booking.setAmountTo(rs.getInt("amount_to"));
                java.sql.Date sqlDate = rs.getDate("appointment_date");
                if (sqlDate != null) {
                    booking.setAppointmentDate(sqlDate.toString()); // Use toString() to convert to String format
                }

                booking.setAppointmentTime(rs.getString("appointment_time"));
                booking.setUserEmail(rs.getString("user_email"));
                booking.setPaymentId(rs.getString("payment_id"));
                // Handle payment status if needed
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return bookings;
    }

}
