package bysj.swzl.pojo;

import java.util.Date;

// 评论信息类
public class Comment {

	// 评论Id
	private Integer id;
	// 学生id 
	private Integer sid;
	// 物品信息id
	private Integer gid;
	// 评论内容
	private String content;
	// 发布时间
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
