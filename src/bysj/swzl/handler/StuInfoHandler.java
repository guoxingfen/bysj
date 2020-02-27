package bysj.swzl.handler;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import bysj.swzl.constant.MesCode;
import bysj.swzl.pojo.Message;
import bysj.swzl.pojo.StuInfo;
import bysj.swzl.service.StuInfoService;
import bysj.swzl.utils.DESCoderUtils;
import bysj.swzl.utils.SendSmsUtils;

@Controller
public class StuInfoHandler {

	@Autowired
	private StuInfoService stuInfoService;
	
	// 用户登录
	@RequestMapping("/login")
	public @ResponseBody Message login(StuInfo si,HttpServletRequest request) {
		try {
			// 对密码进行加密
			String pwd=si.getPassword();
			byte[] encrypt_pwd=DESCoderUtils.encrypt(pwd.getBytes());
			si.setPassword(new String(Base64Utils.encode(encrypt_pwd)));
		} catch (Exception e) {
			e.printStackTrace();
		}
	    Message mes=stuInfoService.login(si);
	    if("SUCCESS".equals(mes.getCode().toString())) {
	    	HttpSession session=request.getSession();
	    	session.setAttribute("stuInfo", mes.getObj());
	    }
	    return mes;
	}
	// 获取验证码
	@RequestMapping("/getCode")
	public @ResponseBody Message getCode(StuInfo si) {
		Message message=new Message();
		// 格式：返回结果:验证码
		String re_code=SendSmsUtils.sendMessage(si.getMphone());
		String[] result=re_code.split(":");
		try {
			//对验证码进行加密
			byte[] data=DESCoderUtils.encrypt(result[1].getBytes());
			message.setMessage(new String(Base64Utils.encode(data)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return message;
	}
	// 用户注册
	// code:用户输入的验证码
	// encrypt_code:加密后的手机验证码
	@RequestMapping("/register")
	public @ResponseBody Message register(StuInfo si,String code,String encrypt_code,HttpServletRequest request) {
		Message mv=new Message();
		String real_code=null;
		try {
			byte[] decrypt_code=DESCoderUtils.decrypt(Base64Utils.decode(encrypt_code.getBytes()));
			real_code=new String(decrypt_code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(code.equals(real_code)) {
			try {
				// 保存之前对密码进行加密
				String pwd=si.getPassword();
				byte[] encrypt_pwd;
				encrypt_pwd = DESCoderUtils.encrypt(pwd.getBytes());
				si.setPassword(new String(Base64Utils.encode(encrypt_pwd)));
			} catch (Exception e) {
				e.printStackTrace();
			}
			si.setUname(si.getMphone());
			mv=stuInfoService.register(si);
		    mv.setCode(MesCode.SUCCESS);
		    HttpSession session=request.getSession();
		    session.setAttribute("stuInfo", mv.getObj());
		}else {
			mv.setCode(MesCode.FAIL);
			mv.setMessage("验证码不正确！");
		}
		return mv;
	}
	
	// 判断用户是否存在
	@RequestMapping("/queryStu")
	public @ResponseBody Message queryStu(StuInfo si) {
		Message mes=stuInfoService.queryStu(si);
		return mes;
	}
	
	// 用户重置密码
	@RequestMapping("/resetpwd")
	public @ResponseBody Message resetPwd(StuInfo si,String code,String encrypt_code,HttpServletRequest request) {
		Message mv=new Message();
		String real_code=null;
		try {
			byte[] decrypt_code=DESCoderUtils.decrypt(Base64Utils.decode(encrypt_code.getBytes()));
			real_code=new String(decrypt_code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(code.equals(real_code)) {
			try {
				// 保存之前对密码进行加密
				byte[] encrypt_pwd;
				String pwd=si.getPassword();
				encrypt_pwd = DESCoderUtils.encrypt(pwd.getBytes());
				si.setPassword(new String(Base64Utils.encode(encrypt_pwd)));
			} catch (Exception e) {
				e.printStackTrace();
			}
			mv=stuInfoService.resetPwd(si);
		    mv.setCode(MesCode.SUCCESS);
		    HttpSession session=request.getSession();
		    session.setAttribute("stuInfo", mv.getObj());
		}else {
			mv.setCode(MesCode.FAIL);
			mv.setMessage("验证码不正确！");
		}
		return mv;
	}
	
	
}
