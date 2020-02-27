package bysj.swzl.handler;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import bysj.swzl.constant.MesCode;
import bysj.swzl.pojo.Comment;
import bysj.swzl.pojo.CommentVo;
import bysj.swzl.pojo.Follow;
import bysj.swzl.pojo.GoodsInfo;
import bysj.swzl.pojo.GoodsInfoVo;
import bysj.swzl.pojo.Kind;
import bysj.swzl.pojo.Message;
import bysj.swzl.pojo.PageModel;
import bysj.swzl.pojo.PraiseVo;
import bysj.swzl.pojo.QueryFactor;
import bysj.swzl.pojo.Reply;
import bysj.swzl.pojo.Report;
import bysj.swzl.pojo.SearchFactor;
import bysj.swzl.pojo.StuInfo;
import bysj.swzl.service.CommentService;
import bysj.swzl.service.FollowService;
import bysj.swzl.service.GoodsInfoService;
import bysj.swzl.service.KindService;
import bysj.swzl.service.PraiseService;
import bysj.swzl.service.ReplyService;
import bysj.swzl.service.ReportService;
import bysj.swzl.service.StuInfoService;

@Controller
public class GoodsInfoHandler {

	@Autowired
	private GoodsInfoService goodsInfoService;
	@Autowired
	private StuInfoService stuInfoService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private ReplyService replyService;
	@Autowired
	private ReportService reportService;
	@Autowired
	private FollowService followService;
	@Autowired
	private KindService kindService;
	@Autowired
	private PraiseService praiseService;
	
	// �տ�ʼ���뷢����Ϣҳ��
	// ��ȡȫ��������Ϣ�Լ����˰���Ϣ
	@RequestMapping("/torelease")
	public ModelAndView goRelease() {
		ModelAndView mv=new ModelAndView();
		// ��ȡȫ������
		List<Kind> kinds=kindService.getAllKind();
		// ��ȡ���˰���Ϣ
		List<Map<String,Object>> goodManList=goodsInfoService.getGoodMan();
		mv.addObject("kinds", kinds);
		mv.addObject("goodManList", goodManList);
		mv.addObject("status", 4);
		mv.setViewName("release");
		return mv;
	}
	// ��ѡ����Ʒ����ʱ��ͼƬ��ʾΪ���·�����5��
	@RequestMapping("/changePic")
	public @ResponseBody Message changePic(GoodsInfo gi) {
		Message ms=new Message();
		List<GoodsInfo> list=goodsInfoService.queryGoodsByGoodsInfo(gi);
		if(list.size()>0) {
			ms.setCode(MesCode.SUCCESS);
			ms.setObj(list);
		}else {
			ms.setCode(MesCode.FAIL);
		}
		return ms;
	}
	
