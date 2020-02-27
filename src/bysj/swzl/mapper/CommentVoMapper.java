package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.Comment;
import bysj.swzl.pojo.CommentVo;

public interface CommentVoMapper {

	// ��ѯ��Ӧ��Ʒ��Ϣ������
	List<CommentVo> queryAllComment(Integer gid);
	// �������
	void addComment(Comment comment);
	// ɾ������
	void removeComments(List<Integer> gids);
	// ��ѯ���۵�id
	List<Integer> getCommentIdsByGids(List<Integer> gids);
	void removeCommentsByIds(List<Integer> ids);
}
