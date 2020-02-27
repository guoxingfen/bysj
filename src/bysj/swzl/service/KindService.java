package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.Kind;

public interface KindService {

	// 获取全部分类
	List<Kind> getAllKind();
	// 添加分类
	void addKind(Kind k);
	// 更新分类
	void updateKind(Kind k);
	// 删除分类
	void removeKind(List<Integer> ids);
	// 获取分类
	Kind getKindById(Integer id);
}
