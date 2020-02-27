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
	
	// 物品种类统计
	// 地点统计
	// 时间段统计
	@RequestMapping("/mystatistics")
	public ModelAndView toStatistics() {
		ModelAndView mv=new ModelAndView();
		Gson gson=new Gson();
		// 获取物品种类统计信息
		List<KindStatistics> kindStatistics=statisticsService.statiscsKind();
		// 获取地点统计信息
		List<AddressStatistics> addressStatistics=statisticsService.statiscsAddress();
		// 获取时间段统计
		List<TimeStatistics> timeStatistics=statisticsService.statiscsTime();
		
		mv.addObject("kindStatistics",gson.toJson(kindStatistics));
		mv.addObject("addressStatistics", gson.toJson(addressStatistics));
		mv.addObject("timeStatitics", gson.toJson(timeStatistics));
		mv.addObject("status",5);
		mv.setViewName("statistics");
		return mv;
	}
	
	// 异步刷新
	@RequestMapping("/toRefresh")
	public @ResponseBody Map<String,Object> toRefresh(){
		Map<String,Object> map=new HashMap<String,Object>();
		// 获取物品种类统计信息
		List<KindStatistics> kindStatistics=statisticsService.statiscsKind();
		// 获取地点统计信息
		List<AddressStatistics> addressStatistics=statisticsService.statiscsAddress();
		// 获取时间段统计
		List<TimeStatistics> timeStatistics=statisticsService.statiscsTime();
		map.put("kindStatistics", kindStatistics);
		map.put("addressStatistics", addressStatistics);
		map.put("timeStatistics", timeStatistics);
		return map;
	}
	
	
	
	
	
}
