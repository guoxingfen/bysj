package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.FamousRemark;

public interface FamousRemarkMapper {

	
	// 获取全部名言
	List<FamousRemark> getAllFamousRemark();
	// 添加名言
	void addFamousRemark(FamousRemark fr);
	// 删除名言
	void removeFamousRemarks(List<Integer> ids);
	// 更新名言
	void updateFamousRemark(FamousRemark fr);
	// 获取特定名言
	FamousRemark getFamousRemarkById(Integer id);
    // 统计总数
	Integer getTotal();
	
}
