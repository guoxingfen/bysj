package bysj.swzl.handler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import bysj.swzl.pojo.AddressStatistics;
import bysj.swzl.pojo.KindStatistics;
import bysj.swzl.pojo.TimeStatistics;
import bysj.swzl.service.StatisticsService;

@Controller
public class StatisticsHandler {

	@Autowired
	private StatisticsService statisticsService;
	
	// ��Ʒ����ͳ��
	// �ص�ͳ��
	// ʱ���ͳ��
	@RequestMapping("/mystatistics")
	public ModelAndView toStatistics() {
		ModelAndView mv=new ModelAndView();
		Gson gson=new Gson();
		// ��ȡ��Ʒ����ͳ����Ϣ
		List<KindStatistics> kindStatistics=statisticsService.statiscsKind();
		// ��ȡ�ص�ͳ����Ϣ
		List<AddressStatistics> addressStatistics=statisticsService.statiscsAddress();
		// ��ȡʱ���ͳ��
		List<TimeStatistics> timeStatistics=statisticsService.statiscsTime();
		
		mv.addObject("kindStatistics",gson.toJson(kindStatistics));
		mv.addObject("addressStatistics", gson.toJson(addressStatistics));
		mv.addObject("timeStatitics", gson.toJson(timeStatistics));
		mv.addObject("status",5);
		mv.setViewName("statistics");
		return mv;
	}
	
	// �첽ˢ��
	@RequestMapping("/toRefresh")
	public @ResponseBody Map<String,Object> toRefresh(){
		Map<String,Object> map=new HashMap<String,Object>();
		// ��ȡ��Ʒ����ͳ����Ϣ
		List<KindStatistics> kindStatistics=statisticsService.statiscsKind();
		// ��ȡ�ص�ͳ����Ϣ
		List<AddressStatistics> addressStatistics=statisticsService.statiscsAddress();
		// ��ȡʱ���ͳ��
		List<TimeStatistics> timeStatistics=statisticsService.statiscsTime();
		map.put("kindStatistics", kindStatistics);
		map.put("addressStatistics", addressStatistics);
		map.put("timeStatistics", timeStatistics);
		return map;
	}
	
	
	
	
	
}
