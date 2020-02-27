package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.Institute;

public interface InstituteMapper {

	// ��ѯ���е�ѧԺ
	List<Institute> queryAllInstitute();
	// ��ѯѧԺ
	Institute getInstituteById(Integer id);
	// ���ѧԺ
	void addInstitute(Institute institute);
	// ɾ��ѧԺ
	void removeInstitute(List<Integer> iids);
	// ͨ��ѧԺ�������� ѧԺ
	Institute getInstituteByDesc(String desc);
	// ����ѧԺ
	void updateInstitute(Institute institute);
}
