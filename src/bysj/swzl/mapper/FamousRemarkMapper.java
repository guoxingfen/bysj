package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.FamousRemark;

public interface FamousRemarkMapper {

	
	// ��ȡȫ������
	List<FamousRemark> getAllFamousRemark();
	// �������
	void addFamousRemark(FamousRemark fr);
	// ɾ������
	void removeFamousRemarks(List<Integer> ids);
	// ��������
	void updateFamousRemark(FamousRemark fr);
	// ��ȡ�ض�����
	FamousRemark getFamousRemarkById(Integer id);
    // ͳ������
	Integer getTotal();
	
}
