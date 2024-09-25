package bean;

public class addServiceBean {
	    private int service_id;
	    private String serviceName;
		public addServiceBean(int service_id, String serviceName) {
			super();
			this.service_id = service_id;
			this.serviceName = serviceName;
		}
		public addServiceBean() {
			super();
		}
		public int getService_id() {
			return service_id;
		}
		public void setService_id(int service_id) {
			this.service_id = service_id;
		}
		public String getServiceName() {
			return serviceName;
		}
		public void setServiceName(String serviceName) {
			this.serviceName = serviceName;
		}
		@Override
		public String toString() {
			return "addServiceBean [service_id=" + service_id + ", serviceName=" + serviceName + "]";
		}
	    	
}
