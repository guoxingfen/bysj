package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.AddressStatistics;
import bysj.swzl.pojo.KindStatistics;
import bysj.swzl.pojo.TimeStatistics;

public interface StatisticsMapper {

	// ͳ����Ʒ������ÿ�����������
	List<KindStatistics> statisticsKind();
	// ͳ�Ƴ����ص㶪ʧ��ʰ����Ʒ������
	List<AddressStatistics> statisticsAddress();
	// ͳ��ʱ�����Ϣ
	List<TimeStatistics> statisticsTime();
	
}
