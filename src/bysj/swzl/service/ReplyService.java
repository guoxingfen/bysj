package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.Reply;
import bysj.swzl.pojo.ReplyVo;

public interface ReplyService {

	// ��ȡ��Ӧ�����µ����лظ�
	List<ReplyVo> getAll(Integer cid);
	// ��ӻظ�
	void addReply(Reply reply);
	// ɾ���ظ�
	void removeReply(Integer id);
	// ɾ����Ӧ�����µ����лظ�
	void deleteAllReply(List<Integer> cids);
	
	
}
