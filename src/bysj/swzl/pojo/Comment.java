package bysj.swzl.pojo;

import java.util.Date;

// ������Ϣ��
public class Comment {

	// ����Id
	private Integer id;
	// ѧ��id 
	private Integer sid;
	// ��Ʒ��Ϣid
	private Integer gid;
	// ��������
	private String content;
	// ����ʱ��
	private Date createtime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	public Integer getGid() {
		return gid;
	}
	public void setGid(Integer gid) {
		this.gid = gid;
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
	@Override
	public String toString() {
		return "Comment [id=" + id + ", sid=" + sid + ", gid=" + gid + ", content=" + content + ", createtime="
				+ createtime + "]";
	}
	
}
