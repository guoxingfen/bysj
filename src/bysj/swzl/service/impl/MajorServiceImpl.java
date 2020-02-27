package bysj.swzl.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.mapper.MajorMapper;
import bysj.swzl.pojo.Major;
import bysj.swzl.service.MajorService;

@Service
public class MajorServiceImpl implements MajorService {

	@Autowired
	private MajorMapper majorMapper;

	@Override
	public List<Major> queryAllMajor(Integer iid) {
		return majorMapper.queryAllMajor(iid);
	}

	@Override
	public void addMajor(Major m) {
		majorMapper.addMajor(m);
	}

	@Override
	public void removeMajors(List<Integer> ids) {
		majorMapper.removeMajors(ids);
	}

	@Override
	public List<Major> getAllMajor() {
		return majorMapper.getAllMajor();
	}

	@Override
	public void updateMajor(Major major) {
		majorMapper.updateMajor(major);
	}

	@Override
	public Major getMajorById(Integer id) {
		return majorMapper.getMajorById(id);
	}
	
	
	
	
	
}
