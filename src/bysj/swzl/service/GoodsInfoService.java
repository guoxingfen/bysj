package bysj.swzl.service;

import java.util.List;
import java.util.Map;

import bysj.swzl.constant.GoodsType;
import bysj.swzl.pojo.GoodsInfo;
import bysj.swzl.pojo.GoodsInfoVo;
import bysj.swzl.pojo.QueryFactor;
import bysj.swzl.pojo.SearchFactor;

public interface GoodsInfoService {

	// 添加物品信息
	void addGoodsInfo(GoodsInfo gi);
	// 查看图片不为空的物品信息
	List<GoodsInfo> getGoodsPicNotNull();
	// 根据信息类型查看所有的物品信息
	List<GoodsInfo> getGoodsByType(GoodsType gt);
	// 获取好人榜的信息（前5名）
	List<Map<String,Object>> getGoodMan();
	// 根据id查看物品信息
	GoodsInfoVo getGoodsInfo(Integer id);
	// 改变物品相关信息
	void updateGoods(GoodsInfo gi);
	// 查询用户个人信息与发布的所有信息
	List<GoodsInfo> queryAllGoodsBySid(QueryFactor qf);
	// 查询用户发布信息的总数
	Integer getTotalBySid(QueryFactor qf);
	// 查询某个用户关注的所有信息
	List<GoodsInfo> queryFollowGoods(QueryFactor qf);
	// 根据物品信息查询物品列表
	List<GoodsInfo> queryGoodsByGoodsInfo(GoodsInfo gi);
	// 获取喜报公告的信息
	List<Map<String,Object>> getGoodNews();
	// 根据信息类型查询物品信息并分页
	List<GoodsInfoVo> getGoodsByGoodsTypePaging(SearchFactor sf);
	// 根据物品类型查询物品的总数
	Integer getTotalByType(SearchFactor sf);
	// 根据物品类型获取相应物品总数
	Integer getTotalByKind(Map<String,Object> map);
	// 删除物品信息
	void deleteGoodsById(Integer id);
}
