package bysj.swzl.handler;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import bysj.swzl.constant.GoodsType;
import bysj.swzl.constant.MesCode;
import bysj.swzl.pojo.AdminGoodsInfo;
import bysj.swzl.pojo.GoodsInfo;
import bysj.swzl.pojo.GoodsInfoVo;
import bysj.swzl.pojo.Kind;
import bysj.swzl.pojo.Message;
import bysj.swzl.service.AdminGoodsService;
import bysj.swzl.service.CommentService;
import bysj.swzl.service.FollowService;
import bysj.swzl.service.GoodsInfoService;
import bysj.swzl.service.KindService;
import bysj.swzl.service.ReplyService;
import bysj.swzl.service.ReportService;
@Controller
@RequestMapping("/admin")
public class AdminGoodsHandler {

	@Autowired
	private AdminGoodsService adminGoodsService;
	@Autowired
	private GoodsInfoService goodsInfoService;
	@Autowired
	private KindService kindService;
	@Autowired
	private FollowService followService;
	@Autowired
	private ReplyService replyService;
	@Autowired
	private ReportService reportService;
	@Autowired
	private CommentService commentService;
	
	// ����������Ʒ����Ϣ
	@RequestMapping("/goodsManage")
	public ModelAndView goodsManage(String type) {
		ModelAndView mv=new ModelAndView();
		if(type.equals("lost")) {
			List<AdminGoodsInfo> list=adminGoodsService.getAllGoodsByType(GoodsType.Lost_Goods);
			mv.addObject("adminGoodsInfoes", list);
			mv.setViewName("admin/pages/goods-lost-list");
		}else {
			List<AdminGoodsInfo> list=adminGoodsService.getAllGoodsByType(GoodsType.Get_Goods);
			mv.addObject("adminGoodsInfoes", list);
			mv.setViewName("admin/pages/goods-get-list");
		}
		return mv;
	}
	// ����ٱ���Ʒ��Ϣ
	@RequestMapping("/reportGoodsManage")
	public ModelAndView reportGoodsManage(Integer report,String type) {
		ModelAndView mv=new ModelAndView();
		Map<String,Object> map= new HashMap<String,Object>();
		map.put("type", type);
		map.put("report", report);
		List<AdminGoodsInfo> list=adminGoodsService.getAllReportGoods(map);
		mv.addObject("adminGoodsInfoes", list);
		mv.addObject("report", report);
		if(type.equals("Lost_Goods")) {
			mv.setViewName("admin/pages/goods-lost-list");
		}else {
			mv.setViewName("admin/pages/goods-get-list");
		}
		return mv;
	}
	// ɾ����Ʒ��Ϣ
	// ��ɾ����Ʒ��ͼƬ
	// ɾ������Ʒ��Ϣ��صĶ���
	@RequestMapping("/deleteSelectGoods")
	public @ResponseBody Message deleteSelectGoods(String ids) {
		Message ms=new Message();
		if(!"".equals(ids)) {
			String[] idstr=ids.split(":");
			List<Integer> list=new ArrayList<Integer>();
			for(int i=1;i<idstr.length;i++) {
				list.add(Integer.parseInt(idstr[i]));
			}
			// ɾ��������ظ���Ϣ
			commentService.removeComments(list);
			// ɾ���ٱ���Ϣ
			reportService.removeReports(list);
			// ɾ����ע��Ϣ
			followService.deleteFollows(list);
            // ɾ��ͼƬ			
			for(Integer id:list) {
				GoodsInfoVo gif=goodsInfoService.getGoodsInfo(id);
				String filePath="C:\\Users\\hhhlll\\Pictures\\ͼ��\\1";
				File img=new File(filePath+"/"+gif.getGoodsInfo().getPic());
				img.delete();
			}
			adminGoodsService.removeGoods(list);
			ms.setMessage("ɾ���ɹ���");
			ms.setCode(MesCode.SUCCESS);
		}else {
			ms.setMessage("ɾ��ʧ�ܣ�δѡ�����ݣ�");
			ms.setCode(MesCode.FAIL);
		}
		return ms;
	}
	// �����Ʒ
	@RequestMapping("/addPreGoods")
	public ModelAndView addPreGoods(Integer id) {
		ModelAndView mv=new ModelAndView();
		if(id!=null) {
			GoodsInfoVo gif=goodsInfoService.getGoodsInfo(id);
			mv.addObject("goodsInfoVo", gif);
		}
		// ��ȡ��Ʒ������Ϣ
		List<Kind> list=kindService.getAllKind();
		mv.addObject("kinds", list);
		mv.setViewName("admin/pages/goods-add");
		return mv;
	}
	@RequestMapping("/addGoods")
	public @ResponseBody Message addGoods(GoodsInfo gi,MultipartFile picFile) {
		Message ms=new Message();
		if(picFile!=null) {
			// ԭ��ͼƬ����
			String old_name=picFile.getOriginalFilename();
			// ����ͼƬ���ļ�·��
			String filePath="C:\\Users\\hhhlll\\Pictures\\ͼ��\\1";
			String new_name=UUID.randomUUID()+old_name.substring(old_name.lastIndexOf("."));
			File file=new File(filePath+"/"+new_name);
			try {
				picFile.transferTo(file);
				gi.setPic(new_name);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		if(gi.getId()!=null) {
			goodsInfoService.updateGoods(gi);
		}else {
			gi.setStatus(0);
			gi.setPageview(0);
			gi.setPublish_date(new Date());
			goodsInfoService.addGoodsInfo(gi);
		}
		ms.setCode(MesCode.SUCCESS);
		ms.setObj(gi);
		return ms;
	}
	// ȷ����Ʒ���һػ�������
	@RequestMapping("/updateGoodsStatus")
	public @ResponseBody Message updateGoodsStatus(Integer id) {
		Message ms=new Message();
		GoodsInfoVo gif=goodsInfoService.getGoodsInfo(id);
		GoodsInfo gi=gif.getGoodsInfo();
		gi.setStatus(1);
		goodsInfoService.updateGoods(gi);
		ms.setCode(MesCode.SUCCESS);
		return ms;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
