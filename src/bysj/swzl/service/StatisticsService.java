package bysj.swzl.service;

import java.util.List;

import bysj.swzl.pojo.AddressStatistics;
import bysj.swzl.pojo.KindStatistics;
import bysj.swzl.pojo.TimeStatistics;

public interface StatisticsService {

	// ͳ����Ʒ������ÿ�����������
	List<KindStatistics> statiscsKind();
	// ͳ�Ƴ����ص㶪ʧ��ʰ����Ʒ������
	List<AddressStatistics> statiscsAddress();
	// ͳ��ʱ�����Ϣ
	List<TimeStatistics> statiscsTime();
	
}
