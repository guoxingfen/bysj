package bysj.swzl.mapper;

import java.util.List;
import java.util.Map;

import bysj.swzl.constant.GoodsType;
import bysj.swzl.pojo.GoodsInfo;
import bysj.swzl.pojo.GoodsInfoVo;
import bysj.swzl.pojo.QueryFactor;
import bysj.swzl.pojo.SearchFactor;

public interface GoodsInfoMapper {

	// 查询图片不为空的所有物品
	List<GoodsInfo> getGoodsPicNotNull();
	// 根据信息类型查询所属物品
	List<GoodsInfo> getGoodsByGoodsType(GoodsType gt);
	// 根据信息类型查询物品信息并分页
	List<GoodsInfoVo> getGoodsByGoodsTypePaging(SearchFactor sf);
	// 获取好人榜的信息（前5名）
	List<Map<String,Object>> getGoodMan();
	// 获取喜报公告的信息
	List<Map<String,Object>> getGoodNews();
	// 根据物品信息查询物品列表
	List<GoodsInfo> queryGoodsByGoodsInfo(GoodsInfo gi);
	// 插入物品信息
	void insertGoodsInfo(GoodsInfo gi);
	// 根据id查看物品信息
	GoodsInfoVo getGoodsById(Integer id);
	// 更新物品信息
	void updateGoods(GoodsInfo gi);
	// 查询某个用户发布的信息并实现分页查询
	List<GoodsInfo> queryGoodsBySid(QueryFactor qf);
	// 查询某个用户发布信息的总数
	Integer getTotalBySid(QueryFactor qf);
	// 根据物品类型查询物品的总数
	Integer getTotalByType(SearchFactor sf);
	// 查询某个用户关注的所有信息
	List<GoodsInfo> queryFollowGoods(QueryFactor qf);
	// 根据物品类型获取相应物品总数
	Integer getTotalByKind(Map<String,Object> map);
	
	// 删除物品信息
	void deleteGoodsById(Integer id);
	
	
	
}
