package bysj.swzl.test;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.google.gson.Gson;

import bysj.swzl.constant.GoodsType;
import bysj.swzl.mapper.AdminGoodsMapper;
import bysj.swzl.mapper.GoodsInfoMapper;
import bysj.swzl.mapper.NoticeBoardMapper;
import bysj.swzl.mapper.ReportMapper;
import bysj.swzl.mapper.StatisticsMapper;
import bysj.swzl.mapper.StuInfoMapper;
import bysj.swzl.pojo.AddressStatistics;
import bysj.swzl.pojo.AdminGoodsInfo;
import bysj.swzl.pojo.GoodsInfo;
import bysj.swzl.pojo.GoodsInfoVo;
import bysj.swzl.pojo.KindStatistics;
import bysj.swzl.pojo.NoticeBoard;
import bysj.swzl.pojo.QueryFactor;
import bysj.swzl.pojo.Report;
import bysj.swzl.pojo.StuInfo;
import bysj.swzl.pojo.TimeStatistics;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/applicationContext.xml")
public class MybatisTest {

	@Resource(name="stuInfoMapper")
	private StuInfoMapper stuInfoMapper;
	@Resource(name="goodsInfoMapper")
	private GoodsInfoMapper goodsInfoMapper;
	@Resource(name="noticeBoardMapper")
	private NoticeBoardMapper noticeBoardMapper;
	@Resource(name="reportMapper")
	private ReportMapper reportMapper;
	@Resource(name="statisticsMapper")
	private StatisticsMapper statisticsMapper;
	@Resource(name="adminGoodsMapper")
	private AdminGoodsMapper adminGoodsMapper;
	
	
	@Test
	public void stuInfoTest() {
		StuInfo si=stuInfoMapper.getStuInfoById(12);
		System.out.println(si);
	}
	@Test
	public void goodsInfoTest() {
		GoodsInfo gi=new GoodsInfo();
		gi.setAddress("雷州");
		gi.setContact_address("东莞");
		gi.setDate(new Date());
		gi.setKid(2);
		gi.setTitle("一个红色的钱包");
		gi.setDetail("我掉了一个红色的钱包");
		gi.setSid(1);
		goodsInfoMapper.insertGoodsInfo(gi);
		System.out.println(gi);
	}
	
	@Test
	public void date() throws ParseException {
		SimpleDateFormat sdf=new SimpleDateFormat();
		sdf.applyPattern("yyyy-MM-dd'T'HH:mm");
		Date d=sdf.parse("2015-09-24T13:59");
		System.out.println(d);
	}
	
	@Test
	public void dateConvert() throws ParseException {
		String text = "Fri Apr 24 19:00:58 CST 2015";  
		DateFormat formate1 = new SimpleDateFormat("yyyy-MM-dd");  
		DateFormat formate2 = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",Locale.ENGLISH);  
		Date date = formate2.parse(text);  
		String dateString = formate1.format(date);  
		System.out.println(dateString);  
	}
	
	@Test
	public void testNoticeBoard() {
		NoticeBoard nb=new NoticeBoard();
		nb.setTitle("网站即将上线！！！！");
		nb.setDetail("再依序到Request、Session、Application范围。假如途中找到username，就直接回传，不再继续找下去，\r\n" + 
				"\r\n" + 
				"但是假如全部的范围都没有找到时，就回传null，当然EL表达式还会做出优化，页面上显示空白，而不是打印输出NULL。");
		noticeBoardMapper.addNoticeBoard(nb);
	}
	
	@Test
	public void testReport() {
		Report rr=new Report();
		rr.setSid(1);
		rr.setGid(12);
		Report r=reportMapper.getReportBySidAndGid(rr);
		System.out.println(r);
	}
	
	// 分页测试
	@Test
	public void testSql() {
		QueryFactor qf=new QueryFactor();
		qf.setSid(1);
		qf.setPageSize(2);
		qf.setStartIndex(1);
		qf.setGet("Get_Goods");
		qf.setLost("Lost_Goods");
		qf.setSort(0);
		List<GoodsInfo> list=goodsInfoMapper.queryGoodsBySid(qf);
		System.out.println(list.size());
		int count=goodsInfoMapper.getTotalBySid(qf);
		System.out.println("count:"+count);
	}
	
	@Test
	public void testFollow() {
		QueryFactor qf=new QueryFactor();
		qf.setSid(1);
		qf.setPageSize(9);
		qf.setStartIndex(0);
		List<GoodsInfo> list=goodsInfoMapper.queryFollowGoods(qf);
		System.out.println("follow:"+list.size());
	}
	
	@Test
	public void testGoodsInfoVo() {
		GoodsInfoVo gi=goodsInfoMapper.getGoodsById(13);
		System.out.println(gi.getKdesc());
	}
	
	@Test
	public void testDate() {
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
		Date d=new Date();
		Calendar rightNow=Calendar.getInstance();
		rightNow.setTime(d);
		rightNow.add(Calendar.DAY_OF_YEAR, -30);
		String s=sf.format(rightNow.getTime());
		System.out.println(s);
	}
	
	@Test
	public void testStatistics() {
		List<KindStatistics> list=statisticsMapper.statisticsKind();
		List<AddressStatistics> l=statisticsMapper.statisticsAddress();
		List<TimeStatistics> timeStatistics=statisticsMapper.statisticsTime();
//		for(KindStatistics k:list) {
//			System.out.println(k.getDesc()+":"+k.getTotal());
//		}
		Gson gson=new Gson();
		System.out.println(gson.toJson(timeStatistics));
	}
	
	@Test
	public void testAdminGoods() {
		List<AdminGoodsInfo> list=adminGoodsMapper.getAllGoodsByType(GoodsType.Lost_Goods);
		for(AdminGoodsInfo a:list) {
			System.out.println(a);
		}
	}
	
	
	
}
