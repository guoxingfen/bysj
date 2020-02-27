package bysj.swzl.service;

import java.util.List;
import java.util.Map;

import bysj.swzl.pojo.Htuser;

public interface HtuserService {

	// ��ȡȫ������Ա
	List<Htuser> getAllHtuser();
	// ��ȡĳ������Ա
	Htuser getHtuserById(Integer id);
	// ��ӹ���Ա
	void addHtuser(Htuser htuser);
	// ɾ������Ա
	void removeHtusers(List<Integer> ids);
	// �ı����Ա״̬
	void changeStatus(Map<String,Object> map);
	// �����˻�����������ҹ���Ա
	Htuser getHtuserByUsernameAndPwd(Htuser htuser);
	// ����
	void updateHtuser(Htuser htuser);
	// ͳ�ƹ���Ա
	Integer getTotal(Map<String,Integer> status);
}
