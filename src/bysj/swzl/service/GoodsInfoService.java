package bysj.swzl.service;

import java.util.List;
import java.util.Map;

import bysj.swzl.constant.GoodsType;
import bysj.swzl.pojo.GoodsInfo;
import bysj.swzl.pojo.GoodsInfoVo;
import bysj.swzl.pojo.QueryFactor;
import bysj.swzl.pojo.SearchFactor;

public interface GoodsInfoService {

	// �����Ʒ��Ϣ
	void addGoodsInfo(GoodsInfo gi);
	// �鿴ͼƬ��Ϊ�յ���Ʒ��Ϣ
	List<GoodsInfo> getGoodsPicNotNull();
	// ������Ϣ���Ͳ鿴���е���Ʒ��Ϣ
	List<GoodsInfo> getGoodsByType(GoodsType gt);
	// ��ȡ���˰����Ϣ��ǰ5����
	List<Map<String,Object>> getGoodMan();
	// ����id�鿴��Ʒ��Ϣ
	GoodsInfoVo getGoodsInfo(Integer id);
	// �ı���Ʒ�����Ϣ
	void updateGoods(GoodsInfo gi);
	// ��ѯ�û�������Ϣ�뷢����������Ϣ
	List<GoodsInfo> queryAllGoodsBySid(QueryFactor qf);
	// ��ѯ�û�������Ϣ������
	Integer getTotalBySid(QueryFactor qf);
	// ��ѯĳ���û���ע��������Ϣ
	List<GoodsInfo> queryFollowGoods(QueryFactor qf);
	// ������Ʒ��Ϣ��ѯ��Ʒ�б�
	List<GoodsInfo> queryGoodsByGoodsInfo(GoodsInfo gi);
	// ��ȡϲ���������Ϣ
	List<Map<String,Object>> getGoodNews();
	// ������Ϣ���Ͳ�ѯ��Ʒ��Ϣ����ҳ
	List<GoodsInfoVo> getGoodsByGoodsTypePaging(SearchFactor sf);
	// ������Ʒ���Ͳ�ѯ��Ʒ������
	Integer getTotalByType(SearchFactor sf);
	// ������Ʒ���ͻ�ȡ��Ӧ��Ʒ����
	Integer getTotalByKind(Map<String,Object> map);
	// ɾ����Ʒ��Ϣ
	void deleteGoodsById(Integer id);
}
