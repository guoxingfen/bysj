package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.Comment;
import bysj.swzl.pojo.CommentVo;

public interface CommentService {

	// �������
	void addComment(Comment comment);
	// ɾ������
	void removeComments(List<Integer> gids);
	// ��ȡ��Ӧ��Ʒ�������б�
	List<CommentVo> getComments(Integer gid);
	void removeCommentsByIds(List<Integer> ids);
}
