package bysj.swzl.pojo;

import java.util.List;

public class CommentVo extends Comment {

	private String pic;
	private String uname;
	// һ�����۶�Ӧ�����ظ�
	private List<ReplyVo> replys;
	
	public List<ReplyVo> getReplys() {
		return replys;
	}
	public void setReplys(List<ReplyVo> replys) {
		this.replys = replys;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	
}
