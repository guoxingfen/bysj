package bysj.swzl.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.mapper.ReplyVoMapper;
import bysj.swzl.pojo.Reply;
import bysj.swzl.pojo.ReplyVo;
import bysj.swzl.service.ReplyService;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyVoMapper replyVoMapper;
	
	@Override
	public List<ReplyVo> getAll(Integer cid) {
		return replyVoMapper.queryAll(cid);
	}

	@Override
	public void addReply(Reply reply) {
		replyVoMapper.addReply(reply);
	}

	@Override
	public void removeReply(Integer id) {
		replyVoMapper.removeReply(id);
	}

	@Override
	public void deleteAllReply(List<Integer> cids) {
		replyVoMapper.deleteAllReply(cids);
	}

}
