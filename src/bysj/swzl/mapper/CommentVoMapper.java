package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.Comment;
import bysj.swzl.pojo.CommentVo;

public interface CommentVoMapper {

	// 查询相应物品信息的评论
	List<CommentVo> queryAllComment(Integer gid);
	// 添加评论
	void addComment(Comment comment);
	// 删除评论
	void removeComments(List<Integer> gids);
	// 查询评论的id
	List<Integer> getCommentIdsByGids(List<Integer> gids);
	void removeCommentsByIds(List<Integer> ids);
}
