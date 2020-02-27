package bysj.swzl.mapper;

import java.util.List;

import bysj.swzl.pojo.LeaMes;
import bysj.swzl.pojo.LeaMesVo;
import bysj.swzl.pojo.PageModel;

public interface LeaMesMapper {

	// 统计总的留言数
	Integer getTotal();
	// 查询所有的留言并分页
	List<LeaMesVo> getAllLeaMes(PageModel<LeaMesVo> pageModel);
	// 添加留言
	void addLeaMes(LeaMes lm);
	// 删除留言
	void removeLeaMes(List<Integer> ids);
	// 获取全部留言
	List<LeaMesVo> queryAllLeaMes();
	
	
}
