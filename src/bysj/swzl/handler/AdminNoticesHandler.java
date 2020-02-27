package bysj.swzl.handler;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import bysj.swzl.constant.MesCode;
import bysj.swzl.pojo.Message;
import bysj.swzl.pojo.NoticeBoard;
import bysj.swzl.service.NoticeBoardService;

@Controller
@RequestMapping("/admin")
public class AdminNoticesHandler {

	@Autowired
	private NoticeBoardService noticeBoardService;
	
	// 请求公告列表
	@RequestMapping("/noticesManage")
	public ModelAndView noticesManage() {
		ModelAndView mv=new ModelAndView();
		List<NoticeBoard> list=noticeBoardService.getAllNoticeBoard();
		mv.addObject("notices", list);
		mv.setViewName("admin/pages/notices-list");
		return mv;
	}
	// 添加公告
	@RequestMapping("/addPreNotices")
	public ModelAndView addPreNotices() {
		ModelAndView mv=new ModelAndView();
		mv.setViewName("admin/pages/notices-add");
		return mv;
	}
	
	@RequestMapping("/addNotices")
	public @ResponseBody Message addNotices(NoticeBoard noticeBoard) {
		Message ms=new Message();
		if(noticeBoard.getId()!=null) {
			// 有 更新
			noticeBoardService.updateNoticeBoard(noticeBoard);
		}else {
			// 没有 添加
			noticeBoard.setCreatetime(new Date());
			noticeBoardService.addNoticeBoard(noticeBoard);
		}
		ms.setCode(MesCode.SUCCESS);
		return ms;
	}
	// 编辑公告
	@RequestMapping("/editNotices")
	public ModelAndView editNotices(Integer id) {
		ModelAndView mv=new ModelAndView();
		NoticeBoard nb=noticeBoardService.getNoticeBoardById(id);
		mv.addObject("noticeBoard", nb);
		mv.setViewName("admin/pages/notices-add");
		return mv;
	}
	// 删除公告
	@RequestMapping("/deleteSelectNotices")
	public @ResponseBody Message deleteSelectNotices(String ids) {
		Message ms=new Message();
		if(!"".equals(ids)) {
			String[] idstr=ids.split(":");
			List<Integer> list=new ArrayList<Integer>();
			for(int i=1;i<idstr.length;i++) {
				list.add(Integer.parseInt(idstr[i]));
			}
			noticeBoardService.removeNoticeBoards(list);
			ms.setMessage("删除成功！");
			ms.setCode(MesCode.SUCCESS);
		}else {
			ms.setMessage("删除失败，未选择数据！");
			ms.setCode(MesCode.FAIL);
		}
		return ms;
	}
	
	
	
}
