package bysj.swzl.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.mapper.StatisticsMapper;
import bysj.swzl.pojo.AddressStatistics;
import bysj.swzl.pojo.KindStatistics;
import bysj.swzl.pojo.TimeStatistics;
import bysj.swzl.service.StatisticsService;

@Service
public class StatisticsServiceImpl implements StatisticsService {

	@Autowired
	private StatisticsMapper statisticsMapper;
	
	
	@Override
	public List<KindStatistics> statiscsKind() {
		return statisticsMapper.statisticsKind();
	}


	@Override
	public List<AddressStatistics> statiscsAddress() {
		return statisticsMapper.statisticsAddress();
	}


	@Override
	public List<TimeStatistics> statiscsTime() {
		return statisticsMapper.statisticsTime();
	}

}
