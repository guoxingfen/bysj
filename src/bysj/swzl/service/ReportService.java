package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.Report;

public interface ReportService {

	// ��ѯĳ����Ʒ��Ϣ�ľٱ�����
	Integer getTotal(Integer gid);
	// �����û�id����Ʒ��Ϣid���Ҿٱ���Ϣ
	Report getReportBySidAndGid(Report report);
	// ����һ���ٱ���Ϣ
	void addReport(Report report);
	// ɾ���ٱ���Ϣ
	void removeReports(List<Integer> gids);
}
