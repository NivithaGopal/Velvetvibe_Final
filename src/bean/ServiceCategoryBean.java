package bean;

public class ServiceCategoryBean {
	
	 private int categoryId;
	    private String categoryName;
	    private int serviceCategory;
	    private int servicePrice;
	    private String serviceDescription;
	    private String serviceName; 
	    
	    // Getters and Setters

	    public int getCategoryId() {
	        return categoryId;
	    }
	    public void setCategoryId(int categoryId) {
	        this.categoryId = categoryId;
	    }
	    public String getCategoryName() {
	        return categoryName;
	    }
	    public void setCategoryName(String categoryName) {
	        this.categoryName = categoryName;
	    }
	    public int getServiceCategory() {
	        return serviceCategory;
	    }
	    public void setServiceCategory(int serviceCategory) {
	        this.serviceCategory = serviceCategory;
	    }
	    public int getServicePrice() {
	        return servicePrice;
	    }
	    public void setServicePrice(int servicePrice) {
	        this.servicePrice = servicePrice;
	    }
	    public String getServiceDescription() {
	        return serviceDescription;
	    }
	    public void setServiceDescription(String serviceDescription) {
	        this.serviceDescription = serviceDescription;
	    }
	    public String getServiceName() {
	        return serviceName;
	    }
	    public void setServiceName(String serviceName) {
	        this.serviceName = serviceName;
	    }
}
