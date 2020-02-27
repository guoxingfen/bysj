package bysj.swzl.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.mapper.NoticeBoardMapper;
import bysj.swzl.pojo.NoticeBoard;
import bysj.swzl.service.NoticeBoardService;

@Service
public class NoticeBoardServiceImpl implements NoticeBoardService {

	@Autowired
	private NoticeBoardMapper noticeBoardMapper;
	@Override
	public List<NoticeBoard> getAllNoticeBoard() {
		return noticeBoardMapper.queryAll();
	}
	@Override
	public NoticeBoard getNoticeBoardById(Integer id) {
		return noticeBoardMapper.queryNoticeById(id);
	}
	@Override
	public void removeNoticeBoards(List<Integer> ids) {
		noticeBoardMapper.deleteNoticeBoards(ids);
		
	}
	@Override
	public void addNoticeBoard(NoticeBoard nb) {
		noticeBoardMapper.addNoticeBoard(nb);
	}
	@Override
	public void updateNoticeBoard(NoticeBoard nb) {
		noticeBoardMapper.updateNoticeBoard(nb);
	}
	@Override
	public Integer getTotal() {
		return noticeBoardMapper.getTotal();
	}

}
