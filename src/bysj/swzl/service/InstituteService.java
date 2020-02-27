package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.Institute;

public interface InstituteService {

	    // 查询所有的学院
		List<Institute> queryAllInstitute();
		// 添加学院
		void addInstitute(Institute institute);
		// 删除学院
		void removeInstitute(List<Integer> iids);
		// 通过学院描述查找 学院
		Institute getInstituteByDesc(String desc);
		// 查找学院
		Institute getInstituteById(Integer id);
		// 更新学院
		void updateInstitute(Institute institute);
}
