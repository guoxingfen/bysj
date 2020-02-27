package bysj.swzl.mapper;

import java.util.List;
import java.util.Map;

import bysj.swzl.constant.GoodsType;
import bysj.swzl.pojo.GoodsInfo;
import bysj.swzl.pojo.GoodsInfoVo;
import bysj.swzl.pojo.QueryFactor;
import bysj.swzl.pojo.SearchFactor;

public interface GoodsInfoMapper {

	// ��ѯͼƬ��Ϊ�յ�������Ʒ
	List<GoodsInfo> getGoodsPicNotNull();
	// ������Ϣ���Ͳ�ѯ������Ʒ
	List<GoodsInfo> getGoodsByGoodsType(GoodsType gt);
	// ������Ϣ���Ͳ�ѯ��Ʒ��Ϣ����ҳ
	List<GoodsInfoVo> getGoodsByGoodsTypePaging(SearchFactor sf);
	// ��ȡ���˰����Ϣ��ǰ5����
	List<Map<String,Object>> getGoodMan();
	// ��ȡϲ���������Ϣ
	List<Map<String,Object>> getGoodNews();
	// ������Ʒ��Ϣ��ѯ��Ʒ�б�
	List<GoodsInfo> queryGoodsByGoodsInfo(GoodsInfo gi);
	// ������Ʒ��Ϣ
	void insertGoodsInfo(GoodsInfo gi);
	// ����id�鿴��Ʒ��Ϣ
	GoodsInfoVo getGoodsById(Integer id);
	// ������Ʒ��Ϣ
	void updateGoods(GoodsInfo gi);
	// ��ѯĳ���û���������Ϣ��ʵ�ַ�ҳ��ѯ
	List<GoodsInfo> queryGoodsBySid(QueryFactor qf);
	// ��ѯĳ���û�������Ϣ������
	Integer getTotalBySid(QueryFactor qf);
	// ������Ʒ���Ͳ�ѯ��Ʒ������
	Integer getTotalByType(SearchFactor sf);
	// ��ѯĳ���û���ע��������Ϣ
	List<GoodsInfo> queryFollowGoods(QueryFactor qf);
	// ������Ʒ���ͻ�ȡ��Ӧ��Ʒ����
	Integer getTotalByKind(Map<String,Object> map);
	
	// ɾ����Ʒ��Ϣ
	void deleteGoodsById(Integer id);
	
	
	
}
