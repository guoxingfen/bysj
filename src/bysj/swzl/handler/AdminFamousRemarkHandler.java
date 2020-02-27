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
	
	// 请求名言列表
		@RequestMapping("/famousRemarkManage")
		public ModelAndView famousRemarkManage() {
			ModelAndView mv=new ModelAndView();
			List<FamousRemark> list=famousRemarkService.getAllFamousRemark();
			mv.addObject("famousRemarks", list);
			mv.setViewName("admin/pages/famous-remark-list");
			return mv;
		}
		// 添加名言
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
				// 保存图片的文件路径
				String filePath="C:\\Users\\hhhlll\\Pictures\\图标\\1";
				// 原先的图片文件
				File img=new File(filePath+"/"+fr.getPic());
				// 删除原先的图片
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
				// 有 更新
				famousRemarkService.updateFamousRemark(fr);
			}else {
				// 没有 添加
				famousRemarkService.addFamousRemark(fr);
			}
			ms.setCode(MesCode.SUCCESS);
			return ms;
		}
		// 编辑名言
		@RequestMapping("/editFamousRemark")
		public ModelAndView editFamousRemark(Integer id) {
			ModelAndView mv=new ModelAndView();
			FamousRemark fr=famousRemarkService.getFamousRemarkById(id);
			mv.addObject("famousRemark", fr);
			mv.setViewName("admin/pages/famous-remark-add");
			return mv;
		}
		// 删除名言
		@RequestMapping("/deleteSelectFamousRemark")
		public @ResponseBody Message deleteSelectFamousRemark(String ids) {
			Message ms=new Message();
			if(!"".equals(ids)) {
				String[] idstr=ids.split(":");
				List<Integer> list=new ArrayList<Integer>();
				for(int i=1;i<idstr.length;i++) {
					list.add(Integer.parseInt(idstr[i]));
				}
				// 先删除图片
				for(Integer i:list) {
					FamousRemark fr=famousRemarkService.getFamousRemarkById(i);
					String filePath="C:\\Users\\hhhlll\\Pictures\\图标\\1";
					// 原先的图片文件
					File img=new File(filePath+"/"+fr.getPic());
					// 删除原先的图片
					img.delete();
				}
				famousRemarkService.removeFamousRemarks(list);
				ms.setMessage("删除成功！");
				ms.setCode(MesCode.SUCCESS);
			}else {
				ms.setMessage("删除失败，未选择数据！");
				ms.setCode(MesCode.FAIL);
			}
			return ms;
		}
	
	
	
}
