package bysj.swzl.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.mapper.FollowMapper;
import bysj.swzl.pojo.Follow;
import bysj.swzl.service.FollowService;

@Service
public class FollowServiceImpl implements FollowService {

	@Autowired
	private FollowMapper followMapper;
	
	@Override
	public void addFollow(Follow f) {
		followMapper.addFollow(f);
	}

	@Override
	public void removeFollow(Follow f) {
		followMapper.removeFollow(f);
	}

	@Override
	public Follow queryFollow(Follow f) {
		return followMapper.queryFollow(f);
	}

	@Override
	public Integer getTotal(Integer sid) {
		return followMapper.getTotal(sid);
	}

	@Override
	public void deleteFollows(List<Integer> gids) {
		followMapper.deleteFollows(gids);
	}
	

}
