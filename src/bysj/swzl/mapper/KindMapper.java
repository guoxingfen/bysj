package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.Kind;

public interface KindMapper {

	// ��ȡȫ������
	List<Kind> getAllKind();
	// ��ӷ���
	void addKind(Kind k);
	// ���·���
	void updateKind(Kind k);
	// ɾ������
	void removeKind(List<Integer> ids);
	Kind getKindById(Integer id);
}
