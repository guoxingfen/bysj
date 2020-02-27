package bysj.swzl.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import bysj.swzl.constant.MesCode;
import bysj.swzl.pojo.Institute;
import bysj.swzl.pojo.Kind;
import bysj.swzl.pojo.Major;
import bysj.swzl.pojo.Message;
import bysj.swzl.service.InstituteService;
import bysj.swzl.service.KindService;
import bysj.swzl.service.MajorService;

@Controller
@RequestMapping("/admin")
public class AdminDictionaryHandler {

	@Autowired
	private InstituteService instituteService;
	@Autowired
	private MajorService majorService;
	@Autowired
	private KindService kindService;
	
	// ����ѧԺ�б�
	@RequestMapping("/instituteManage")
	public ModelAndView getInstitutes() {
		ModelAndView mv=new ModelAndView();
		List<Institute> list=instituteService.queryAllInstitute();
		mv.addObject("institutes", list);
		mv.setViewName("admin/pages/institute-list");
		return mv;
	}
	// ��ӻ����ѧԺ
	@RequestMapping("/addPreInstitute")
	public ModelAndView addPreInstitute() {
		ModelAndView mv=new ModelAndView();
		mv.setViewName("admin/pages/institute-add");
		return mv;
	}
	@RequestMapping("/addInstitute")
	public @ResponseBody Message addInstitute(Institute institute) {
		Message ms=new Message();
		if(institute.getId()!=null) {
			// �� ����
			instituteService.updateInstitute(institute);
		}else {
			// û�� ���
			instituteService.addInstitute(institute);
		}
		ms.setCode(MesCode.SUCCESS);
		return ms;
	}
	// ɾ��ѧԺ
	@RequestMapping("/deleteSelectInstitute")
	public @ResponseBody Message deleteSelectInstitute(String iids) {
		Message ms=new Message();
		if(!"".equals(iids)) {
			String[] ids=iids.split(":");
			List<Integer> list=new ArrayList<Integer>();
			for(int i=1;i<ids.length;i++) {
				list.add(Integer.parseInt(ids[i]));
			}
			// �ж���ЩѧԺ���Ƿ���רҵ��Ϣ
			boolean flag=true;
			for(Integer id=0;id<list.size();id++) {
				List<Major> mm=majorService.queryAllMajor(list.get(id));
				// ���ѧԺ����רҵ��Ϣ
				if(mm.size()>0) {
					flag=false;
					ms.setCode(MesCode.FAIL);
					ms.setMessage("����ɾ��IDΪ"+list.get(id)+"��ѧԺ�µ�����רҵ��Ϣ��");
					return ms;
				}
			}
			if(flag) {
				instituteService.removeInstitute(list);
				ms.setCode(MesCode.SUCCESS);
				ms.setMessage("ɾ���ɹ���");
			}
		}else {
			ms.setCode(MesCode.FAIL);
			ms.setMessage("ɾ��ʧ�ܣ�δѡ�����ݣ�");
		}
		return ms;
	}
	// �༭ѧԺ
	@RequestMapping("/editInstitute")
	public ModelAndView editInstitute(Integer id) {
		ModelAndView mv=new ModelAndView();
		Institute institute=instituteService.getInstituteById(id);
		mv.addObject("institute", institute);
		mv.setViewName("admin/pages/institute-add");
		return mv;
	}
	
	// ����רҵ�б�
	@RequestMapping("/majorManage")
	public ModelAndView getMajors() {
		ModelAndView mv=new ModelAndView();
		List<Major> list=majorService.getAllMajor();
		mv.addObject("majors", list);
		mv.setViewName("admin/pages/major-list");
		return mv;
	}
	// ���רҵ
	@RequestMapping("/addPreMajor")
	public ModelAndView addPreMajor(Integer id) {
		ModelAndView mv=new ModelAndView();
		if(id!=null) {
			Major m=majorService.getMajorById(id);
			mv.addObject("major", m);
		}
		
		List<Institute> list=instituteService.queryAllInstitute();
		mv.addObject("institutes", list);
		mv.setViewName("admin/pages/major-add");
		return mv;
	}
	@RequestMapping("/addMajor")
	public @ResponseBody Message addMajor(Major major) {
		Message ms=new Message();
		if(major.getId()!=null) {
			majorService.updateMajor(major);
		}else {
			majorService.addMajor(major);
		}
		ms.setCode(MesCode.SUCCESS);
		return ms;
	}
	
	// ɾ��רҵ
	@RequestMapping("/deleteSelectMajor")
	public @ResponseBody Message deleteSelectMajor(String ids) {
		Message ms=new Message();
		if(!"".equals(ids)) {
			String[] idstr=ids.split(":");
			List<Integer> list=new ArrayList<Integer>();
			for(int i=1;i<idstr.length;i++) {
				list.add(Integer.parseInt(idstr[i]));
			}
			majorService.removeMajors(list);
			ms.setMessage("ɾ���ɹ���");
			ms.setCode(MesCode.SUCCESS);
		}else {
			ms.setMessage("ɾ��ʧ�ܣ�δѡ�����ݣ�");
			ms.setCode(MesCode.FAIL);
		}
		
		return ms;
	}
	
	// ������Ʒ����
	@RequestMapping("/kindsManage")
	public ModelAndView getKinds() {
		ModelAndView mv=new ModelAndView();
		List<Kind> list=kindService.getAllKind();
		mv.addObject("kinds", list);
		mv.setViewName("admin/pages/kinds-list");
		return mv;
	}
	// �����Ʒ����
	@RequestMapping("/addPreKinds")
	public ModelAndView addPreKinds() {
		ModelAndView mv=new ModelAndView();
		mv.setViewName("admin/pages/kinds-add");
		return mv;
	}
	@RequestMapping("/addKinds")
	public @ResponseBody Message addKinds(Kind kind) {
		Message ms=new Message();
		if(kind.getId()!=null) {
			// �� ����
			kindService.updateKind(kind);
		}else {
			// û�� ���
			kindService.addKind(kind);
		}
		ms.setCode(MesCode.SUCCESS);
		return ms;
	}
	// �༭��Ʒ����
	@RequestMapping("/editKinds")
	public ModelAndView editKinds(Integer id) {
		ModelAndView mv=new ModelAndView();
		Kind kind=kindService.getKindById(id);
		mv.addObject("kind", kind);
		mv.setViewName("admin/pages/kinds-add");
		return mv;
	}
	// ɾ����Ʒ����
	@RequestMapping("/deleteSelectKinds")
	public @ResponseBody Message deleteSelectKinds(String ids) {
		Message ms=new Message();
		if(!"".equals(ids)) {
			String[] idstr=ids.split(":");
			List<Integer> list=new ArrayList<Integer>();
			for(int i=1;i<idstr.length;i++) {
				list.add(Integer.parseInt(idstr[i]));
			}
			kindService.removeKind(list);
			ms.setMessage("ɾ���ɹ���");
			ms.setCode(MesCode.SUCCESS);
		}else {
			ms.setMessage("ɾ��ʧ�ܣ�δѡ�����ݣ�");
			ms.setCode(MesCode.FAIL);
		}
		return ms;
	}
	
}
