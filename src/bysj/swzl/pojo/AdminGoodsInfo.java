package bysj.swzl.pojo;

public class AdminGoodsInfo extends GoodsInfo {

	// ������Ʒ��Ϣ���û�
	private String uname;
	// ���ٱ��Ĵ���
	private Integer report;
	// ��Ʒ����
	private String kdesc;
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public Integer getReport() {
		return report;
	}
	public void setReport(Integer report) {
		this.report = report;
	}
	public String getKdesc() {
		return kdesc;
	}
	public void setKdesc(String kdesc) {
		this.kdesc = kdesc;
	}
	@Override
	public String toString() {
		return "AdminGoodsInfo [uname=" + uname + ", report=" + report + ", kdesc=" + kdesc + ", toString()="
				+ super.toString() + "]";
	}
	
	
	
	
	
}
