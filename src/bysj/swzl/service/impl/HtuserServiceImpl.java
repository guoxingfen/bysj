package bysj.swzl.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.mapper.HtuserMapper;
import bysj.swzl.pojo.Htuser;
import bysj.swzl.service.HtuserService;

@Service
public class HtuserServiceImpl implements HtuserService {

	@Autowired
	private HtuserMapper htuserMapper;
	
	@Override
	public List<Htuser> getAllHtuser() {
		return htuserMapper.getAllHtuser();
	}

	@Override
	public Htuser getHtuserById(Integer id) {
		return htuserMapper.getHtuserById(id);
	}

	@Override
	public void addHtuser(Htuser htuser) {
		htuserMapper.addHtuser(htuser);
	}

	@Override
	public void removeHtusers(List<Integer> ids) {
		htuserMapper.removeHtusers(ids);
	}

	@Override
	public void changeStatus(Map<String, Object> map) {
		htuserMapper.changeStatus(map);
	}

	@Override
	public Htuser getHtuserByUsernameAndPwd(Htuser htuser) {
		return htuserMapper.getHtuserByUsernameAndPwd(htuser);
	}

	@Override
	public void updateHtuser(Htuser htuser) {
		htuserMapper.updateHtuser(htuser);
	}

	@Override
	public Integer getTotal(Map<String,Integer> status) {
		return htuserMapper.getTotal(status);
	}

}
