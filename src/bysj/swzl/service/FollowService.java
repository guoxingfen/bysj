package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.Follow;

public interface FollowService {

	// ��ѯĳ���û��Ƿ��עָ������Ʒ��Ϣ
	Follow queryFollow(Follow f);
	// ��ӹ�ע
	void addFollow(Follow f);
	// ȡ����ע
	void removeFollow(Follow f);
	// ��ѯĳ���û���ע��Ϣ������
	Integer getTotal(Integer sid);
	// ����ɾ����ע
	void deleteFollows(List<Integer> gids);
}
