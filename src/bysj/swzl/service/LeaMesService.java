package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.LeaMes;
import bysj.swzl.pojo.LeaMesVo;
import bysj.swzl.pojo.PageModel;

public interface LeaMesService {

	
	// ͳ���ܵ�������
	Integer getTotal();
	// ��ѯ���е�����
	List<LeaMesVo> getAllLeaMes(PageModel<LeaMesVo> pageModel);
	// �������
	void addLeaMes(LeaMes lm);
	// ɾ������
	void removeLeaMes(List<Integer> ids);
	// ��ȡȫ������
	List<LeaMesVo> queryAllLeaMes();
}
