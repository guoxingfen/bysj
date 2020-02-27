package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.Kind;

public interface KindService {

	// ��ȡȫ������
	List<Kind> getAllKind();
	// ��ӷ���
	void addKind(Kind k);
	// ���·���
	void updateKind(Kind k);
	// ɾ������
	void removeKind(List<Integer> ids);
	// ��ȡ����
	Kind getKindById(Integer id);
}
