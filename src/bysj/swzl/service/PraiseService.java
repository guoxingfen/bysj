package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.Praise;
import bysj.swzl.pojo.PraiseVo;
import bysj.swzl.pojo.QueryFactor;

public interface PraiseService {

	// 查询某个用户接收到的所有表扬信息
	List<PraiseVo> queryAllByToSid(QueryFactor qf);
	// 获取表扬信信息
	List<PraiseVo> getPraise();
	// 查询某个用户收到表扬信的总数
	Integer getTotalByToSid(Integer toSid);
	// 添加一条表扬信息
	void addPraise(Praise praise);
	// 删除指定id的表扬信息
	void removePraise(Integer id);
	//查询表扬信详情
	PraiseVo queryPraiseById(Integer id);
}
