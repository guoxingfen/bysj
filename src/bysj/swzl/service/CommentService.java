package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.Comment;
import bysj.swzl.pojo.CommentVo;

public interface CommentService {

	// 添加评论
	void addComment(Comment comment);
	// 删除评论
	void removeComments(List<Integer> gids);
	// 获取相应物品的评论列表
	List<CommentVo> getComments(Integer gid);
	void removeCommentsByIds(List<Integer> ids);
}
