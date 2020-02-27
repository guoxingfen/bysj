package bysj.swzl.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.mapper.FamousRemarkMapper;
import bysj.swzl.pojo.FamousRemark;
import bysj.swzl.service.FamousRemarkService;

@Service
public class FamousRemarkServiceImpl implements FamousRemarkService {

	@Autowired
	private FamousRemarkMapper famousRemarkMapper;
	
	@Override
	public List<FamousRemark> getAllFamousRemark() {
		return famousRemarkMapper.getAllFamousRemark();
	}

	@Override
	public void addFamousRemark(FamousRemark fr) {
		famousRemarkMapper.addFamousRemark(fr);
	}

	@Override
	public void removeFamousRemarks(List<Integer> ids) {
		famousRemarkMapper.removeFamousRemarks(ids);
	}

	@Override
	public void updateFamousRemark(FamousRemark fr) {
		famousRemarkMapper.updateFamousRemark(fr);
	}

	@Override
	public FamousRemark getFamousRemarkById(Integer id) {
		return famousRemarkMapper.getFamousRemarkById(id);
	}

	@Override
	public Integer getTotal() {
		return famousRemarkMapper.getTotal();
	}

}
