package bysj.swzl.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.mapper.CommentVoMapper;
import bysj.swzl.mapper.ReplyVoMapper;
import bysj.swzl.pojo.Comment;
import bysj.swzl.pojo.CommentVo;
import bysj.swzl.service.CommentService;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentVoMapper commentVoMapper;
	@Autowired
	private ReplyVoMapper replyVoMapper;
	
	@Override
	public void addComment(Comment comment) {
		commentVoMapper.addComment(comment);
	}

	@Override
	public void removeComments(List<Integer> gids) {
		// 删除回复
		// 首先查询评论的所有id
		List<Integer> cids=commentVoMapper.getCommentIdsByGids(gids);
		if(cids.size()!=0) {
			replyVoMapper.deleteAllReply(cids);
		}
		// 删除评论
		commentVoMapper.removeComments(gids);
	}

	@Override
	public List<CommentVo> getComments(Integer gid) {
		return commentVoMapper.queryAllComment(gid);
	}

	@Override
	public void removeCommentsByIds(List<Integer> ids) {
		if(ids.size()>0) {
			replyVoMapper.deleteAllReply(ids);
		}
		commentVoMapper.removeCommentsByIds(ids);
	}

}
