package bysj.swzl.handler;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import bysj.swzl.constant.MesCode;
import bysj.swzl.pojo.Htuser;
import bysj.swzl.pojo.Message;
import bysj.swzl.service.HtuserService;
import bysj.swzl.utils.CheckCodeUtils;

@Controller
@RequestMapping("/admin")
public class AdminLoginHandler {

	@Autowired
	private HtuserService htuserService;
	
	// ���ɶ�̬ͼƬ��֤��
	@RequestMapping("/checkCode")
	public void checkCode(HttpServletRequest request, HttpServletResponse response) {
		// ����ͼƬ
		Image image=CheckCodeUtils.generateCode();
		HttpSession session=request.getSession();
		// ����֤�����session��
		session.setAttribute("checkCode", CheckCodeUtils.strb.toString());
		try {
			ImageIO.write((BufferedImage)image,"jpg",response.getOutputStream());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// ��¼
	@RequestMapping("/loginAdmin")
	public @ResponseBody Message loginAdmin(Htuser htuser,String code,String rr,HttpSession session) {
		Message ms=new Message();
		String checkCode=(String) session.getAttribute("checkCode");
		Htuser ht;
		if(checkCode.equals(code)) {
			ht=htuserService.getHtuserByUsernameAndPwd(htuser);
			if(ht==null) {
				ms.setCode(MesCode.FAIL);
				ms.setMessage("�˻������벻��ȷ��");
				return ms;
			}else {
				if(ht.getStatus()==0) {
					ms.setCode(MesCode.FAIL);
					ms.setMessage("���ѱ����ã���Ȩ���룡");
					return ms;
				}
			}
		}else {
			ms.setCode(MesCode.FAIL);
			ms.setMessage("��֤�벻��ȷ��");
			return ms;
		}
		session.setAttribute("htuser", htuser);
		session.setAttribute("rr", rr);
		ms.setCode(MesCode.SUCCESS);
		ms.setObj(ht);
		return ms;
	}
	// �����û������û�����
	@RequestMapping("/keepStatus")
	public void keepStatus(HttpServletRequest request,HttpServletResponse response) {
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String rr=request.getParameter("rr");
		if(rr!=null) {
			Cookie cookie=new Cookie("username",username);
			Cookie cookie2=new Cookie("password",password);
			Cookie cookie3=new Cookie("rr",rr);
			cookie.setMaxAge(24*60*60*30);
			cookie2.setMaxAge(24*60*60*30);
			cookie3.setMaxAge(24*60*60*30);
			response.addCookie(cookie);
			response.addCookie(cookie2);
			response.addCookie(cookie3);
		}else {
			Cookie cookie=new Cookie("username",null);
			Cookie cookie2=new Cookie("password",null);
			Cookie cookie3=new Cookie("rr",null);
			cookie.setMaxAge(0);
			cookie2.setMaxAge(0);
			cookie3.setMaxAge(0);
			response.addCookie(cookie);
			response.addCookie(cookie2);
			response.addCookie(cookie3);
		}
		try {
			response.sendRedirect(request.getContextPath()+"/admin/login.jsp");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// ������ҳ��
	@RequestMapping("/toPreIndexAdmin")
	public void toPreIndexAdmin(Integer id,HttpServletRequest request,HttpServletResponse response) {
		HttpSession session=request.getSession();
		String rr=(String)session.getAttribute("rr");
		Htuser htuser=(Htuser)session.getAttribute("htuser");
		String username=htuser.getUsername();
		String password=htuser.getPassword();
		if(rr!=null) {
			Cookie cookie=new Cookie("username",username);
			Cookie cookie2=new Cookie("password",password);
			Cookie cookie3=new Cookie("rr",rr);
			cookie.setMaxAge(24*60*60*30);
			cookie2.setMaxAge(24*60*60*30);
			cookie3.setMaxAge(24*60*60*30);
			response.addCookie(cookie);
			response.addCookie(cookie2);
			response.addCookie(cookie3);
		}
		try {
			request.getRequestDispatcher("/admin/toIndexAdmin.action?id="+id).forward(request, response);
		} catch (ServletException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	@RequestMapping("/toIndexAdmin")
	public ModelAndView toIndexAdmin(Integer id,HttpSession session) {
		ModelAndView mv=new ModelAndView();
		Htuser htuser=htuserService.getHtuserById(id);
		//mv.addObject("htuser", htuser);
		session.setAttribute("htuser", htuser);
		mv.setViewName("admin/pages/index");
		return mv;
	}
	
	// �˳���¼ 
	@RequestMapping("/loginAdminOut")
	public ModelAndView loginAdminOut(HttpSession session) {
		ModelAndView mv=new ModelAndView();
		session.removeAttribute("htuser");
		mv.setViewName("admin/pages/login");
		return mv;
	}
	
	// ������Ϣ
	@RequestMapping("/lookUpAdmin")
	public ModelAndView lookUpAdmin(Integer id) {
		ModelAndView mv=new ModelAndView();
		Htuser htuser=htuserService.getHtuserById(id);
		mv.addObject("htuser", htuser);
		mv.setViewName("admin/pages/adminInfo");
		return mv;
	}
	
	
	// �޸�����
	@RequestMapping("/changePrePwd")
	public ModelAndView changePrePwd() {
		ModelAndView mv=new ModelAndView();
		mv.setViewName("admin/pages/changepwd");
		return mv;
	}
	
	@RequestMapping("/changePwd")
	public @ResponseBody Message changePwd(String old_pwd,String new_pwd,Integer id) {
		Message ms=new Message();
		Htuser htuser=htuserService.getHtuserById(id);
		String pwd=htuser.getPassword();
		if(pwd.equals(old_pwd)) {
			htuser.setPassword(new_pwd);
			htuserService.updateHtuser(htuser);
		}else {
			ms.setCode(MesCode.FAIL);
			ms.setMessage("������ľ���������");
			return ms;
		}
		ms.setCode(MesCode.SUCCESS);
		return ms;
	}
	
	
	
	
	
	
	
}
