package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.NoticeBoard;

public interface NoticeBoardService {

	// 获取所有公告
	List<NoticeBoard> getAllNoticeBoard();
	// 根据公告id查看公告详情
	NoticeBoard getNoticeBoardById(Integer id);
	// 删除公告
	void removeNoticeBoards(List<Integer> ids);
	// 添加公告
    void addNoticeBoard(NoticeBoard nb);
    // 更新公告
    void updateNoticeBoard(NoticeBoard nb);
   // 统计总数
   Integer getTotal();
}
