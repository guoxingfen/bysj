package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.Follow;

public interface FollowMapper {

	// ��ѯĳ���û��Ƿ��עָ������Ʒ��Ϣ
	Follow queryFollow(Follow f);
	// ��ѯĳ���û���ע��Ϣ������
	Integer getTotal(Integer sid);
	// ��ӹ�ע
	void addFollow(Follow f);
	// ȡ����ע
	void removeFollow(Follow f);
	// ����ɾ����ע
	void deleteFollows(List<Integer> gids);
}
