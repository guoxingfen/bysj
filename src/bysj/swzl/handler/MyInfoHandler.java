package bysj.swzl.handler;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import bysj.swzl.pojo.GoodsInfo;
import bysj.swzl.pojo.Institute;
import bysj.swzl.pojo.Major;
import bysj.swzl.pojo.PageModel;
import bysj.swzl.pojo.PraiseVo;
import bysj.swzl.pojo.QueryFactor;
import bysj.swzl.pojo.StuInfo;
import bysj.swzl.service.FollowService;
import bysj.swzl.service.GoodsInfoService;
import bysj.swzl.service.InstituteService;
import bysj.swzl.service.MajorService;
import bysj.swzl.service.PraiseService;
import bysj.swzl.service.StuInfoService;

@Controller
public class MyInfoHandler {

	@Autowired
	private StuInfoService stuInfoService;
	@Autowired
	private InstituteService instituteService;
	@Autowired
	private MajorService majorService;
	@Autowired
	private GoodsInfoService goodsInfoService;
	@Autowired
	private FollowService followService;
	@Autowired
	private PraiseService praiseService;
	
	// 进入个人中心页面
	@RequestMapping("/myinfo")
	public ModelAndView myInfo(QueryFactor qf) {
		ModelAndView mv=new ModelAndView();
		// 查询该用户信息
		StuInfo myInfo=stuInfoService.getStuById(qf.getSid());
		// 获取所有学院信息
		List<Institute> institutes=instituteService.queryAllInstitute();
		// 当用户学院不为空时，获取所在学院的专业信息
		List<Major> majors=null;
		if(myInfo.getInstitute()!=null) {
			Institute institute=instituteService.getInstituteByDesc(myInfo.getInstitute());
			if(institute!=null) {
				majors=majorService.queryAllMajor(institute.getId());
			}
		}
		// 获取该用户发布的信息
		// 总记录数
		Integer totalRecord=goodsInfoService.getTotalBySid(qf);
		// 每页显示7条
		Integer pageSize=7;
		PageModel<GoodsInfo> publish_pageModel=new PageModel<GoodsInfo>(qf.getPageNumber(),pageSize,totalRecord);
		qf.setStartIndex(publish_pageModel.getStartIndex());
		qf.setPageSize(pageSize);
		List<GoodsInfo> list=goodsInfoService.queryAllGoodsBySid(qf);
		publish_pageModel.setData(list);
		// 获取该用户关注的信息
		// 总记录数
		Integer followTotal=followService.getTotal(qf.getSid());
		PageModel<GoodsInfo> follow_pageModel=new PageModel<GoodsInfo>(qf.getPageNumber(),pageSize,followTotal);
		qf.setStartIndex(follow_pageModel.getStartIndex());
		qf.setPageSize(pageSize);
		list=goodsInfoService.queryFollowGoods(qf);
		follow_pageModel.setData(list);
		// 获取该用户收到的表扬信
		Integer praiseTotal=praiseService.getTotalByToSid(qf.getSid());
		// 每页8条
		pageSize=8;
		PageModel<PraiseVo> praise_pageModel=new PageModel<PraiseVo>(qf.getPageNumber(),pageSize,praiseTotal);
		qf.setStartIndex(praise_pageModel.getStartIndex());
		qf.setPageSize(pageSize);
		List<PraiseVo> praises=praiseService.queryAllByToSid(qf);
		praise_pageModel.setData(praises);
		
		mv.addObject("myInfo", myInfo);
		mv.addObject("institutes", institutes);
		mv.addObject("majors", majors);
		mv.addObject("publish_pageModel", publish_pageModel);
		mv.addObject("follow_pageModel", follow_pageModel);
		mv.addObject("praise_pageModel", praise_pageModel);
		mv.setViewName("my");
		
		return mv;
	}
	
