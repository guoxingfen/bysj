package bysj.swzl.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.mapper.InstituteMapper;
import bysj.swzl.mapper.MajorMapper;
import bysj.swzl.pojo.Institute;
import bysj.swzl.service.InstituteService;

@Service
public class InstituteServiceImpl implements InstituteService {

	@Autowired
	private InstituteMapper instituteMapper;
	@Autowired
	private MajorMapper majorMapper;
	@Override
	public List<Institute> queryAllInstitute() {
		return instituteMapper.queryAllInstitute();
	}
	@Override
	public void addInstitute(Institute institute) {
		instituteMapper.addInstitute(institute);
	}
	@Override
	public void removeInstitute(List<Integer> iids) {
		instituteMapper.removeInstitute(iids);
		// 删除该学院下的所有专业
		majorMapper.deleteMajorByIids(iids);
	}
	@Override
	public Institute getInstituteByDesc(String desc) {
		return instituteMapper.getInstituteByDesc(desc);
	}
	@Override
	public Institute getInstituteById(Integer id) {
		return instituteMapper.getInstituteById(id);
	}
	@Override
	public void updateInstitute(Institute institute) {
		instituteMapper.updateInstitute(institute);
	}
	
	
	
	
}
