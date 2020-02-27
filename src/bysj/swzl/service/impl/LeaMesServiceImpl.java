package bysj.swzl.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.mapper.LeaMesMapper;
import bysj.swzl.pojo.LeaMes;
import bysj.swzl.pojo.LeaMesVo;
import bysj.swzl.pojo.PageModel;
import bysj.swzl.service.LeaMesService;

@Service
public class LeaMesServiceImpl implements LeaMesService {

	@Autowired
	private LeaMesMapper leaMesMapper;
	
	@Override
	public List<LeaMesVo> getAllLeaMes(PageModel<LeaMesVo> pageModel) {
		return leaMesMapper.getAllLeaMes(pageModel);
	}

	@Override
	public void addLeaMes(LeaMes lm) {
		leaMesMapper.addLeaMes(lm);
	}

	@Override
	public void removeLeaMes(List<Integer> ids) {
		leaMesMapper.removeLeaMes(ids);
	}

	@Override
	public Integer getTotal() {
		return leaMesMapper.getTotal();
	}


	@Override
	public List<LeaMesVo> queryAllLeaMes() {
		return leaMesMapper.queryAllLeaMes();
	}

}
