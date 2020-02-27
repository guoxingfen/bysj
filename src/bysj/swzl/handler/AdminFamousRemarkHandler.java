package bysj.swzl.handler;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import bysj.swzl.constant.MesCode;
import bysj.swzl.pojo.FamousRemark;
import bysj.swzl.pojo.Message;
import bysj.swzl.service.FamousRemarkService;

@Controller
@RequestMapping("/admin")
public class AdminFamousRemarkHandler {

	@Autowired
	private FamousRemarkService famousRemarkService;
	
	// ���������б�
		@RequestMapping("/famousRemarkManage")
		public ModelAndView famousRemarkManage() {
			ModelAndView mv=new ModelAndView();
			List<FamousRemark> list=famousRemarkService.getAllFamousRemark();
			mv.addObject("famousRemarks", list);
			mv.setViewName("admin/pages/famous-remark-list");
			return mv;
		}
		// �������
		@RequestMapping("/addPreFamousRemark")
		public ModelAndView addPreFamousRemark() {
			ModelAndView mv=new ModelAndView();
			mv.setViewName("admin/pages/famous-remark-add");
			return mv;
		}
		@RequestMapping("/addFamousRemark")
		public @ResponseBody Message addFamousRemark(FamousRemark fr,MultipartFile picFile) {
			Message ms=new Message();
			if(picFile!=null) {
				String old_name=picFile.getOriginalFilename();
				// ����ͼƬ���ļ�·��
				String filePath="C:\\Users\\hhhlll\\Pictures\\ͼ��\\1";
				// ԭ�ȵ�ͼƬ�ļ�
				File img=new File(filePath+"/"+fr.getPic());
				// ɾ��ԭ�ȵ�ͼƬ
				img.delete();
				String new_name=UUID.randomUUID()+old_name.substring(old_name.lastIndexOf("."));
				File file=new File(filePath+"/"+new_name);
				try {
					picFile.transferTo(file);
					fr.setPic(new_name);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
			fr.setCreatetime(new Date());
			if(fr.getId()!=null) {
				// �� ����
				famousRemarkService.updateFamousRemark(fr);
			}else {
				// û�� ���
				famousRemarkService.addFamousRemark(fr);
			}
			ms.setCode(MesCode.SUCCESS);
			return ms;
		}
		// �༭����
		@RequestMapping("/editFamousRemark")
		public ModelAndView editFamousRemark(Integer id) {
			ModelAndView mv=new ModelAndView();
			FamousRemark fr=famousRemarkService.getFamousRemarkById(id);
			mv.addObject("famousRemark", fr);
			mv.setViewName("admin/pages/famous-remark-add");
			return mv;
		}
		// ɾ������
		@RequestMapping("/deleteSelectFamousRemark")
		public @ResponseBody Message deleteSelectFamousRemark(String ids) {
			Message ms=new Message();
			if(!"".equals(ids)) {
				String[] idstr=ids.split(":");
				List<Integer> list=new ArrayList<Integer>();
				for(int i=1;i<idstr.length;i++) {
					list.add(Integer.parseInt(idstr[i]));
				}
				// ��ɾ��ͼƬ
				for(Integer i:list) {
					FamousRemark fr=famousRemarkService.getFamousRemarkById(i);
					String filePath="C:\\Users\\hhhlll\\Pictures\\ͼ��\\1";
					// ԭ�ȵ�ͼƬ�ļ�
					File img=new File(filePath+"/"+fr.getPic());
					// ɾ��ԭ�ȵ�ͼƬ
					img.delete();
				}
				famousRemarkService.removeFamousRemarks(list);
				ms.setMessage("ɾ���ɹ���");
				ms.setCode(MesCode.SUCCESS);
			}else {
				ms.setMessage("ɾ��ʧ�ܣ�δѡ�����ݣ�");
				ms.setCode(MesCode.FAIL);
			}
			return ms;
		}
	
	
	
}
