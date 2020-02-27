package bysj.swzl.mapper;

import java.util.List;
import java.util.Map;

import bysj.swzl.pojo.StuInfo;

public interface StuInfoMapper {

	// 通过用户Id查询用户
	StuInfo getStuInfoById(Integer id);
	// 通过用户名||手机号||学号查询用户
	StuInfo getStuInfo(StuInfo si);
	// 通过用户名||手机号||学号和密码查询用户
	StuInfo getStuInfoToLogin(StuInfo si);
	// 插入用户
	void insertStuInfo(StuInfo si);
	// 更新用户
	void updateStuInfo(StuInfo si);
	// 重置用户密码
	void resetPassWord(StuInfo si);
	// 查询所有的用户
	List<StuInfo> getAllStuInfo();
	// 更改用户的状态
	void changeStuStatus(Map<String,Object> map);
	// 统计用户人数
	Integer getTotal(Map<String,Integer> status);
	
	
	
}
