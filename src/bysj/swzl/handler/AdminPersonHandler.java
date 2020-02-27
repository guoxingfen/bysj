package bysj.swzl.handler;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import bysj.swzl.constant.MesCode;
import bysj.swzl.pojo.Htuser;
import bysj.swzl.pojo.Message;
import bysj.swzl.pojo.StuInfo;
import bysj.swzl.service.HtuserService;
import bysj.swzl.service.StuInfoService;

@Controller
@RequestMapping("/admin")
public class AdminPersonHandler {

	@Autowired
	private StuInfoService stuInfoService;
	@Autowired
	private HtuserService htuserService;
	
	// 请求用户列表
	@RequestMapping("/userManage")
	public ModelAndView userManage() {
		ModelAndView mv=new ModelAndView();
		List<StuInfo> list=stuInfoService.getAllStuInfo();
		mv.addObject("stuInfoes", list);
		mv.setViewName("admin/pages/user-list");
		return mv;
	}
	// 改变用户的状态
	@RequestMapping("/changeuserStatus")
	public @ResponseBody Message changeUserStatus(String ids,Integer status) {
		Message ms=new Message();
		if(!"".equals(ids)) {
			String[] idstr=ids.split(":");
			List<Integer> list=new ArrayList<Integer>();
			for(int i=1;i<idstr.length;i++) {
				list.add(Integer.parseInt(idstr[i]));
			}
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("ids", list);
			map.put("status", status);
			stuInfoService.changeStuStatus(map);
			ms.setCode(MesCode.SUCCESS);
		}else {
			ms.setCode(MesCode.FAIL);
		}
		return ms;
	}
	
	// 请求管理员列表
	@RequestMapping("/adminManage")
	public ModelAndView adminManage() {
		ModelAndView mv=new ModelAndView();
		List<Htuser> list=htuserService.getAllHtuser();
		mv.addObject("htusers", list);
		mv.setViewName("admin/pages/admin-list");
		return mv;
	}
	
	// 改变管理员的状态
	@RequestMapping("/changeAdminStatus")
	public @ResponseBody Message changeAdminStatus(String ids,Integer status) {
		Message ms=new Message();
		if(!"".equals(ids)) {
			String[] idstr=ids.split(":");
			List<Integer> list=new ArrayList<Integer>();
			for(int i=1;i<idstr.length;i++) {
				list.add(Integer.parseInt(idstr[i]));
			}
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("ids", list);
			map.put("status", status);
			htuserService.changeStatus(map);
			ms.setCode(MesCode.SUCCESS);
		}else {
			ms.setCode(MesCode.FAIL);
		}
		return ms;
	}
	
	// 删除管理员
	@RequestMapping("/deleteSelectAdmin")
	public @ResponseBody Message deleteSelectAdmin(String ids) {
		Message ms=new Message();
		if(!"".equals(ids)) {
			String[] idstr=ids.split(":");
			List<Integer> list=new ArrayList<Integer>();
			for(int i=1;i<idstr.length;i++) {
				list.add(Integer.parseInt(idstr[i]));
			}
			htuserService.removeHtusers(list);
			ms.setMessage("删除成功！");
			ms.setCode(MesCode.SUCCESS);
		}else {
			ms.setMessage("删除失败，未选择数据！");
			ms.setCode(MesCode.FAIL);
		}
		return ms;
	}
	
	// 添加管理员 addAdmin
	@RequestMapping("/addPreAdmin")
	public ModelAndView addPreAdmin() {
		ModelAndView mv=new ModelAndView();
		mv.setViewName("admin/pages/admin-add");
		return mv;
	}
	
	
	@RequestMapping("/addAdmin")
	public String addAdmin(Htuser htuser) {
		htuser.setJointime(new Date());
		htuserService.addHtuser(htuser);
		return "forward:/admin/adminManage.action";
	}
	
	
	
	
	
	
	
	
	
}
