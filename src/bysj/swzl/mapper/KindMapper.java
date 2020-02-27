package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.Kind;

public interface KindMapper {

	// 获取全部分类
	List<Kind> getAllKind();
	// 添加分类
	void addKind(Kind k);
	// 更新分类
	void updateKind(Kind k);
	// 删除分类
	void removeKind(List<Integer> ids);
	Kind getKindById(Integer id);
}
