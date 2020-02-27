package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.AddressStatistics;
import bysj.swzl.pojo.KindStatistics;
import bysj.swzl.pojo.TimeStatistics;

public interface StatisticsMapper {

	// 统计物品种类与每个种类的数量
	List<KindStatistics> statisticsKind();
	// 统计常见地点丢失或拾到物品的数量
	List<AddressStatistics> statisticsAddress();
	// 统计时间段信息
	List<TimeStatistics> statisticsTime();
	
}
