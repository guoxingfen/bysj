package bysj.swzl.pojo;

public class Kind {

	private Integer id;
	private String code;
	private String desc;
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
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	@Override
	public String toString() {
		return "Kind [id=" + id + ", code=" + code + ", desc=" + desc + "]";
	}
	
}
