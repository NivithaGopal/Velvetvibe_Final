package bean;

import java.sql.Timestamp;

public class feedbackBean {
	private int feedback_id;
    private String email;
    private String comments;
    private java.sql.Timestamp created_at;
    
	public feedbackBean() {
		super();
	}
	public feedbackBean(int feedback_id, String email, String comments, Timestamp created_at) {
		super();
		this.feedback_id = feedback_id;
		this.email = email;
		this.comments = comments;
		this.created_at = created_at;
	}
	public int getFeedback_id() {
		return feedback_id;
	}
	public void setFeedback_id(int feedback_id) {
		this.feedback_id = feedback_id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public java.sql.Timestamp getCreated_at() {
		return created_at;
	}
	public void setCreated_at(java.sql.Timestamp created_at) {
		this.created_at = created_at;
	}
	@Override
	public String toString() {
		return "feedbackBean [feedback_id=" + feedback_id + ", email=" + email + ", comments=" + comments
				+ ", created_at=" + created_at + "]";
	}
    
	
    
}
