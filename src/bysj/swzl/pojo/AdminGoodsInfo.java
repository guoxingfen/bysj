package bysj.swzl.pojo;

public class AdminGoodsInfo extends GoodsInfo {

	// 发布物品信息的用户
	private String uname;
	// 被举报的次数
	private Integer report;
	// 物品类型
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
