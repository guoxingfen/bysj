package bysj.swzl.pojo;

public class Address {

	private Integer id;
	private String code;
	private String detail;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	@Override
	public String toString() {
		return "Address [id=" + id + ", code=" + code + ", detail=" + detail + "]";
	}
	
}
