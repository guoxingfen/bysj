package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.Reply;
import bysj.swzl.pojo.ReplyVo;

public interface ReplyVoMapper {

	// 查询相应评论下的所有回复
	List<ReplyVo> queryAll(Integer cid);
	// 删除回复
	void removeReply(Integer id);
	// 添加回复
	void addReply(Reply reply);
	// 删除相应评论下的所有回复
	void deleteAllReply(List<Integer> cids);
}
