package bysj.swzl.pojo;
// 学生信息
public class StuInfo {

	private Integer id;
	// 用户名
	private String uname;
	// 0:女   1:男
	private Integer Sex;
	// 手机号
	private String mphone;
	// 头像
	private String pic;
	private String password;
	// 所属学院
	private String institute;
	// 学号
	private String unumber;
	// 班级
	private Integer uclass;
	// 专业
	private String major;
	// 状态  1为启用  0为停用
	private Integer status;
	
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public Integer getSex() {
		return Sex;
	}
	public void setSex(Integer sex) {
		Sex = sex;
	}
	public Integer getUclass() {
		return uclass;
	}
	public void setUclass(Integer uclass) {
		this.uclass = uclass;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getMphone() {
		return mphone;
	}
	public void setMphone(String mphone) {
		this.mphone = mphone;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getInstitute() {
		return institute;
	}
	public void setInstitute(String institute) {
		this.institute = institute;
	}
	public String getUnumber() {
		return unumber;
	}
	public void setUnumber(String unumber) {
		this.unumber = unumber;
	}
	@Override
	public String toString() {
		return "StuInfo [id=" + id + ", uname=" + uname + ", Sex=" + Sex + ", mphone=" + mphone + ", pic=" + pic
				+ ", password=" + password + ", institute=" + institute + ", unumber=" + unumber + ", uclass=" + uclass
				+ ", major=" + major + ", status=" + status + "]";
	}
	
	
	 
}
