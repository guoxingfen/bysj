package bysj.swzl.pojo;

public class PraiseVo extends Praise {

	// fromId对应的uname
	private String uname;
	// toId对应的uname
	private String toname;
	private String pic;
	
	public String getToname() {
		return toname;
	}
	public void setToname(String toname) {
		this.toname = toname;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	@Override
	public String toString() {
		return "PraiseVo [getId()=" + getId() + ", uname=" + uname + ", pic=" + pic + "]";
	}
	
	
}
