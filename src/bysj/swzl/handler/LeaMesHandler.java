package bysj.swzl.handler;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import bysj.swzl.pojo.LeaMes;
import bysj.swzl.pojo.LeaMesVo;
import bysj.swzl.pojo.PageModel;
import bysj.swzl.service.LeaMesService;

@Controller
public class LeaMesHandler {

	@Autowired
	private LeaMesService leaMesService;
	
	
	// 添加留言
	@RequestMapping("/addLeaMes")
	public String addLeaMes(LeaMes lm) {
		lm.setDate(new Date());
		leaMesService.addLeaMes(lm);
		return "redirect:/queryAllLeaMes.action?pageNumber=1";
	}
	
	// 查询全部留言并将数据返回前端
	@RequestMapping("/queryAllLeaMes")
	public ModelAndView queryAllLeaMes(Integer pageNumber) {
		ModelAndView mv=new ModelAndView();
		Integer totalRecord=leaMesService.getTotal();
		Integer pageSize=6;
		PageModel<LeaMesVo> leaMes_pageModel=new PageModel<LeaMesVo>(pageNumber,pageSize,totalRecord);
		List<LeaMesVo> list=leaMesService.getAllLeaMes(leaMes_pageModel);
		leaMes_pageModel.setData(list);
		mv.addObject("leaMes_pageModel", leaMes_pageModel);
		mv.addObject("status", 6);
		mv.setViewName("message");
		return mv;
	}
	
	
	
	
	
	
	
}
