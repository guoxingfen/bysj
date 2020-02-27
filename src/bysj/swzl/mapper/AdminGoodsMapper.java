package bysj.swzl.mapper;

import java.util.List;
import java.util.Map;

import bysj.swzl.constant.GoodsType;
import bysj.swzl.pojo.AdminGoodsInfo;

public interface AdminGoodsMapper {

	// 获取所有失物
	// 获取所有拾物
	List<AdminGoodsInfo> getAllGoodsByType(GoodsType gt);
	// 查询举报次数大于x的所有物品
	List<AdminGoodsInfo> getAllReportGoods(Map<String,Object> map);
	// 删除物品信息
	void removeGoods(List<Integer> ids);
	
}
