package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.Institute;

public interface InstituteService {

	    // ��ѯ���е�ѧԺ
		List<Institute> queryAllInstitute();
		// ���ѧԺ
		void addInstitute(Institute institute);
		// ɾ��ѧԺ
		void removeInstitute(List<Integer> iids);
		// ͨ��ѧԺ�������� ѧԺ
		Institute getInstituteByDesc(String desc);
		// ����ѧԺ
		Institute getInstituteById(Integer id);
		// ����ѧԺ
		void updateInstitute(Institute institute);
}
