package bysj.swzl.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.constant.GoodsType;
import bysj.swzl.mapper.AdminGoodsMapper;
import bysj.swzl.pojo.AdminGoodsInfo;
import bysj.swzl.service.AdminGoodsService;

@Service
public class AdminGoodsServiceImpl implements AdminGoodsService {

	@Autowired
	private AdminGoodsMapper adminGoodsMapper;

	@Override
	public List<AdminGoodsInfo> getAllGoodsByType(GoodsType gt) {
		return adminGoodsMapper.getAllGoodsByType(gt);
	}

	@Override
	public List<AdminGoodsInfo> getAllReportGoods(Map<String, Object> map) {
		return adminGoodsMapper.getAllReportGoods(map);
	}

	@Override
	public void removeGoods(List<Integer> ids) {
		adminGoodsMapper.removeGoods(ids);
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
