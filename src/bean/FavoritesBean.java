package bean;

public class FavoritesBean {
	private int favorite_id;
    private int userId;
    private int servicevv_id;
    private String email;
    private String service_name;
    private String category_name;
    private String description;
    private int amount_from;
    private int amount_to;
	private String image1;
    private String image2;
    private String image3;
	
    
    
    public FavoritesBean() {
		super();
	}

	public FavoritesBean(int favorite_id, int userId, int servicevv_id, String email, String service_name,
			String category_name, String description, int amount_from, int amount_to, String image1, String image2,
			String image3) {
		super();
		this.favorite_id = favorite_id;
		this.userId = userId;
		this.servicevv_id = servicevv_id;
		this.email = email;
		this.service_name = service_name;
		this.category_name = category_name;
		this.description = description;
		this.amount_from = amount_from;
		this.amount_to = amount_to;
		this.image1 = image1;
		this.image2 = image2;
		this.image3 = image3;
	}

	@Override
	public String toString() {
		return "FavoritesBean [favorite_id=" + favorite_id + ", userId=" + userId + ", servicevv_id=" + servicevv_id
				+ ", email=" + email + ", service_name=" + service_name + ", category_name=" + category_name
				+ ", description=" + description + ", amount_from=" + amount_from + ", amount_to=" + amount_to
				+ ", image1=" + image1 + ", image2=" + image2 + ", image3=" + image3 + "]";
	}
    
	public int getFavorite_id() {
		return favorite_id;
	}
	public void setFavorite_id(int favorite_id) {
		this.favorite_id = favorite_id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getServicevv_id() {
		return servicevv_id;
	}
	public void setServicevv_id(int servicevv_id) {
		this.servicevv_id = servicevv_id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getService_name() {
		return service_name;
	}
	public void setService_name(String service_name) {
		this.service_name = service_name;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getImage1() {
		return image1;
	}
	public void setImage1(String image1) {
		this.image1 = image1;
	}
	public String getImage2() {
		return image2;
	}
	public void setImage2(String image2) {
		this.image2 = image2;
	}
	public String getImage3() {
		return image3;
	}
	public void setImage3(String image3) {
		this.image3 = image3;
	}

	public int getAmount_from() {
		return amount_from;
	}

	public void setAmount_from(int amount_from) {
		this.amount_from = amount_from;
	}

	public int getAmount_to() {
		return amount_to;
	}

	public void setAmount_to(int amount_to) {
		this.amount_to = amount_to;
	}
    
    

}
