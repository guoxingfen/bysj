package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.Report;

public interface ReportMapper {

	// 统计举报表中的某条物品信息的举报人数
	Integer getTotal(Integer gid);
	// 根据举报人id与物品信息id查找举报信息
	Report getReportBySidAndGid(Report report);
	// 插入一条举报信息
	void addReport(Report report);
	// 删除举报信息
	void removeReports(List<Integer> gids);
	
}
