package bean;

import java.util.Date;

public class UserRegistration {
	private int user_id;
    private String fullName;
    private Date dob;
    private String email;
    private String password;
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public Date getDob() {
		return dob;
	}
	public void setDob(Date dob) {
		this.dob = dob;
	}
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
	public UserRegistration(int user_id, String fullName, Date dob, String email, String password) {
		super();
		this.user_id = user_id;
		this.fullName = fullName;
		this.dob = dob;
		this.email = email;
		this.password = password;
	}
	public UserRegistration() {
		super();
	}
	@Override
	public String toString() {
		return "UserRegistration [user_id=" + user_id + ", fullName=" + fullName + ", dob=" + dob + ", email=" + email
				+ ", password=" + password + "]";
	}
    
    
    
}
