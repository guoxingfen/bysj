package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.Major;

public interface MajorService {

	    // 查询对应学院的所有专业
		List<Major> queryAllMajor(Integer iid);
		// 给指定的学院添加相应的专业
		void addMajor(Major m);
		// 删除指定的专业
		void removeMajors(List<Integer> ids);
		// 获取全部专业信息
		List<Major> getAllMajor();
		// 更新专业信息
		void updateMajor(Major major);
		// 获取专业
		Major getMajorById(Integer id);
}
