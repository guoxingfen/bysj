package bysj.swzl.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.mapper.ReportMapper;
import bysj.swzl.pojo.Report;
import bysj.swzl.service.ReportService;

@Service
public class ReportServiceImpl implements ReportService {

	@Autowired
	private ReportMapper reportMapper;

	@Override
	public Integer getTotal(Integer gid) {
		return reportMapper.getTotal(gid);
	}

	@Override
	public Report getReportBySidAndGid(Report report) {
		return reportMapper.getReportBySidAndGid(report);
	}

	@Override
	public void addReport(Report report) {
		reportMapper.addReport(report);
	}

	@Override
	public void removeReports(List<Integer> gids) {
		reportMapper.removeReports(gids);
	}
	
	
}
