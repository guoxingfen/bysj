package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.Major;

public interface MajorService {

	    // ��ѯ��ӦѧԺ������רҵ
		List<Major> queryAllMajor(Integer iid);
		// ��ָ����ѧԺ�����Ӧ��רҵ
		void addMajor(Major m);
		// ɾ��ָ����רҵ
		void removeMajors(List<Integer> ids);
		// ��ȡȫ��רҵ��Ϣ
		List<Major> getAllMajor();
		// ����רҵ��Ϣ
		void updateMajor(Major major);
		// ��ȡרҵ
		Major getMajorById(Integer id);
}
