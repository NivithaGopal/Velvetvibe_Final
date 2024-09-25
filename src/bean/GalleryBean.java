package bean;

public class GalleryBean {
	
	private int galleryId;
	/*
	 * private int serviceId; private int serviceCategory;
	 */
    private String image1;
    private String image2;
	public int getGalleryId() {
		return galleryId;
	}
	public void setGalleryId(int galleryId) {
		this.galleryId = galleryId;
	}

	/*
	 * public int getServiceId() { return serviceId; } public void setServiceId(int
	 * serviceId) { this.serviceId = serviceId; } public int getServiceCategory() {
	 * return serviceCategory; } public void setServiceCategory(int serviceCategory)
	 * { this.serviceCategory = serviceCategory; }
	 */	public String getImage1() {
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

	/*
	 * public GalleryBean(int galleryId, int serviceId, int serviceCategory, String
	 * image1, String image2) { super(); this.galleryId = galleryId; this.serviceId
	 * = serviceId; this.serviceCategory = serviceCategory; this.image1 = image1;
	 * this.image2 = image2; }
	 */
	public GalleryBean() {
		super();
	}
	/*
	 * @Override public String toString() { return "GalleryBean [galleryId=" +
	 * galleryId + ", serviceId=" + serviceId + ", serviceCategory=" +
	 * serviceCategory + ", image1=" + image1 + ", image2=" + image2 + "]"; }
	 */
	@Override
	public String toString() {
		return "GalleryBean [galleryId=" + galleryId + ", image1=" + image1 + ", image2=" + image2 + "]";
	}
	public GalleryBean(int galleryId, String image1, String image2) {
		super();
		this.galleryId = galleryId;
		this.image1 = image1;
		this.image2 = image2;
	}
    
}
