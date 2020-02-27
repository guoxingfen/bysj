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
	
	// 请求所有物品的信息
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
	// 请求举报物品信息
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
	// 删除物品信息
	// 先删除物品的图片
	// 删除与物品信息相关的东西
	@RequestMapping("/deleteSelectGoods")
	public @ResponseBody Message deleteSelectGoods(String ids) {
		Message ms=new Message();
		if(!"".equals(ids)) {
			String[] idstr=ids.split(":");
			List<Integer> list=new ArrayList<Integer>();
			for(int i=1;i<idstr.length;i++) {
				list.add(Integer.parseInt(idstr[i]));
			}
			// 删除评论与回复信息
			commentService.removeComments(list);
			// 删除举报信息
			reportService.removeReports(list);
			// 删除关注信息
			followService.deleteFollows(list);
            // 删除图片			
			for(Integer id:list) {
				GoodsInfoVo gif=goodsInfoService.getGoodsInfo(id);
				String filePath="C:\\Users\\hhhlll\\Pictures\\图标\\1";
				File img=new File(filePath+"/"+gif.getGoodsInfo().getPic());
				img.delete();
			}
			adminGoodsService.removeGoods(list);
			ms.setMessage("删除成功！");
			ms.setCode(MesCode.SUCCESS);
		}else {
			ms.setMessage("删除失败，未选择数据！");
			ms.setCode(MesCode.FAIL);
		}
		return ms;
	}
	// 添加物品
	@RequestMapping("/addPreGoods")
	public ModelAndView addPreGoods(Integer id) {
		ModelAndView mv=new ModelAndView();
		if(id!=null) {
			GoodsInfoVo gif=goodsInfoService.getGoodsInfo(id);
			mv.addObject("goodsInfoVo", gif);
		}
		// 获取物品种类信息
		List<Kind> list=kindService.getAllKind();
		mv.addObject("kinds", list);
		mv.setViewName("admin/pages/goods-add");
		return mv;
	}
	@RequestMapping("/addGoods")
	public @ResponseBody Message addGoods(GoodsInfo gi,MultipartFile picFile) {
		Message ms=new Message();
		if(picFile!=null) {
			// 原来图片名称
			String old_name=picFile.getOriginalFilename();
			// 保存图片的文件路径
			String filePath="C:\\Users\\hhhlll\\Pictures\\图标\\1";
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
	// 确认物品已找回或已认领
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
