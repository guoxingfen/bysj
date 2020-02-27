package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.Follow;

public interface FollowMapper {

	// 查询某个用户是否关注指定的物品信息
	Follow queryFollow(Follow f);
	// 查询某个用户关注信息的总数
	Integer getTotal(Integer sid);
	// 添加关注
	void addFollow(Follow f);
	// 取消关注
	void removeFollow(Follow f);
	// 批量删除关注
	void deleteFollows(List<Integer> gids);
}
