<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>失物招领--统计分析</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/jquery.bxslider.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/echarts.min.js"></script>
<style type="text/css">
a:link,a:visited{text-decoration:none !important}
a:active,a:hover{text-decoration:none !important;cursor:pointer}

</style>
<script type="text/javascript">
$(document).ready(function(){
	
	// 轮播图
	$("#slider1").bxSlider({
		minSlides:1,
		maxSlides:1,
		auto:true,
		infiniteLoop:true,
		pager:false
	})
	$("#slider2").bxSlider({
		pause:6000,
		minSlides:1,
		maxSlides:1,
		auto:true,
		infiniteLoop:true,
		pager:false
	})
	
	// 进行初始化
	// 获取'最容易'的信息
	// 参数：名称列表、数量列表
	function getEasy(nameList,valueList){
		var str='';
		var max=Math.max.apply(null, valueList);
		var txt=new Array();
		$.each(valueList,function(key,value){
			if(value==max){
				txt.push(nameList[key]);
			}
		})
		$.each(txt,function(key,value){
			if(key!=txt.length-1){
				str+=value+'、';
			}else{
				str+=value;
			}
		})
		return str;
	}
	// 物品种类信息list
	var kindStatistics=JSON.parse('${kindStatistics}');
	var kdesc=new Array();
	var kdata=new Array();
	$.each(kindStatistics,function(key,value){
		kdesc.push(value.desc);
		kdata.push(value.total);
	})
	// 设置最容易丢失的物品：
	$("#goods").html(getEasy(kdesc,kdata));
	// 柱状图
	var myChart=echarts.init($("#main").get(0));
	  var option1={
			  title:{
				  text:'丢失物品的种类分析',
				  x:'center',
				  textStyle:{
					  color:'#61c488'
				  }
			  },
			  toolbox: { //可视化的工具箱
	                show: true,
	                orient:'vertical',
	                showTitle:false,
	                feature: {
	                    restore: { //重置
	                        show: true
	                    },
	                    dataZoom: { //数据缩放视图
	                        show: true
	                    },
	                    saveAsImage: {//保存图片
	                        show: true
	                    },
	                    magicType: {//动态类型切换
	                        type: ['bar', 'line']
	                    }
	                }
	            },
			  tooltip:{
				  show:true
			  },
			  xAxis:{
				  data:kdesc,
				  axisLabel:{
					  interval:0,
					  rotate:-30,
				  }
			  },
			  yAxis:{
				  name:'次数'
			  },
			  series:[{
				  name:'数量',
				  type:'bar',
				  data:kdata,
				  itemStyle:{
					  normal:{
						  label:{
							  show:true,
							  position:'top',
							  textStyle:{
								  color:'black',
								  fontSize:16
							  }
						  },
						  color:function(params){
							  var colorList=['rgb(253,120,126)',
								             'rgb(253,120,195)',
								             'rgb(251,120,253)',
								             'rgb(120,123,253)',
								             'rgb(120,183,253)',
								             'rgb(120,245,253)',
								             'rgb(120,253,161)',
								             'rgb(186,120,253)'];
							  return colorList[params.dataIndex];
						  }
					  }
				  }
			  }]
	  };
	myChart.setOption(option1);
	// 地点统计信息列表
	var addressStatistics=JSON.parse('${addressStatistics}');
	var addressData=new Array();
	var addressLegend=new Array();
	var addressTotal=new Array();
	$.each(addressStatistics,function(key,value){
		var temp=new Object();
		temp.value=value.total;
		temp.name=value.address;
		addressLegend.push(value.address);
		addressTotal.push(value.total);
		addressData.push(temp);
	})
	// 设置最容易丢失的物品：
	$("#address").html(getEasy(addressLegend,addressTotal));
	// 饼图
	var ss=echarts.init($("#ss").get(0));
	  ss.setOption({
		  title:{
			  text:'丢失物品的地点分析',
			  x:'center',
			  textStyle:{
				  color:'#e78536'
			   }
			  },
		 tooltip : {
			   trigger: 'item',
			   formatter: "{a} <br/>{b} : {c} ({d}%)"
			 },
		  legend: {
			  orient: 'vertical',
			  left: 'right',
			  itemWidth:30,
              itemHeight:15,
			  data: addressLegend
			    },
		  series:[
			  {
				  name:'地点',
				  type:"pie",
				  radius:'55%',
				  center: ['50%', '60%'],
				  data:addressData,
				  label:{
					  normal:{
						  show:true,
						  textStyle:{
							  fontWeight:300,
							  fontSize:16
						  }
					  }
				  },
				  itemStyle: {
		                emphasis: {
		                    shadowBlur: 10,
		                    shadowOffsetX: 0,
		                    shadowColor: 'rgba(0, 0, 0, 0.8)'
		                }
		            }
			  }
		  ]
	  })
	// 时间段信息列表
	var timeStatistics=JSON.parse('${timeStatitics}');
	var timeData=new Array();
	var timeHour=new Array();
	var timeTotal=new Array();
	$.each(timeStatistics,function(key,value){
	    var tempTime=new Array();
		tempTime.push(value.hour);
		tempTime.push(value.total);
		timeData.push(tempTime);
		timeHour.push(value.hour);
		timeTotal.push(value.total);
	})
   	$("#time").html(getEasy(timeHour,timeTotal)+"点");
	// 拆线图
	var option2 = {
		title:{
	    	text:'丢失物品时间点分析',
	    	 x:'center',
	    	 textStyle:{
				  color:'#d9e279'
			  }
	    },
	    toolbox: { //可视化的工具箱
            show: true,
            orient:'vertical',
            showTitle:false,
            feature: {
                restore: { //重置
                    show: true
                },
                dataZoom: { //数据缩放视图
                    show: true
                },
                saveAsImage: {//保存图片
                    show: true
                },
                magicType: {//动态类型切换
                    type: ['bar', 'line']
                }
            }
        },
	    xAxis: {
	    	name:'时间/点'
	    },
	    yAxis: {
	    	name:'次数'
	    },
	    series: [{
	        data:timeData,
	        type: 'line',
	        label:{
				  normal:{
					  show:true,
					  textStyle:{
						  fontWeight:300,
						  fontSize:14,
						  color:'black'
					  }
				  }
			  }
	    }],
	    lineStyle:{
	    	color:'#00FF00'
	    }
	    
	};
	var s=echarts.init($("#s").get(0));
	s.setOption(option2);
	
	$("#refresh").click(function(){
		myChart.showLoading();
		ss.showLoading();
		s.showLoading();
		$.post('${pageContext.request.contextPath}/toRefresh.action',
				null,
				function(data){
			var kindStatistics=data.kindStatistics;
			var kdesc=new Array();
			var kdata=new Array();
			$.each(kindStatistics,function(key,value){
				kdesc.push(value.desc);
				kdata.push(value.total);
			})
			// 设置最容易丢失的物品：
			$("#goods").html(getEasy(kdesc,kdata));
		    myChart.hideLoading();
			myChart.setOption({
				title:{
					  text:'丢失物品的种类分析',
					  x:'center',
					  textStyle:{
						  color:'#61c488'
					  }
				  },
				  toolbox: { //可视化的工具箱
		                show: true,
		                orient:'vertical',
		                showTitle:false,
		                feature: {
		                    restore: { //重置
		                        show: true
		                    },
		                    dataZoom: { //数据缩放视图
		                        show: true
		                    },
		                    saveAsImage: {//保存图片
		                        show: true
		                    },
		                    magicType: {//动态类型切换
		                        type: ['bar', 'line']
		                    }
		                }
		            },
				  tooltip:{
					  show:true
				  },
				  xAxis:{
					  data:kdesc
				  },
				  yAxis:{
					  name:'次数'
				  },
				  series:[{
					  name:'数量',
					  type:'bar',
					  data:kdata,
					  itemStyle:{
						  normal:{
							  label:{
								  show:true,
								  position:'top',
								  textStyle:{
									  color:'black',
									  fontSize:16
								  }
							  },
							  color:function(params){
								  var colorList=['rgb(253,120,126)',
									             'rgb(253,120,195)',
									             'rgb(251,120,253)',
									             'rgb(120,123,253)',
									             'rgb(120,183,253)',
									             'rgb(120,245,253)',
									             'rgb(120,253,161)',
									             'rgb(186,120,253)'];
								  return colorList[params.dataIndex];
							  }
						  }
					  }
				  }]
			});
			var addressStatistics=data.addressStatistics;
			var addressData=new Array();
			var addressLegend=new Array();
			var addressTotal=new Array();
			$.each(addressStatistics,function(key,value){
				var temp=new Object();
				temp.value=value.total;
				temp.name=value.address;
				addressLegend.push(value.address);
				addressTotal.push(value.total);
				addressData.push(temp);
			})
			// 设置最容易丢失的物品：
			$("#address").html(getEasy(addressLegend,addressTotal));
			ss.hideLoading();
			ss.setOption({
				title:{
					  text:'丢失物品的地点分析',
					  x:'center',
					  textStyle:{
						  color:'#e78536'
					   }
					  },
				 tooltip : {
					   trigger: 'item',
					   formatter: "{a} <br/>{b} : {c} ({d}%)"
					 },
				  legend: {
					  orient: 'vertical',
					  left: 'right',
					  itemWidth:30,
		              itemHeight:15,
					  data: addressLegend
					    },
				  series:[
					  {
						  name:'地点',
						  type:"pie",
						  radius:'55%',
						  center: ['50%', '60%'],
						  data:addressData,
						  label:{
							  normal:{
								  show:true,
								  textStyle:{
									  fontWeight:300,
									  fontSize:16
								  }
							  }
						  },
						  itemStyle: {
				                emphasis: {
				                    shadowBlur: 10,
				                    shadowOffsetX: 0,
				                    shadowColor: 'rgba(0, 0, 0, 0.8)'
				                }
				            }
					  }
				  ]
			});
			var timeStatistics=data.timeStatistics;
			var timeData=new Array();
			var timeHour=new Array();
			var timeTotal=new Array();
			$.each(timeStatistics,function(key,value){
			    var tempTime=new Array();
				tempTime.push(value.hour);
				tempTime.push(value.total);
				timeData.push(tempTime);
				timeHour.push(value.hour);
				timeTotal.push(value.total);
			})
		   	$("#time").html(getEasy(timeHour,timeTotal)+"点");
			s.hideLoading();
			s.setOption({
				title:{
			    	text:'丢失物品时间点分析',
			    	 x:'center',
			    	 textStyle:{
						  color:'#d9e279'
					  }
			    },
			    toolbox: { //可视化的工具箱
		            show: true,
		            orient:'vertical',
		            showTitle:false,
		            feature: {
		                restore: { //重置
		                    show: true
		                },
		                dataZoom: { //数据缩放视图
		                    show: true
		                },
		                saveAsImage: {//保存图片
		                    show: true
		                },
		                magicType: {//动态类型切换
		                    type: ['bar', 'line']
		                }
		            }
		        },
			    xAxis: {
			    	name:'时间/点'
			    },
			    yAxis: {
			    	name:'次数'
			    },
			    series: [{
			        data:timeData,
			        type: 'line',
			        label:{
						  normal:{
							  show:true,
							  textStyle:{
								  fontWeight:300,
								  fontSize:14,
								  color:'black'
							  }
						  }
					  }
			    }],
			    lineStyle:{
			    	color:'#00FF00'
			    }
			}); 
		})
	})
	
	
	
	
})