	// �����Ʒ��Ϣ
	@RequestMapping("/addGoodsInfo")
	public String addGoodsInfo(GoodsInfo gi,MultipartFile pictureFile,Model mv,HttpSession session) {
		String old_name=pictureFile.getOriginalFilename();
		if(old_name!="") {
			// ����ͼƬ���ļ�·��
			String filePath="C:\\Users\\hhhlll\\Pictures\\ͼ��\\1";
			File f=new File(filePath);
			if(!f.exists()) {
				f.mkdir();
			}
			String new_name=UUID.randomUUID()+old_name.substring(old_name.lastIndexOf("."));
			File file=new File(filePath+"/"+new_name);
			try {
				pictureFile.transferTo(file);
				gi.setPic(new_name);
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		gi.setPublish_date(new Date());
		StuInfo si=(StuInfo)session.getAttribute("stuInfo");
		gi.setPhone(si.getMphone());
		gi.setStatus(0);
		gi.setPageview(0);
		goodsInfoService.addGoodsInfo(gi);
		// ������ҳ��
		return "forward:/queryAllInfo.action";
	}
	// �鿴��Ʒ��Ϣ����
	@RequestMapping("/lookUpGoods")
	public ModelAndView lookUpGoods(Integer sid,Integer gid) {
		ModelAndView mv=new ModelAndView();
		// ��ȡ��Ʒ����Ϣ
		GoodsInfoVo gi=goodsInfoService.getGoodsInfo(gid);
		// �ı������
		Integer pageview=gi.getGoodsInfo().getPageview();
		gi.getGoodsInfo().setPageview(++pageview);
		goodsInfoService.updateGoods(gi.getGoodsInfo());
		// ������Ϣ������Ϣ
		StuInfo stuInfo=stuInfoService.getStuById(gi.getGoodsInfo().getSid());
		// ��Ʒ�����б�
		List<CommentVo> commentsVo=commentService.getComments(gi.getGoodsInfo().getId());
		// �ٱ���Ϣ  �Ƿ��ע
		Report r=new Report();
		r.setSid(sid);
		r.setGid(gid);
		Follow f=new Follow();
		f.setSid(sid);
		f.setGid(gid);
		Report report=null;
		Follow follow=null;
		if(sid!=null) {
		    report=reportService.getReportBySidAndGid(r);
            follow=followService.queryFollow(f);
		}
		mv.addObject("gi", gi);
		mv.addObject("report", report);
		mv.addObject("follow", follow);
		mv.addObject("commentsVo", commentsVo);
		mv.addObject("personInfo", stuInfo);
		mv.setViewName("detail");
		return mv;
	}
	
	// �������
	@RequestMapping("/addComment")
	public String addComment(Comment comment) {
		// ���÷���ʱ��
		comment.setCreatetime(new Date());
		commentService.addComment(comment);
		return "forward:/lookUpGoods.action?gid="+comment.getGid()+"&sid="+comment.getSid();
	}
	// ɾ������ ���Ѹ������µĻظ�Ҳȫ��ɾ����
	@RequestMapping("/removeComment")
	public String removeComment(Integer id,Integer gid,Integer sid) {
		// ɾ������
		List<Integer> ids=new ArrayList<Integer>();
		ids.add(id);
		commentService.removeCommentsByIds(ids);
		return "forward:/lookUpGoods.action?gid="+gid+"&sid="+sid;
	}
	
	// ��ĳ����������ӻظ�
	@RequestMapping("/addReply")
	public String addReply(Reply reply,Integer gid) {
		reply.setCreatetime(new Date());
		replyService.addReply(reply);
		return "forward:/lookUpGoods.action?gid="+gid+"&sid="+reply.getSid();
	}
	
	// ɾ���Լ�����Ļظ�
	@RequestMapping("/removeReply")
	public String removeReply(Integer id,Integer gid,Integer sid) {
		replyService.removeReply(id);
		return "forward:/lookUpGoods.action?gid="+gid+"&sid="+sid;
	}
	
	// �ٱ�ĳ����Ʒ��Ϣ
	@RequestMapping("/reportGoods")
	public @ResponseBody Message reportGoods(Report report) {
		Message ms=new Message();
		reportService.addReport(report);
		ms.setCode(MesCode.SUCCESS);
		return ms;
	}
	// ��ע��Ʒ��Ϣ
	@RequestMapping("/addFollow")
	public @ResponseBody Message addFollow(Follow f) {
		Message ms=new Message();
		followService.addFollow(f);
		ms.setCode(MesCode.SUCCESS);
		return ms;
	}
	// ȡ����ע
	@RequestMapping("/removeFollow")
	public @ResponseBody Message removeFollow(Follow f) {
		Message ms=new Message();
		followService.removeFollow(f);
		ms.setObj(f);
		ms.setCode(MesCode.SUCCESS);
		return ms;
	}
	// ��ȷ��
	@RequestMapping("/pleaseConfirm")
	public @ResponseBody Message pleaseConfirm(Integer gid) {
		Message ms=new Message();
		GoodsInfoVo giv=goodsInfoService.getGoodsInfo(gid);
		GoodsInfo gi=giv.getGoodsInfo();
		gi.setStatus(1);
		goodsInfoService.updateGoods(gi);
		ms.setCode(MesCode.SUCCESS);
		return ms;
	}
	
	
	
	
	
	
	// �鿴�û���Ϣ�뷢����������Ϣ����ҳ
	@RequestMapping("/queryStuAllInfo")
	public ModelAndView queryStuAllInfo(QueryFactor qf) {
		ModelAndView mv=new ModelAndView();
		StuInfo s=stuInfoService.getStuById(qf.getSid());
		Integer totalRecord=goodsInfoService.getTotalBySid(qf);
		// ÿҳ��ʾ9��
		Integer pageSize=9;
		PageModel<GoodsInfo> pageModel=new PageModel<GoodsInfo>(qf.getPageNumber(),pageSize,totalRecord);
		qf.setStartIndex(pageModel.getStartIndex());
		qf.setPageSize(pageSize);
		List<GoodsInfo> list=goodsInfoService.queryAllGoodsBySid(qf);
		pageModel.setData(list);
		mv.addObject("otherStuInfo", s);
		mv.addObject("pageModel", pageModel);
		mv.addObject("queryFactor", qf);
		mv.setViewName("otherinfo");
		return mv;
	}
	
	// Ѱ������ҳ��
	// ������Ϣ
	// ��ҳ
	// ϲ��������Ϣ
	@RequestMapping("/forlost")
	public ModelAndView getLost(Integer pageNumber) {
		ModelAndView mv=new ModelAndView();
		// ��ȡȫ������
		List<Kind> kinds=kindService.getAllKind();
		// ��ȡϲ��������Ϣ
		List<Map<String,Object>> goodNews=goodsInfoService.getGoodNews();
		// ʧ����Ϣ����ҳ
		SearchFactor sf=new SearchFactor();
		sf.setLost("Lost_Goods");
		Integer totalRecord=goodsInfoService.getTotalByType(sf);
		Integer pageSize=12;
		PageModel<GoodsInfoVo> pageModel=new PageModel<GoodsInfoVo>(pageNumber,pageSize,totalRecord);
		sf.setStartIndex(pageModel.getStartIndex());
		sf.setPageSize(pageSize);
		List<GoodsInfoVo> goodsInfoes=goodsInfoService.getGoodsByGoodsTypePaging(sf);
		pageModel.setData(goodsInfoes);
		
		mv.addObject("kinds", kinds);
        mv.addObject("goodNews", goodNews);
		mv.addObject("pageLostModel", pageModel);
		mv.addObject("status", 2);
		mv.setViewName("lost");
		
		return mv;
	}
	// Ѱ������ɸѡ
	@RequestMapping("/screenLost")
	public @ResponseBody PageModel<GoodsInfoVo> screenLost(SearchFactor sf,Integer pageNumber) {
		sf.setLost("Lost_Goods");
		if(sf.getDays()!=null) {
			Integer days=sf.getDays().get(sf.getDays().size()-1);
			Date d=new Date();
			Calendar rightNow=Calendar.getInstance();
			rightNow.setTime(d);
			rightNow.add(Calendar.DAY_OF_YEAR, -days);
			sf.setDate(rightNow.getTime());
		}
		Integer totalRecord=goodsInfoService.getTotalByType(sf);
		Integer pageSize=12;
		PageModel<GoodsInfoVo> pm=new PageModel<GoodsInfoVo>(pageNumber,pageSize,totalRecord);
		sf.setPageSize(pageSize);
		sf.setStartIndex(pm.getStartIndex());
		List<GoodsInfoVo> list=goodsInfoService.getGoodsByGoodsTypePaging(sf);
		pm.setData(list);
		return pm;
	}
	// ��������ҳ��
	// ������Ϣ
	// ��ҳ
	// ���﹫����Ϣ
	@RequestMapping("/forget")
	public ModelAndView getGet(Integer pageNumber) {
		ModelAndView mv=new ModelAndView();
		// ��ȡȫ������
		List<Kind> kinds=kindService.getAllKind();
		// ��ȡ���﹫����Ϣ
		List<PraiseVo> praiseNews=praiseService.getPraise();
		// ������Ϣ����ҳ
		SearchFactor sf=new SearchFactor();
		sf.setLost("Get_Goods");
		Integer totalRecord=goodsInfoService.getTotalByType(sf);
		Integer pageSize=12;
		PageModel<GoodsInfoVo> pageModel=new PageModel<GoodsInfoVo>(pageNumber,pageSize,totalRecord);
		sf.setStartIndex(pageModel.getStartIndex());
		sf.setPageSize(pageSize);
		List<GoodsInfoVo> goodsInfoes=goodsInfoService.getGoodsByGoodsTypePaging(sf);
		pageModel.setData(goodsInfoes);
		
		mv.addObject("kinds", kinds);
        mv.addObject("praiseNews", praiseNews);
		mv.addObject("pageGetModel", pageModel);
		mv.addObject("status", 3);
		mv.setViewName("found");
		
		return mv;
	}
	
	// ��������ɸѡ
		@RequestMapping("/screenGet")
		public @ResponseBody PageModel<GoodsInfoVo> screenGet(SearchFactor sf,Integer pageNumber) {
			sf.setLost("Get_Goods");
			if(sf.getDays()!=null) {
				Integer days=sf.getDays().get(sf.getDays().size()-1);
				Date d=new Date();
				Calendar rightNow=Calendar.getInstance();
				rightNow.setTime(d);
				rightNow.add(Calendar.DAY_OF_YEAR, -days);
				sf.setDate(rightNow.getTime());
			}
			Integer totalRecord=goodsInfoService.getTotalByType(sf);
			Integer pageSize=12;
			PageModel<GoodsInfoVo> pm=new PageModel<GoodsInfoVo>(pageNumber,pageSize,totalRecord);
			sf.setPageSize(pageSize);
			sf.setStartIndex(pm.getStartIndex());
			List<GoodsInfoVo> list=goodsInfoService.getGoodsByGoodsTypePaging(sf);
			pm.setData(list);
			return pm;
		}
	
	
	
	
	
	
	
	
	
	
		
}
