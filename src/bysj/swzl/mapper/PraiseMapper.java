package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.Praise;
import bysj.swzl.pojo.PraiseVo;
import bysj.swzl.pojo.QueryFactor;

public interface PraiseMapper {

	// ��ѯĳ���û����յ������б�����Ϣ�����з�ҳ
	List<PraiseVo> queryAllByToSid(QueryFactor qf);
	// ��ȡ��������Ϣ
	List<PraiseVo> getPraise();
	// ��ѯĳ���û��յ������ŵ�����
	Integer getTotalByToSid(Integer toSid);
	// ���һ��������Ϣ
	void addPraise(Praise praise);
	// ɾ��ָ��id�ı�����Ϣ
	void removePraise(Integer id);
	// ��ѯ����������
	PraiseVo queryPraiseById(Integer id);
	
}
