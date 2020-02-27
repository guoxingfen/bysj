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
	
	// �����������ҳ��
	@RequestMapping("/myinfo")
	public ModelAndView myInfo(QueryFactor qf) {
		ModelAndView mv=new ModelAndView();
		// ��ѯ���û���Ϣ
		StuInfo myInfo=stuInfoService.getStuById(qf.getSid());
		// ��ȡ����ѧԺ��Ϣ
		List<Institute> institutes=instituteService.queryAllInstitute();
		// ���û�ѧԺ��Ϊ��ʱ����ȡ����ѧԺ��רҵ��Ϣ
		List<Major> majors=null;
		if(myInfo.getInstitute()!=null) {
			Institute institute=instituteService.getInstituteByDesc(myInfo.getInstitute());
			if(institute!=null) {
				majors=majorService.queryAllMajor(institute.getId());
			}
		}
		// ��ȡ���û���������Ϣ
		// �ܼ�¼��
		Integer totalRecord=goodsInfoService.getTotalBySid(qf);
		// ÿҳ��ʾ7��
		Integer pageSize=7;
		PageModel<GoodsInfo> publish_pageModel=new PageModel<GoodsInfo>(qf.getPageNumber(),pageSize,totalRecord);
		qf.setStartIndex(publish_pageModel.getStartIndex());
		qf.setPageSize(pageSize);
		List<GoodsInfo> list=goodsInfoService.queryAllGoodsBySid(qf);
		publish_pageModel.setData(list);
		// ��ȡ���û���ע����Ϣ
		// �ܼ�¼��
		Integer followTotal=followService.getTotal(qf.getSid());
		PageModel<GoodsInfo> follow_pageModel=new PageModel<GoodsInfo>(qf.getPageNumber(),pageSize,followTotal);
		qf.setStartIndex(follow_pageModel.getStartIndex());
		qf.setPageSize(pageSize);
		list=goodsInfoService.queryFollowGoods(qf);
		follow_pageModel.setData(list);
		// ��ȡ���û��յ��ı�����
		Integer praiseTotal=praiseService.getTotalByToSid(qf.getSid());
		// ÿҳ8��
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
	
	// ���Ƹ�����Ϣ
	@RequestMapping("/editmyinfo.action")
	public String editMyInfo(StuInfo my,MultipartFile picFile,HttpServletRequest request) {
		String old_name=picFile.getOriginalFilename();
		if(old_name!="") {
			String filePath="C:\\Users\\hhhlll\\Pictures\\ͼ��\\1";
			File f=new File(filePath);
			if(!f.exists()) {
				f.mkdir();
			}
			// ԭ�ȵ�ͼƬ�ļ�
			File img=new File(filePath+"/"+my.getPic());
			// ɾ��ԭ�ȵ�ͷ��
			img.delete();
			// ����ͼƬ���ļ�·��
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
		// ���¸�����Ϣ
		stuInfoService.updateStuInfo(my);
		// �ı�session�е�ֵ 
		HttpSession session=request.getSession();
		session.setAttribute("stuInfo", my);
		
		return "redirect:/myinfo.action?sid="+my.getId()+"&pageNumber=1";
	}
	
	// ��ѯ��ӦѧԺ�µ�����רҵ
	@RequestMapping("/getallmajor")
	public @ResponseBody List<Major> queryAllMajor(String desc){
		Institute institute=instituteService.getInstituteByDesc(desc);
		List<Major> list=majorService.queryAllMajor(institute.getId());
		return list;
	}
	
	// ��ѯ�Լ���������Ϣ
	@RequestMapping("/queryPublish")
	public @ResponseBody PageModel<GoodsInfo> queryPublish(QueryFactor qf) {
		// ��ȡ���û���������Ϣ
		// �ܼ�¼��
		Integer totalRecord=goodsInfoService.getTotalBySid(qf);
		// ÿҳ��ʾ7��
	    Integer pageSize=7;
		PageModel<GoodsInfo> publish_pageModel=new PageModel<GoodsInfo>(qf.getPageNumber(),pageSize,totalRecord);
		qf.setStartIndex(publish_pageModel.getStartIndex());
		qf.setPageSize(pageSize);
		List<GoodsInfo> list=goodsInfoService.queryAllGoodsBySid(qf);
		publish_pageModel.setData(list);
		return publish_pageModel;
	}
	// ɾ��������Ϣ
//	@RequestMapping("/deleteGoods")
//	public @ResponseBody Integer deleteGoods(Integer gid) {
//		goodsInfoService.deleteGoodsById(gid);
//		return gid;
//	}
	
	
	// ��ѯ��ע����Ϣ
	@RequestMapping("/queryFollow")
	public @ResponseBody PageModel<GoodsInfo> queryFollow(QueryFactor qf){
		// ��ע�ܼ�¼��
		Integer followTotal=followService.getTotal(qf.getSid());
		// ÿҳ��ʾ7��
	    Integer pageSize=7;
		PageModel<GoodsInfo> follow_pageModel=new PageModel<GoodsInfo>(qf.getPageNumber(),pageSize,followTotal);
		qf.setStartIndex(follow_pageModel.getStartIndex());
		qf.setPageSize(pageSize);
		List<GoodsInfo>list=goodsInfoService.queryFollowGoods(qf);
		follow_pageModel.setData(list);
		return follow_pageModel;
	}
	
	// ��ѯ���û��յ��ı�����
	@RequestMapping("/queryPraise")
	public @ResponseBody PageModel<PraiseVo> queryPraise(QueryFactor qf){
		
		// ��ȡ���û��յ��ı�����
		Integer praiseTotal=praiseService.getTotalByToSid(qf.getSid());
		// ÿҳ8��
		Integer pageSize=8;
		PageModel<PraiseVo> praise_pageModel=new PageModel<PraiseVo>(qf.getPageNumber(),pageSize,praiseTotal);
		qf.setStartIndex(praise_pageModel.getStartIndex());
		qf.setPageSize(pageSize);
		List<PraiseVo> praises=praiseService.queryAllByToSid(qf);
		praise_pageModel.setData(praises);
		return praise_pageModel;
	}
	// �鿴�յ������ŵ�����
	@RequestMapping("/lookUpPraise")
	public @ResponseBody PraiseVo lookUpPraise(Integer id) {
		PraiseVo p=praiseService.queryPraiseById(id);
		return p;
	}
	// ɾ��������
	@RequestMapping("/removePraise")
	public @ResponseBody Integer removePraise(Integer id) {
		praiseService.removePraise(id);
		return id;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
