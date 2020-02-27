package bysj.swzl.service;

import java.util.List;
import java.util.Map;

import bysj.swzl.pojo.Message;
import bysj.swzl.pojo.StuInfo;

public interface StuInfoService {

	// �û�ע��
	Message register(StuInfo si);
	// �û���¼
	Message login(StuInfo si);
	// �ж��û��Ƿ����
	Message queryStu(StuInfo si);
	// �û���������
	Message resetPwd(StuInfo si);
	// ����id��ȡ�û���Ϣ
	StuInfo getStuById(Integer id);
	// �����û�
	void updateStuInfo(StuInfo si);
	// ��ѯ���е��û���Ϣ
	List<StuInfo> getAllStuInfo();
	// �����û���״̬
	void changeStuStatus(Map<String,Object> map);
	// ͳ���û�����
	Integer getTotal(Map<String,Integer> status);
}
