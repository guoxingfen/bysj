package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.NoticeBoard;

public interface NoticeBoardService {

	// ��ȡ���й���
	List<NoticeBoard> getAllNoticeBoard();
	// ���ݹ���id�鿴��������
	NoticeBoard getNoticeBoardById(Integer id);
	// ɾ������
	void removeNoticeBoards(List<Integer> ids);
	// ��ӹ���
    void addNoticeBoard(NoticeBoard nb);
    // ���¹���
    void updateNoticeBoard(NoticeBoard nb);
   // ͳ������
   Integer getTotal();
}
