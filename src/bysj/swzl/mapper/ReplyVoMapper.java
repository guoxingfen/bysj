package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.Reply;
import bysj.swzl.pojo.ReplyVo;

public interface ReplyVoMapper {

	// ��ѯ��Ӧ�����µ����лظ�
	List<ReplyVo> queryAll(Integer cid);
	// ɾ���ظ�
	void removeReply(Integer id);
	// ��ӻظ�
	void addReply(Reply reply);
	// ɾ����Ӧ�����µ����лظ�
	void deleteAllReply(List<Integer> cids);
}
