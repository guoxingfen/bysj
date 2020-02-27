package bysj.swzl.service;

import java.util.List;
import java.util.Map;

import bysj.swzl.constant.GoodsType;
import bysj.swzl.pojo.AdminGoodsInfo;

public interface AdminGoodsService {

	// ��ȡ����ʧ��
	// ��ȡ����ʰ��
	List<AdminGoodsInfo> getAllGoodsByType(GoodsType gt);
	// ��ѯ�ٱ���������x��������Ʒ
	List<AdminGoodsInfo> getAllReportGoods(Map<String,Object> map);
	// ɾ����Ʒ��Ϣ
	void removeGoods(List<Integer> ids);
}