	// 完善个人信息
	@RequestMapping("/editmyinfo.action")
	public String editMyInfo(StuInfo my,MultipartFile picFile,HttpServletRequest request) {
		String old_name=picFile.getOriginalFilename();
		if(old_name!="") {
			String filePath="C:\\Users\\hhhlll\\Pictures\\图标\\1";
			File f=new File(filePath);
			if(!f.exists()) {
				f.mkdir();
			}
			// 原先的图片文件
			File img=new File(filePath+"/"+my.getPic());
			// 删除原先的头像
			img.delete();
			// 保存图片的文件路径
			String new_name=UUID.randomUUID()+old_name.substring(old_name.lastIndexOf("."));
			File file=new File(filePath+"/"+new_name);
			try {
				picFile.transferTo(file);
				my.setPic(new_name);
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// 更新个人信息
		stuInfoService.updateStuInfo(my);
		// 改变session中的值 
		HttpSession session=request.getSession();
		session.setAttribute("stuInfo", my);
		
		return "redirect:/myinfo.action?sid="+my.getId()+"&pageNumber=1";
	}
	
	// 查询对应学院下的所有专业
	@RequestMapping("/getallmajor")
	public @ResponseBody List<Major> queryAllMajor(String desc){
		Institute institute=instituteService.getInstituteByDesc(desc);
		List<Major> list=majorService.queryAllMajor(institute.getId());
		return list;
	}
	
	// 查询自己发布的信息
	@RequestMapping("/queryPublish")
	public @ResponseBody PageModel<GoodsInfo> queryPublish(QueryFactor qf) {
		// 获取该用户发布的信息
		// 总记录数
		Integer totalRecord=goodsInfoService.getTotalBySid(qf);
		// 每页显示7条
	    Integer pageSize=7;
		PageModel<GoodsInfo> publish_pageModel=new PageModel<GoodsInfo>(qf.getPageNumber(),pageSize,totalRecord);
		qf.setStartIndex(publish_pageModel.getStartIndex());
		qf.setPageSize(pageSize);
		List<GoodsInfo> list=goodsInfoService.queryAllGoodsBySid(qf);
		publish_pageModel.setData(list);
		return publish_pageModel;
	}
	// 删除发布信息
//	@RequestMapping("/deleteGoods")
//	public @ResponseBody Integer deleteGoods(Integer gid) {
//		goodsInfoService.deleteGoodsById(gid);
//		return gid;
//	}
	
	
	// 查询关注的信息
	@RequestMapping("/queryFollow")
	public @ResponseBody PageModel<GoodsInfo> queryFollow(QueryFactor qf){
		// 关注总记录数
		Integer followTotal=followService.getTotal(qf.getSid());
		// 每页显示7条
	    Integer pageSize=7;
		PageModel<GoodsInfo> follow_pageModel=new PageModel<GoodsInfo>(qf.getPageNumber(),pageSize,followTotal);
		qf.setStartIndex(follow_pageModel.getStartIndex());
		qf.setPageSize(pageSize);
		List<GoodsInfo>list=goodsInfoService.queryFollowGoods(qf);
		follow_pageModel.setData(list);
		return follow_pageModel;
	}
	
	// 查询该用户收到的表扬信
	@RequestMapping("/queryPraise")
	public @ResponseBody PageModel<PraiseVo> queryPraise(QueryFactor qf){
		
		// 获取该用户收到的表扬信
		Integer praiseTotal=praiseService.getTotalByToSid(qf.getSid());
		// 每页8条
		Integer pageSize=8;
		PageModel<PraiseVo> praise_pageModel=new PageModel<PraiseVo>(qf.getPageNumber(),pageSize,praiseTotal);
		qf.setStartIndex(praise_pageModel.getStartIndex());
		qf.setPageSize(pageSize);
		List<PraiseVo> praises=praiseService.queryAllByToSid(qf);
		praise_pageModel.setData(praises);
		return praise_pageModel;
	}
	// 查看收到表扬信的详情
	@RequestMapping("/lookUpPraise")
	public @ResponseBody PraiseVo lookUpPraise(Integer id) {
		PraiseVo p=praiseService.queryPraiseById(id);
		return p;
	}
	// 删除表扬信
	@RequestMapping("/removePraise")
	public @ResponseBody Integer removePraise(Integer id) {
		praiseService.removePraise(id);
		return id;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
