package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.Major;

public interface MajorMapper {

	// ��ѯ��ӦѧԺ������רҵ
	List<Major> queryAllMajor(Integer iid);
	// ��ָ����ѧԺ�����Ӧ��רҵ
	void addMajor(Major m);
	// ɾ��רҵ
	void removeMajors(List<Integer> ids);
	// ɾ����ӦѧԺ������רҵ
	void deleteMajorByIids(List<Integer> iids);
	// ��ȡȫ��רҵ��Ϣ
	List<Major> getAllMajor();
	// ����רҵ��Ϣ
	void updateMajor(Major major);
	// ��ȡרҵ
	Major getMajorById(Integer id);
}
