package bysj.swzl.pojo;

import java.util.Date;

// Бэбя
public class Praise {

	private Integer id;
	private Integer fromSid;
	private Integer toSid;
	private String content;
	private Date createtime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getFromSid() {
		return fromSid;
	}
	public void setFromSid(Integer fromSid) {
		this.fromSid = fromSid;
	}
	public Integer getToSid() {
		return toSid;
	}
	public void setToSid(Integer toSid) {
		this.toSid = toSid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	
}
