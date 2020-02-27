package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.Institute;

public interface InstituteMapper {

	// 查询所有的学院
	List<Institute> queryAllInstitute();
	// 查询学院
	Institute getInstituteById(Integer id);
	// 添加学院
	void addInstitute(Institute institute);
	// 删除学院
	void removeInstitute(List<Integer> iids);
	// 通过学院描述查找 学院
	Institute getInstituteByDesc(String desc);
	// 更新学院
	void updateInstitute(Institute institute);
}
