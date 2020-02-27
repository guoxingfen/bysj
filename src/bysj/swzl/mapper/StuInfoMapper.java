package bysj.swzl.mapper;

import java.util.List;
import java.util.Map;

import bysj.swzl.pojo.StuInfo;

public interface StuInfoMapper {

	// ͨ���û�Id��ѯ�û�
	StuInfo getStuInfoById(Integer id);
	// ͨ���û���||�ֻ���||ѧ�Ų�ѯ�û�
	StuInfo getStuInfo(StuInfo si);
	// ͨ���û���||�ֻ���||ѧ�ź������ѯ�û�
	StuInfo getStuInfoToLogin(StuInfo si);
	// �����û�
	void insertStuInfo(StuInfo si);
	// �����û�
	void updateStuInfo(StuInfo si);
	// �����û�����
	void resetPassWord(StuInfo si);
	// ��ѯ���е��û�
	List<StuInfo> getAllStuInfo();
	// �����û���״̬
	void changeStuStatus(Map<String,Object> map);
	// ͳ���û�����
	Integer getTotal(Map<String,Integer> status);
	
	
	
}
