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
import bysj.swzl.pojo.LeaMes;
import bysj.swzl.pojo.LeaMesVo;
import bysj.swzl.pojo.Message;
import bysj.swzl.service.LeaMesService;

@Controller
@RequestMapping("/admin")
public class AdminLeaveMessageHandler {

	@Autowired
	private LeaMesService leaMesService;
	
	    // «Î«Û¡Ù—‘¡–±Ì
		@RequestMapping("/leaMesManage")
		public ModelAndView noticesManage() {
			ModelAndView mv=new ModelAndView();
			List<LeaMesVo> list=leaMesService.queryAllLeaMes();
			mv.addObject("leaMesVoes", list);
			mv.setViewName("admin/pages/leave-message-list");
			return mv;
		}
		// ÃÌº”¡Ù—‘
		@RequestMapping("/addPreAdminLeaMes")
		public ModelAndView addPreAdminLeaMes() {
			ModelAndView mv=new ModelAndView();
			mv.setViewName("admin/pages/leave-message-add");
			return mv;
		}
		@RequestMapping("/addAdminLeaMes")
		public @ResponseBody Message addLeaMes(LeaMes lm) {
			Message ms=new Message();
			lm.setDate(new Date());
			leaMesService.addLeaMes(lm);
			ms.setCode(MesCode.SUCCESS);
			return ms;
		}
		
		// …æ≥˝¡Ù—‘
		@RequestMapping("/deleteSelectLeaMes")
		public @ResponseBody Message deleteSelectLeaMes(String ids) {
			Message ms=new Message();
			if(!"".equals(ids)) {
				String[] idstr=ids.split(":");
				List<Integer> list=new ArrayList<Integer>();
				for(int i=1;i<idstr.length;i++) {
					list.add(Integer.parseInt(idstr[i]));
				}
				leaMesService.removeLeaMes(list);
				ms.setMessage("…æ≥˝≥…π¶£°");
				ms.setCode(MesCode.SUCCESS);
			}else {
				ms.setMessage("…æ≥˝ ß∞‹£¨Œ¥—°‘Ò ˝æ›£°");
				ms.setCode(MesCode.FAIL);
			}
			return ms;
		}
	
	
	
	
	
}
