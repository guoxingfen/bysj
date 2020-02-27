package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.NoticeBoard;

public interface NoticeBoardMapper {

	// 根据公告id查看公告详情
	NoticeBoard queryNoticeById(Integer id);
	// 查询所有的公告
	List<NoticeBoard> queryAll();
	// 添加公告
    void addNoticeBoard(NoticeBoard nb);
	// 删除公告
    void deleteNoticeBoards(List<Integer> ids);
	// 更新公告
    void updateNoticeBoard(NoticeBoard nb);
    // 统计总数
    Integer getTotal();
}
