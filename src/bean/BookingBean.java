package bean;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;

public class BookingBean {
	private int bookingId;
    private int serviceId;
    private String serviceName;
    private int amountFrom;
    private int amountTo;
    private LocalDate appointmentDate; // Using LocalDate for better date handling
    private String appointmentTime;
    private String userEmail;
    private String paymentId;
    private String paymentStatus;
	public BookingBean(int bookingId, int serviceId, String serviceName, int amountFrom, int amountTo,
			LocalDate appointmentDate, String appointmentTime, String userEmail, String paymentId,
			String paymentStatus) {
		super();
		this.bookingId = bookingId;
		this.serviceId = serviceId;
		this.serviceName = serviceName;
		this.amountFrom = amountFrom;
		this.amountTo = amountTo;
		this.appointmentDate = appointmentDate;
		this.appointmentTime = appointmentTime;
		this.userEmail = userEmail;
		this.paymentId = paymentId;
		this.paymentStatus = paymentStatus;
	}
	public BookingBean() {
		super();
	}
	@Override
	public String toString() {
		return "BookingBean [bookingId=" + bookingId + ", serviceId=" + serviceId + ", serviceName=" + serviceName
				+ ", amountFrom=" + amountFrom + ", amountTo=" + amountTo + ", appointmentDate=" + appointmentDate
				+ ", appointmentTime=" + appointmentTime + ", userEmail=" + userEmail + ", paymentId=" + paymentId
				+ ", paymentStatus=" + paymentStatus + "]";
	}
	public int getBookingId() {
		return bookingId;
	}
	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}
	public int getServiceId() {
		return serviceId;
	}
	public void setServiceId(int serviceId) {
		this.serviceId = serviceId;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public int getAmountFrom() {
		return amountFrom;
	}
	public void setAmountFrom(int amountFrom) {
		this.amountFrom = amountFrom;
	}
	public int getAmountTo() {
		return amountTo;
	}
	public void setAmountTo(int amountTo) {
		this.amountTo = amountTo;
	}
	public LocalDate getAppointmentDate() {
		return appointmentDate;
	}
	public void setAppointmentDate(String appointmentDate) {
	    this.appointmentDate = LocalDate.parse(appointmentDate); // Convert string to LocalDate
	}


	public String getAppointmentTime() {
		return appointmentTime;
	}
	public void setAppointmentTime(String appointmentTime) {
		this.appointmentTime = appointmentTime;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}
	public String getPaymentStatus() {
		return paymentStatus;
	}
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
       
	
}
