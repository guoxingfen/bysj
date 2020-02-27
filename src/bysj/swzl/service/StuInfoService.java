package bysj.swzl.service;

import java.util.List;
import java.util.Map;

import bysj.swzl.pojo.Message;
import bysj.swzl.pojo.StuInfo;

public interface StuInfoService {

	// 用户注册
	Message register(StuInfo si);
	// 用户登录
	Message login(StuInfo si);
	// 判断用户是否存在
	Message queryStu(StuInfo si);
	// 用户重置密码
	Message resetPwd(StuInfo si);
	// 根据id获取用户信息
	StuInfo getStuById(Integer id);
	// 更新用户
	void updateStuInfo(StuInfo si);
	// 查询所有的用户信息
	List<StuInfo> getAllStuInfo();
	// 更改用户的状态
	void changeStuStatus(Map<String,Object> map);
	// 统计用户人数
	Integer getTotal(Map<String,Integer> status);
}
