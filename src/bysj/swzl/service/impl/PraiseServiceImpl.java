package bysj.swzl.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.mapper.PraiseMapper;
import bysj.swzl.pojo.Praise;
import bysj.swzl.pojo.PraiseVo;
import bysj.swzl.pojo.QueryFactor;
import bysj.swzl.service.PraiseService;
@Service
public class PraiseServiceImpl implements PraiseService {

	@Autowired
	private PraiseMapper praiseMapper;
	@Override
	public List<PraiseVo> queryAllByToSid(QueryFactor qf) {
		return praiseMapper.queryAllByToSid(qf);
	}

	@Override
	public void addPraise(Praise praise) {
		praiseMapper.addPraise(praise);
	}

	@Override
	public void removePraise(Integer id) {
		praiseMapper.removePraise(id);
	}

	@Override
	public Integer getTotalByToSid(Integer toSid) {
		return praiseMapper.getTotalByToSid(toSid);
	}

	@Override
	public PraiseVo queryPraiseById(Integer id) {
		return praiseMapper.queryPraiseById(id);
	}

	@Override
	public List<PraiseVo> getPraise() {
		return praiseMapper.getPraise();
	}

}
