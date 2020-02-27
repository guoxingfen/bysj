package bysj.swzl.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.mapper.KindMapper;
import bysj.swzl.pojo.Kind;
import bysj.swzl.service.KindService;

@Service
public class KindServiceImpl implements KindService {

	@Autowired
	private KindMapper kindMapper;
	
	@Override
	public List<Kind> getAllKind() {
		return kindMapper.getAllKind();
	}

	@Override
	public void addKind(Kind k) {
		kindMapper.addKind(k);
	}

	@Override
	public void updateKind(Kind k) {
		kindMapper.updateKind(k);
	}

	@Override
	public void removeKind(List<Integer> id) {
		kindMapper.removeKind(id);
	}

	@Override
	public Kind getKindById(Integer id) {
		return kindMapper.getKindById(id);
	}

}