</script>
</head>
<body style="margin-top:65px;">
  <jsp:include page="header.jsp"/>
   <div class="container-fluid">
     <div class="row">
       <div class="col-md-3">
         <div class="panel panel-info" style="background-color:#f2fdd2;">
		  <div class="panel-heading">
		    <h3 class="panel-title">温馨提醒</h3>
		  </div>
		  <div class="panel-body">
		    <p><strong>亲爱的用户：</strong></p>
		    <p style="text-indent:2em;">您好！此模块是为了让您减少丢失物品而设计的。
		    本网站通过对站内物品信息的数据进行统计分析，并以图形的方式展示，让您一目了然，
		    最后我们特别提醒您要<span style="color:red;">“守护好心爱之物”</span>。</p>
		    <h5 style="float:right;"><em>你可爱的管理员</em></h5>
		  </div>
		 </div>
		 <ul id="slider1">
		   <li><img src="${pageContext.request.contextPath }/images/mj1.jpg" style="width:100%;height:260px;" title="请不要遗失东西！！！"/></li>
		   <li><img src="${pageContext.request.contextPath }/images/mj2.jpg" style="width:100%;height:260px;" title="今天没丢失东西吧！！！"/></li>
		   <li><img src="${pageContext.request.contextPath }/images/mj3.jpg" style="width:100%;height:260px;" title="每天好心情！！！"/></li>
		 </ul>
       </div>
       <div class="col-md-6">
         <div class="panel panel-warning">
		  <div class="panel-heading">
		    <h3 class="panel-title">数据分析<a>
		    <span class="glyphicon glyphicon-refresh" id="refresh" aria-hidden="true" style="float:right;"
		    title="刷新"></span>
		    </a></h3>
		  </div>
		  <div class="panel-body">
		    <ul class="nav nav-pills" role="tablist">
			  <li role="presentation" class="active"><a href="#home" aria-controls="home"
			  data-toggle="tab">种类分析</a></li>
			  <li role="presentation"><a href="#profile" aria-controls="profile"
			  data-toggle="tab">地点分析</a></li>
			  <li role="presentation"><a href="#messages" aria-controls="messages"
			  data-toggle="tab">时间分析</a></li>
			</ul>
		    <div class="tab-content">
			   <div role="tabpanel" class="tab-pane active" id="home">
			     <div id="main" style="width:650px;height:395px;margin-top:30px;margin-left:-20px;"></div>
			   </div>
			   <div role="tabpanel" class="tab-pane" id="profile">
			     <div id="ss" style="width:650px;height:395px;margin-top:30px;margin-left:-20px;"></div>
			   </div>
			   <div role="tabpanel" class="tab-pane" id="messages">
			     <div id="s" style="width:650px;height:395px;margin-top:30px;margin-left:-20px;"></div>
			   </div>
			</div>
		  </div>
		 </div>
       </div>
       <div class="col-md-3">
         <div class="panel panel-success" style="background-color:#fefacd">
		  <div class="panel-heading">
		    <h3 class="panel-title">结果展示</h3>
		  </div>
		  <div class="panel-body" style="padding-left:0px;padding-right:0px;padding-bottom:0px;">
		    <ul class="list-group">
			  <li class="list-group-item" style="background-color:#b9ffcb;color:#ea3c96;border-top-left-radius:0px;border-top-right-radius:0px;">
			    <h4>最容易遗失的物品：<strong id="goods"></strong></h4>
			  </li>
			  <li class="list-group-item" style="background-color:#b9ffcb;color:#ea3c96">
			    <h4>最容易遗失物品的地方：<strong id="address"></strong></h4>
			  </li>
			  <li class="list-group-item" style="background-color:#b9ffcb;color:#ea3c96;border-bottom-left-radius:0px;border-bottom-right-radius:0px;">
			    <h4>最容易遗失物品的时间点：<strong id="time"></strong></h4>
			  </li>
			</ul>
		  </div>
		 </div>
		 <ul id="slider2">
		   <li><img src="${pageContext.request.contextPath }/images/gl1.gif" title="注意保管自己的物品！！！" style="height:249px;width:100%;"/></li>
		   <li><img src="${pageContext.request.contextPath }/images/gl2.jpg" title="每天都得快乐！！！" style="height:249px;width:100%;"/></li>
		   <li><img src="${pageContext.request.contextPath }/images/gl3.jpg" title="心情好，人也漂亮！！！" style="height:249px;width:100%;"/></li>
		 </ul>
       </div>
     </div>
   </div>
  <jsp:include page="footer.jsp"/>
</body>
</html>