package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.Report;

public interface ReportMapper {

	// ͳ�ƾٱ����е�ĳ����Ʒ��Ϣ�ľٱ�����
	Integer getTotal(Integer gid);
	// ���ݾٱ���id����Ʒ��Ϣid���Ҿٱ���Ϣ
	Report getReportBySidAndGid(Report report);
	// ����һ���ٱ���Ϣ
	void addReport(Report report);
	// ɾ���ٱ���Ϣ
	void removeReports(List<Integer> gids);
	
}
