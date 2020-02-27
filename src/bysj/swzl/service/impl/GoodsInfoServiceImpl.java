package bysj.swzl.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.constant.GoodsType;
import bysj.swzl.mapper.GoodsInfoMapper;
import bysj.swzl.pojo.GoodsInfo;
import bysj.swzl.pojo.GoodsInfoVo;
import bysj.swzl.pojo.QueryFactor;
import bysj.swzl.pojo.SearchFactor;
import bysj.swzl.service.GoodsInfoService;

@Service
public class GoodsInfoServiceImpl implements GoodsInfoService {

	@Autowired
	private GoodsInfoMapper goodsInfoMapper;

	@Override
	public void addGoodsInfo(GoodsInfo gi) {
		goodsInfoMapper.insertGoodsInfo(gi);
	}

	@Override
	public List<GoodsInfo> getGoodsPicNotNull() {
		return goodsInfoMapper.getGoodsPicNotNull();
	}

	@Override
	public List<GoodsInfo> getGoodsByType(GoodsType gt) {
		return goodsInfoMapper.getGoodsByGoodsType(gt);
	}

	@Override
	public GoodsInfoVo getGoodsInfo(Integer id) {
		return goodsInfoMapper.getGoodsById(id);
	}

	@Override
	public void updateGoods(GoodsInfo gi) {
		goodsInfoMapper.updateGoods(gi);
	}

	@Override
	public List<GoodsInfo> queryAllGoodsBySid(QueryFactor qf) {
		return goodsInfoMapper.queryGoodsBySid(qf);
	}

	@Override
	public Integer getTotalBySid(QueryFactor qf) {
		return goodsInfoMapper.getTotalBySid(qf);
	}

	@Override
	public List<GoodsInfo> queryFollowGoods(QueryFactor qf) {
		return goodsInfoMapper.queryFollowGoods(qf);
	}

	@Override
	public List<Map<String, Object>> getGoodMan() {
		return goodsInfoMapper.getGoodMan();
	}

	@Override
	public List<GoodsInfo> queryGoodsByGoodsInfo(GoodsInfo gi) {
		return goodsInfoMapper.queryGoodsByGoodsInfo(gi);
	}

	@Override
	public List<Map<String, Object>> getGoodNews() {
		return goodsInfoMapper.getGoodNews();
	}

	@Override
	public List<GoodsInfoVo> getGoodsByGoodsTypePaging(SearchFactor sf) {
		return goodsInfoMapper.getGoodsByGoodsTypePaging(sf);
	}

	@Override
	public Integer getTotalByType(SearchFactor sf) {
		return goodsInfoMapper.getTotalByType(sf);
	}

	@Override
	public Integer getTotalByKind(Map<String,Object> map) {
		return goodsInfoMapper.getTotalByKind(map);
	}

	@Override
	public void deleteGoodsById(Integer id) {
		goodsInfoMapper.deleteGoodsById(id);
	}
	
	
}
