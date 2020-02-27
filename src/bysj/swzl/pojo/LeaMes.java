package bysj.swzl.pojo;

import java.util.Date;

// ÁôÑÔĞÅÏ¢Àà
public class LeaMes {

	private Integer id;
	private String message;
	private Integer sid;
	private Date date;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "LeaMes [id=" + id + ", message=" + message + ", sid=" + sid + ", date=" + date + "]";
	}
	
}
