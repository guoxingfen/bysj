package bysj.swzl.handler;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import bysj.swzl.pojo.FamousRemark;
import bysj.swzl.pojo.GoodsInfoVo;
import bysj.swzl.pojo.Kind;
import bysj.swzl.pojo.PageModel;
import bysj.swzl.pojo.SearchFactor;
import bysj.swzl.service.FamousRemarkService;
import bysj.swzl.service.GoodsInfoService;
import bysj.swzl.service.KindService;

@Controller
public class SearchHandler {

	
	@Autowired
	private KindService kindService;
	@Autowired
	private FamousRemarkService famousRemarkService;
	@Autowired
	private GoodsInfoService goodsInfoService;
	
	// ��������ҳ��
	// ��ҳ��Ϣ
	// ������Ϣ
	// ����
	@RequestMapping("/tosearch")
	public ModelAndView toSearch(String keyword,Integer pageNumber) {
		ModelAndView mv=new ModelAndView();
		// ������Ϣ
		List<Kind> kinds=kindService.getAllKind();
		// ����
		List<FamousRemark> famousRemarks=famousRemarkService.getAllFamousRemark();
		// ��ҳ��Ϣ
		SearchFactor sf=new SearchFactor();
		if(!"".equals(keyword)) {
			sf.setKeyword(keyword);
		}
		Integer totalRecord=goodsInfoService.getTotalByType(sf);
		Integer pageSize=15;
		PageModel<GoodsInfoVo> pageModel=new PageModel<GoodsInfoVo>(pageNumber,pageSize,totalRecord);
		sf.setStartIndex(pageModel.getStartIndex());
		sf.setPageSize(pageSize);
		List<GoodsInfoVo> list=goodsInfoService.getGoodsByGoodsTypePaging(sf);
		pageModel.setData(list);
		
		mv.addObject("keyword", keyword);
		mv.addObject("kinds", kinds);
		mv.addObject("famousRemarks", famousRemarks);
		mv.addObject("pageModel", pageModel);
		mv.setViewName("search");
		
		return mv;
	}
	
	@RequestMapping("/screenSearch")
	public @ResponseBody PageModel<GoodsInfoVo> screenSearch(SearchFactor sf,Integer pageNumber){
		if(sf.getDays()!=null) {
			Integer days=sf.getDays().get(sf.getDays().size()-1);
			Date d=new Date();
			Calendar rightNow=Calendar.getInstance();
			rightNow.setTime(d);
			rightNow.add(Calendar.DAY_OF_YEAR, -days);
			sf.setDate(rightNow.getTime());
		}
		Integer totalRecord=goodsInfoService.getTotalByType(sf);
		Integer pageSize=15;
		PageModel<GoodsInfoVo> pm=new PageModel<GoodsInfoVo>(pageNumber,pageSize,totalRecord);
		sf.setPageSize(pageSize);
		sf.setStartIndex(pm.getStartIndex());
		List<GoodsInfoVo> list=goodsInfoService.getGoodsByGoodsTypePaging(sf);
		pm.setData(list);
		return pm;
	}
	
	
	
	
	
	
	
	
	
	
}
