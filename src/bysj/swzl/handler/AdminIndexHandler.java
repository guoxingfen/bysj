package bysj.swzl.handler;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import bysj.swzl.constant.GoodsType;
import bysj.swzl.service.FamousRemarkService;
import bysj.swzl.service.GoodsInfoService;
import bysj.swzl.service.HtuserService;
import bysj.swzl.service.LeaMesService;
import bysj.swzl.service.NoticeBoardService;
import bysj.swzl.service.StuInfoService;

@Controller
@RequestMapping("/admin")
public class AdminIndexHandler {

	@Autowired
	private StuInfoService stuInfoService;
	@Autowired
	private HtuserService htuserService;
	@Autowired
	private FamousRemarkService famousRemarkService;
	@Autowired
	private LeaMesService leaMesService;
	@Autowired
	private NoticeBoardService noticeBoardService;
	@Autowired
	private GoodsInfoService goodsInfoService;
	
	// 进入登录页面
	@RequestMapping("/toLogin")
	public ModelAndView toLogin() {
		ModelAndView mv=new ModelAndView();
		mv.setViewName("admin/pages/login");
		return mv;
	}
	
	// 请求主页
	@RequestMapping("/toZhuYe")
	public ModelAndView toZhuYe() {
		ModelAndView mv=new ModelAndView();
		// 条件：全部
		Map<String,Integer> p1=new HashMap<String,Integer>();
		p1.put("status", 2);
		// 条件：启用的
		Map<String,Integer> p2=new HashMap<String,Integer>();
		p2.put("status", 1);
		
		Integer stuTotal=stuInfoService.getTotal(p1);
		Integer stuStart=stuInfoService.getTotal(p2);
		Integer htuserTotal=htuserService.getTotal(p1);
		Integer htuserStart=htuserService.getTotal(p2);
		Integer famousRemarkTotal=famousRemarkService.getTotal();
		Integer leaMesTotal=leaMesService.getTotal();
		Integer noticeBoardTotal=noticeBoardService.getTotal();
		
		Map<String,Object> p3=new HashMap<String,Object>();
		p3.put("type", GoodsType.Lost_Goods);
		Integer lostTotal=goodsInfoService.getTotalByKind(p3);
		p3.put("status", 1);
		Integer lostConfirm=goodsInfoService.getTotalByKind(p3);
		
		Map<String,Object> p4=new HashMap<String,Object>();
		p4.put("type", GoodsType.Get_Goods);
		Integer getTotal=goodsInfoService.getTotalByKind(p4);
		p4.put("status", 1);
		Integer getConfirm=goodsInfoService.getTotalByKind(p4);
		
		
		mv.addObject("stuTotal", stuTotal);
		mv.addObject("stuStart",stuStart);
		mv.addObject("htuserTotal", htuserTotal);
		mv.addObject("htuserStart", htuserStart);
		mv.addObject("famousRemarkTotal", famousRemarkTotal);
		mv.addObject("leaMesTotal", leaMesTotal);
		mv.addObject("noticeBoardTotal", noticeBoardTotal);
		mv.addObject("lostTotal", lostTotal);
		mv.addObject("lostConfirm", lostConfirm);
		mv.addObject("getTotal", getTotal);
		mv.addObject("getConfirm", getConfirm);
		mv.setViewName("admin/pages/zhuye");
		return mv;
	}
	
	
	
}
