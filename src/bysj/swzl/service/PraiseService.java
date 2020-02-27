package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.Praise;
import bysj.swzl.pojo.PraiseVo;
import bysj.swzl.pojo.QueryFactor;

public interface PraiseService {

	// ��ѯĳ���û����յ������б�����Ϣ
	List<PraiseVo> queryAllByToSid(QueryFactor qf);
	// ��ȡ��������Ϣ
	List<PraiseVo> getPraise();
	// ��ѯĳ���û��յ������ŵ�����
	Integer getTotalByToSid(Integer toSid);
	// ���һ��������Ϣ
	void addPraise(Praise praise);
	// ɾ��ָ��id�ı�����Ϣ
	void removePraise(Integer id);
	//��ѯ����������
	PraiseVo queryPraiseById(Integer id);
}
