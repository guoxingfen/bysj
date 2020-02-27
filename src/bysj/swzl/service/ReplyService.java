package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.Reply;
import bysj.swzl.pojo.ReplyVo;

public interface ReplyService {

	// 获取相应评论下的所有回复
	List<ReplyVo> getAll(Integer cid);
	// 添加回复
	void addReply(Reply reply);
	// 删除回复
	void removeReply(Integer id);
	// 删除相应评论下的所有回复
	void deleteAllReply(List<Integer> cids);
	
	
}
