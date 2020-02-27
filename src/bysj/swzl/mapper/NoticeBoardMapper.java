package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.NoticeBoard;

public interface NoticeBoardMapper {

	// ���ݹ���id�鿴��������
	NoticeBoard queryNoticeById(Integer id);
	// ��ѯ���еĹ���
	List<NoticeBoard> queryAll();
	// ��ӹ���
    void addNoticeBoard(NoticeBoard nb);
	// ɾ������
    void deleteNoticeBoards(List<Integer> ids);
	// ���¹���
    void updateNoticeBoard(NoticeBoard nb);
    // ͳ������
    Integer getTotal();
}
