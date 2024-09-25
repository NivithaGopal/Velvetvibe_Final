package bean;

public class ServiceVelvetvibeBean {
	private int servicevv_id;
    private int service_id;
    private String Service_name;
    private int categoryId;
    private String categoryName;
    private String description;
    private String image1;
    private String image2;
    private String image3;
    private int amount_from;
    private int amount_to;
   

	
	public ServiceVelvetvibeBean() {
		super();
	}

	public ServiceVelvetvibeBean(int servicevv_id, String service_name, String categoryName, String description,
			String image1, String image2, String image3, int amount_from, int amount_to) {
		super();
		this.servicevv_id = servicevv_id;
		Service_name = service_name;
		this.categoryName = categoryName;
		this.description = description;
		this.image1 = image1;
		this.image2 = image2;
		this.image3 = image3;
		this.amount_from = amount_from;
		this.amount_to = amount_to;
	}

	public ServiceVelvetvibeBean(int servicevv_id, int service_id, String service_name, int categoryId,
			String categoryName, String description, String image1, String image2, String image3, int amount_from,
			int amount_to) {
		super();
		this.servicevv_id = servicevv_id;
		this.service_id = service_id;
		Service_name = service_name;
		this.categoryId = categoryId;
		this.categoryName = categoryName;
		this.description = description;
		this.image1 = image1;
		this.image2 = image2;
		this.image3 = image3;
		this.amount_from = amount_from;
		this.amount_to = amount_to;
	}

	@Override
	public String toString() {
		return "ServiceVelvetvibeBean [servicevv_id=" + servicevv_id + ", service_id=" + service_id + ", Service_name="
				+ Service_name + ", categoryId=" + categoryId + ", categoryName=" + categoryName + ", description="
				+ description + ", image1=" + image1 + ", image2=" + image2 + ", image3=" + image3 + ", amount_from="
				+ amount_from + ", amount_to=" + amount_to + "]";
	}

	public int getServicevv_id() {
		return servicevv_id;
	}
	public void setServicevv_id(int servicevv_id) {
		this.servicevv_id = servicevv_id;
	}
	public int getService_id() {
		return service_id;
	}
	public void setService_id(int service_id) {
		this.service_id = service_id;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
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
	public String getService_name() {
		return Service_name;
	}
	public void setService_name(String service_name) {
		Service_name = service_name;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
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
