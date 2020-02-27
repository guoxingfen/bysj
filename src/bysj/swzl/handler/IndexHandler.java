package bysj.swzl.handler;


import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import bysj.swzl.constant.GoodsType;
import bysj.swzl.constant.MesCode;
import bysj.swzl.pojo.GoodsInfo;
import bysj.swzl.pojo.Message;
import bysj.swzl.pojo.NoticeBoard;
import bysj.swzl.pojo.Praise;
import bysj.swzl.pojo.StuInfo;
import bysj.swzl.service.GoodsInfoService;
import bysj.swzl.service.NoticeBoardService;
import bysj.swzl.service.PraiseService;
import bysj.swzl.service.StuInfoService;


@Controller
public class IndexHandler {

	@Autowired
	private GoodsInfoService goodsInfoService;
	@Autowired
	private StuInfoService stuInfoService;
	@Autowired
	private NoticeBoardService noticeBoardService;
	@Autowired
	private PraiseService praiseService;
	
	// ������ҳ��
	@RequestMapping("/index")
	public String toIndex() {
		return "forward:/WEB-INF/pages/index.jsp";
	}
	// ��¼
//	@RequestMapping("/preIndex")
//	public void toPreIndex(Integer id,HttpServletRequest request,HttpServletResponse response) {
//		HttpSession session=request.getSession();
//		StuInfo si=stuInfoService.getStuById(id);
//		session.setAttribute("stuInfo", si);
//		try {
//			request.getRequestDispatcher("/queryAllInfo.action").forward(request, response);
//		} catch (ServletException | IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
	// �˳���¼
	@RequestMapping("/logout")
    public void logOut(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session=request.getSession();
		session.removeAttribute("stuInfo");
	    try {
	    	request.getRequestDispatcher("/queryAllInfo.action").forward(request, response);
		} catch (ServletException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	// ��ѯ��Ʒ��Ϣ�͹�������Ϣ
	@RequestMapping("/queryAllInfo")
	public String queryGoods(Model mv) {
		// ��ȡ��Ʒ��Ϣ����
		List<GoodsInfo> goodsPicNotNull=goodsInfoService.getGoodsPicNotNull();
		List<GoodsInfo> lostGoods=goodsInfoService.getGoodsByType(GoodsType.Lost_Goods);
		List<GoodsInfo> getGoods=goodsInfoService.getGoodsByType(GoodsType.Get_Goods);
		// ��ȡ��������Ϣ
		List<NoticeBoard> noticeBoards=noticeBoardService.getAllNoticeBoard();
		// �����ݴ���ǰ̨
		mv.addAttribute("noticeBoards", noticeBoards);
		mv.addAttribute("goodsPicNotNull", goodsPicNotNull);
		mv.addAttribute("lostGoods", lostGoods);
		mv.addAttribute("getGoods", getGoods);
		mv.addAttribute("status", 1);
		return "forward:/index.action";
	}
	
	// ��ӱ�����
	@RequestMapping("/addPraise")
	public @ResponseBody Message addPraise(String uname,String content,Integer fromSid) {
		Message ms=new Message();
		StuInfo si=new StuInfo();
		si.setUname(uname);
		Message m=stuInfoService.queryStu(si);
		Praise praise=new Praise();
		si=(StuInfo)m.getObj();
		praise.setFromSid(fromSid);
		praise.setToSid(si.getId());
		praise.setContent(content);
		praiseService.addPraise(praise);
		ms.setCode(MesCode.SUCCESS);
		return ms;
	}
	
	// �鿴��������
	@RequestMapping("/lookupnotice")
	public ModelAndView lookUpNotice(Integer id) {
		ModelAndView mv=new ModelAndView();
		// ��ȡĳ��������Ϣ
		NoticeBoard nb=noticeBoardService.getNoticeBoardById(id);
		// ��ȡ��������Ϣ
		List<NoticeBoard> noticeBoards=noticeBoardService.getAllNoticeBoard();
		mv.addObject("nb", nb);
		mv.addObject("noticeBoards", noticeBoards);
		mv.setViewName("announcement");
		return mv;
	}
	
	// ��������
	@RequestMapping("/law")
	public ModelAndView toLaw() {
		ModelAndView mv=new ModelAndView();
		mv.setViewName("law");
		return mv;
	}
	// ��������
	@RequestMapping("/aboutus")
	public ModelAndView aboutUs() {
		ModelAndView mv=new ModelAndView();
		mv.setViewName("aboutus");
		return mv;
	}
	
	
	
	
	
	
	
	
}
