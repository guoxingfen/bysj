package bysj.swzl.service;

import java.util.List;
import java.util.Map;

import bysj.swzl.pojo.Htuser;

public interface HtuserService {

	// 获取全部管理员
	List<Htuser> getAllHtuser();
	// 获取某个管理员
	Htuser getHtuserById(Integer id);
	// 添加管理员
	void addHtuser(Htuser htuser);
	// 删除管理员
	void removeHtusers(List<Integer> ids);
	// 改变管理员状态
	void changeStatus(Map<String,Object> map);
	// 根据账户名和密码查找管理员
	Htuser getHtuserByUsernameAndPwd(Htuser htuser);
	// 更新
	void updateHtuser(Htuser htuser);
	// 统计管理员
	Integer getTotal(Map<String,Integer> status);
}
