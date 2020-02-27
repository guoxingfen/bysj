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
	
	// �û���¼
	@RequestMapping("/login")
	public @ResponseBody Message login(StuInfo si,HttpServletRequest request) {
		try {
			// ��������м���
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
	// ��ȡ��֤��
	@RequestMapping("/getCode")
	public @ResponseBody Message getCode(StuInfo si) {
		Message message=new Message();
		// ��ʽ�����ؽ��:��֤��
		String re_code=SendSmsUtils.sendMessage(si.getMphone());
		String[] result=re_code.split(":");
		try {
			//����֤����м���
			byte[] data=DESCoderUtils.encrypt(result[1].getBytes());
			message.setMessage(new String(Base64Utils.encode(data)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return message;
	}
	// �û�ע��
	// code:�û��������֤��
	// encrypt_code:���ܺ���ֻ���֤��
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
				// ����֮ǰ��������м���
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
			mv.setMessage("��֤�벻��ȷ��");
		}
		return mv;
	}
	
	// �ж��û��Ƿ����
	@RequestMapping("/queryStu")
	public @ResponseBody Message queryStu(StuInfo si) {
		Message mes=stuInfoService.queryStu(si);
		return mes;
	}
	
	// �û���������
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
				// ����֮ǰ��������м���
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
			mv.setMessage("��֤�벻��ȷ��");
		}
		return mv;
	}
	
	
}
