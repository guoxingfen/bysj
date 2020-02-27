package bysj.swzl.pojo;

import java.util.Date;

import bysj.swzl.constant.GoodsType;

public class GoodsInfo {

	private Integer id;
	// Ѱ������   ��������
	private GoodsType type;
	// Ǯ��  ����������
	private Integer kid;
	private String pic;
	private String title;
	private String detail;
	private String address;
	private Date date;
	private Integer sid;
	// ��ϵ�˵�ַ
	private String contact_address;
	// ����ʱ��
	private Date publish_date;
	// �����
	private Integer pageview;
	// ״̬  0:Ѱ����  1:�ɹ�    2������
	private Integer status;
	// ��ϵ�ֻ�
	private String phone;
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getPublish_date() {
		return publish_date;
	}
	public void setPublish_date(Date publish_date) {
		this.publish_date = publish_date;
	}
	public Integer getPageview() {
		return pageview;
	}
	public void setPageview(Integer pageview) {
		this.pageview = pageview;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getContact_address() {
		return contact_address;
	}
	public void setContact_address(String contact_address) {
		this.contact_address = contact_address;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public GoodsType getType() {
		return type;
	}
	public void setType(GoodsType type) {
		this.type = type;
	}
	public Integer getKid() {
		return kid;
	}
	public void setKid(Integer kid) {
		this.kid = kid;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	@Override
	public String toString() {
		return "GoodsInfo [id=" + id + ", type=" + type + ", kid=" + kid + ", pic=" + pic + ", title=" + title
				+ ", detail=" + detail + ", address=" + address + ", date=" + date + ", sid=" + sid
				+ ", contact_address=" + contact_address + ", publish_date=" + publish_date + ", pageview=" + pageview
				+ ", status=" + status + "]";
	}
	
	
}
