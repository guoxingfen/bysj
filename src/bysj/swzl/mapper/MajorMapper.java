package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.Major;

public interface MajorMapper {

	// 查询对应学院的所有专业
	List<Major> queryAllMajor(Integer iid);
	// 给指定的学院添加相应的专业
	void addMajor(Major m);
	// 删除专业
	void removeMajors(List<Integer> ids);
	// 删除对应学院的所有专业
	void deleteMajorByIids(List<Integer> iids);
	// 获取全部专业信息
	List<Major> getAllMajor();
	// 更新专业信息
	void updateMajor(Major major);
	// 获取专业
	Major getMajorById(Integer id);
}
