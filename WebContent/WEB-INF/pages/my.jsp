<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>失物招领--个人信息</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<style type="text/css">
a:link,a:visited{text-decoration:none !important}
a:active,a:hover{text-decoration:none !important;cursor:pointer}

</style>
<script type="text/javascript">
// 寻物查询
// 招领查询
// 排序
function queryGoods2(pageNumber){
	// 设置当前页数
	$("div#follow_panel input[type='hidden']").val(pageNumber);
	// 提交表单
	$("#search_form2").submit();
}

$(document).ready(function(){
	// 提交表单
	$("#myinfo_submit").click(function(){
		$("#myinfo_form").submit();
	})
	// 通过学院获取专业
	$("#institute").change(function(){
		var institute_desc=$("#institute").val();
		$.post("${pageContext.request.contextPath}/getallmajor.action",
				{"desc":institute_desc},
				function(data){
					$("#major").empty();
					$.each(data,function(key,value){
						$("#major").append("<option>"+value.desc+"</option>"); 
					})
					$("#major").prepend("<option selected='selected' disabled='disabled'>请选择</option>");
				})
	})
	// 根据不同的查询条件动态改变发布信息
	 function queryGoods1(pageNumber){
		// 查询条件
		var data=new Object();
		if($("#publish_lost").prop("checked")){
			data.lost="Lost_Goods";
		}
		if($("#publish_get").prop("checked")){
			data.get="Get_Goods";
		}
		data.sid='${stuInfo.id}';
		data.pageNumber=pageNumber;
		if($("#asc_sort").prop("checked")){
			data.sort=1;
		}
		if($("#desc_sort").prop("checked")){
			data.sort=0;
		}
		$.post("${pageContext.request.contextPath}/queryPublish.action",
			   data,
			function(data){
			       // 清空表格
				   $("#publish_table").empty();
				   $.each(data.data,function(key,value){
					   var date=dateFormat(value.publish_date);
					   var type=value.type;
					   var type_desc;
					   var id=value.id;
					   if(type=='Lost_Goods'){
						   type_desc="寻物";
					   }else{
						   type_desc="招领";
					   }
					   $("#publish_table").append("<tr><td>"+type_desc+"</td><td>"+value.title+"</td><td>"+
							   date+"</td><td><a href='${pageContext.request.contextPath}/lookUpGoods.action?gid="+id+"&sid=${stuInfo.id}'>"+
							   "查看</a></td></tr>");
				   })
				   // 清空分页
				   $("#publish_nav").empty();
				   // 动态显示分页
				   if(data.totalPage>1){
					   if(data.pageNumber==1){
						   $("#publish_nav").append("<li><a id='publish0' class='btn disabled' aria-label='Previous'>"+
						   "<span aria-hidden='true'>&laquo;</span></a></li>");
					   }else{
						   $("#publish_nav").append("<li><a id='publish0' aria-label='Previous'>"+
						   "<span aria-hidden='true'>&laquo;</span></a></li>");
					   }
					   for(var i=1;i<=data.totalPage;i++){
						   if(data.pageNumber==i){
						      $("#publish_nav").append("<li class='active'><a id='publish"+i+"'>"+i+"<span class='sr-only'>(current)</span></a></li>")
						   }else{
							  $("#publish_nav").append("<li><a id='publish"+i+"'>"+i+"<span class='sr-only'>(current)</span></a></li>")
						   }
					   }
					   if(data.pageNumber==data.totalPage){
						   $("#publish_nav").append("<li><a id='publish"+(data.totalPage+1)+"' class='btn disabled' aria-label='Next'>"+
						   "<span aria-hidden='true'>&raquo;</span></a></li>");
					   }else{
						   $("#publish_nav").append("<li><a id='publish"+(data.totalPage+1)+"' aria-label='Next'>"+
						   "<span aria-hidden='true'>&raquo;</span></a></li>");
					   }
					   // 为列表中a标签添加事件
					   for(var i=0;i<=data.totalPage+1;i++){
						   publishNav(i,data.pageNumber,data.totalPage);
					   }
				   }
			   }) 
	}
	$("#publish_lost").click(function(){
		queryGoods1(1)
	});
	$("#publish_get").click(function(){
		queryGoods1(1)
	});
	$("#asc_sort").click(function(){
		queryGoods1(1)
	});
	$("#desc_sort").click(function(){
		queryGoods1(1)
	});
	// 为初始化的分页列表中a标签添加事件
	var count='${publish_pageModel.totalPage+1}';
	var p='${publish_pageModel.pageNumber}';
	for(var i=0;i<=count;i++){
		publishNav(i,p,count-1);
	   }
	function publishNav(i,pageNumber,totalPage){
		pageNumber=parseInt(pageNumber);
		if(i==0){
			 $("#publish"+i).click(function(){
				   queryGoods1(pageNumber-1);
			 })
		   }else if(i==totalPage+1){
			  $("#publish"+i).click(function(){
				   queryGoods1(pageNumber+1);
			 }) 
			 }else{
			 $("#publish"+i).click(function(){
				   queryGoods1(i);
			 })
		   }
		  
	}
	// 根据不同的查询条件动态改变关注信息
	 function queryGoods2(pageNumber){
		// 查询条件
		var data=new Object();
		if($("#follow_lost").prop("checked")){
			data.lost="Lost_Goods";
		}
		if($("#follow_get").prop("checked")){
			data.get="Get_Goods";
		}
		data.sid='${stuInfo.id}';
		data.pageNumber=pageNumber;
		if($("#fasc_sort").prop("checked")){
			data.sort=1;
		}
		if($("#fdesc_sort").prop("checked")){
			data.sort=0;
		}
		$.post("${pageContext.request.contextPath}/queryFollow.action",
			   data,
			function(data){
			       var pageSize=data.pageSize;
			       var mm=0;
			       if(data.data.length==0){
			    	   $("#follow_mes").append("<h3 style='color:red;text-align:center;margin-top:20px;'>暂无关注</h3>");
			    	   $("#fasc_sort").attr("disabled","disabled");
			    	   $("#fdesc_sort").attr("disabled","disabled");
			       }else{
			    	   $("#follow_mes").empty();
			    	   $("#fasc_sort").removeAttr("disabled");
			    	   $("#fdesc_sort").removeAttr("disabled");
			       }
			       // 清空表格
				   $("#follow_table").empty();
				   $.each(data.data,function(key,value){
					   var len=data.data.length;
					   var date=dateFormat(value.publish_date);
					   var type=value.type;
					   var type_desc;
					   var id=value.id;
					   if(type=='Lost_Goods'){
						   type_desc="寻物";
					   }else{
						   type_desc="招领";
					   }
					   $("#follow_table").append("<tr id='option"+value.id+"'><td>"+type_desc+"</td><td>"+value.title+"</td><td>"+
							   date+"</td><td><a href='${pageContext.request.contextPath}/lookUpGoods.action?gid="+id+"&sid=${stuInfo.id}'>"+
							   "查看</a></td><td><a id='follow_"+value.id+"'>取消关注</a></td></tr>");
					   $("#follow_"+value.id).click(function(){
						   mm=mm+1;
						   $.post('${pageContext.request.contextPath}/removeFollow.action',
									{"sid":'${stuInfo.id}',"gid":value.id},
									function(data){
										$("#option"+data.obj.gid).remove();
										if(len<pageSize&&len==mm){
											queryGoods2(pageNumber-1);
										}
										if(len==pageSize&&len==mm){
											queryGoods2(pageNumber);
										}
									})
					   })
				   })
				   // 清空分页
				   $("#follow_nav").empty();
				   // 动态显示分页
				   if(data.totalPage>1){
					   if(data.pageNumber==1){
						   $("#follow_nav").append("<li><a id='follow0' class='btn disabled' aria-label='Previous'>"+
						   "<span aria-hidden='true'>&laquo;</span></a></li>");
					   }else{
						   $("#follow_nav").append("<li><a id='follow0' aria-label='Previous'>"+
						   "<span aria-hidden='true'>&laquo;</span></a></li>");
					   }
					   for(var i=1;i<=data.totalPage;i++){
						   if(data.pageNumber==i){
						      $("#follow_nav").append("<li class='active'><a id='follow"+i+"'>"+i+"<span class='sr-only'>(current)</span></a></li>")
						   }else{
							  $("#follow_nav").append("<li><a id='follow"+i+"'>"+i+"<span class='sr-only'>(current)</span></a></li>")
						   }
					   }
					   if(data.pageNumber==data.totalPage){
						   $("#follow_nav").append("<li><a id='follow"+(data.totalPage+1)+"' class='btn disabled' aria-label='Next'>"+
						   "<span aria-hidden='true'>&raquo;</span></a></li>");
					   }else{
						   $("#follow_nav").append("<li><a id='follow"+(data.totalPage+1)+"' aria-label='Next'>"+
						   "<span aria-hidden='true'>&raquo;</span></a></li>");
					   }
					   // 为列表中a标签添加事件
					   for(var i=0;i<=data.totalPage+1;i++){
						   followNav(i,data.pageNumber,data.totalPage);
					   }
				   }
			   }) 
	}
	$("#follow_lost").click(function(){
		queryGoods2(1)
	});
	$("#follow_get").click(function(){
		queryGoods2(1)
	});
	$("#fasc_sort").click(function(){
		queryGoods2(1)
	});
	$("#fdesc_sort").click(function(){
		queryGoods2(1)
	});
	// 为初始化表格中的a标签添加事件
	var size='${follow_pageModel.pageSize}';
	var pf='${follow_pageModel.pageNumber}';
	var aa=0;
	var arrayFollow = new Array();
	var follows=JSON.stringify('${follow_pageModel.data}');
	var arr=follows.split('],');
	for(var i=0;i<arr.length;i++){
		var s=arr[i].split(',');
		var ss=s[0].split('=');
		arrayFollow.push(ss[1]);
	}
	var f=arrayFollow.length;
	$.each(arrayFollow,function(key,value){
		$("#follow_"+value).click(function(){
			aa=aa+1;
			$.post('${pageContext.request.contextPath}/removeFollow.action',
					{"sid":'${stuInfo.id}',"gid":value},
					function(data){
						$("#option"+data.obj.gid).remove();
						if(f<size&&aa==f){
							queryGoods2(pf-1);
						}
						if(f==size&&aa==f){
							queryGoods2(pf);
						}
					})
		})
	})
	// 为初始化的分页列表中a标签添加事件
	var count='${follow_pageModel.totalPage+1}';
	var p='${follow_pageModel.pageNumber}';
	for(var i=0;i<=count;i++){
		followNav(i,p,count-1);
	   }
	function followNav(i,pageNumber,totalPage){
		pageNumber=parseInt(pageNumber);
		if(i==0){
			 $("#follow"+i).click(function(){
				   queryGoods2(pageNumber-1);
			 })
		   }else if(i==totalPage+1){
			  $("#follow"+i).click(function(){
				   queryGoods2(pageNumber+1);
			 }) 
			 }else{
			 $("#follow"+i).click(function(){
				   queryGoods2(i);
			 })
		   }
		  
	}
	// 表扬信
	function queryGoods3(pageNumber){
		// 查询条件
		var data=new Object();
		data.sid='${stuInfo.id}';
		data.pageNumber=pageNumber;
		$.post("${pageContext.request.contextPath}/queryPraise.action",
			   data,
			function(data){
			       var pagesize=data.pageSize;
			       var len=data.data.length;
			       var mm=0;
			       /* if(data.data.length==0){
			    	   $("$praise_mes").append("<h3 style='color:red;text-align:center;margin-top:40px;'>暂无表扬</h3>");
			       } */
			       // 清空表格
				   $("#praise_table").empty();
				   $.each(data.data,function(key,value){
					   var date=dateFormat(value.createtime);
					   var content=value.content;
					   var uname=value.uname;
					   var id=value.id;
					   $("#praise_table").append("<tr id='p"+id+"'><td><span class='glyphicon glyphicon-envelope' aria-hidden='true'></span></td><td>"+
							   "来自"+uname+"的表扬信</td><td>"+
							   date+"</td><td><a id='lookpraise"+id+"' data-toggle='modal' data-target='#ckpraise_detail'>查看</a></td><td>"+
							   "<a id='deletepraise"+id+"'>删除</a></td></tr>");
					   // 删除指定一条表扬信
					   $("#deletepraise"+id).click(function(){
						   mm=mm+1;
						   $.post('${pageContext.request.contextPath}/removePraise.action',
									{"id":id},
									function(data){
										$("#p"+data).remove();
										if(len<pagesize&&len==mm){
											queryGoods3(pageNumber-1);
										}
										if(len==pagesize&&len==mm){
											queryGoods3(pageNumber);
										}
									});
					   })
					   // 查看每条表扬信详情
					   $("#lookpraise"+id).click(function(){
						   lookpraise(id);
					   })
				   })
				    $("#mydelete").unbind('click');
				    $("#mydelete").click(function(){
						var v=$("#pid").val();
						mm=mm+1;
						$.post('${pageContext.request.contextPath}/removePraise.action',
								{"id":v},
								function(data){
									$("#p"+data).remove();
									if(len<pagesize&&mm==len){
										queryGoods3(pageNumber-1);
									}
									if(len==pagesize&&mm==len){
										queryGoods3(pageNumber);
									}
								});
					})
				   // 清空分页
				   $("#praise_nav").empty();
				   // 动态重新显示分页
				   if(data.totalPage>1){
					   if(data.pageNumber==1){
						   $("#praise_nav").append("<li><a id='praise0' class='btn disabled' aria-label='Previous'>"+
						   "<span aria-hidden='true'>&laquo;</span></a></li>");
					   }else{
						   $("#praise_nav").append("<li><a id='praise0' aria-label='Previous'>"+
						   "<span aria-hidden='true'>&laquo;</span></a></li>");
					   }
					   for(var i=1;i<=data.totalPage;i++){
						   if(data.pageNumber==i){
						      $("#praise_nav").append("<li class='active'><a id='praise"+i+"'>"+i+"<span class='sr-only'>(current)</span></a></li>")
						   }else{
							  $("#praise_nav").append("<li><a id='praise"+i+"'>"+i+"<span class='sr-only'>(current)</span></a></li>")
						   }
					   }
					   if(data.pageNumber==data.totalPage){
						   $("#praise_nav").append("<li><a id='praise"+(data.totalPage+1)+"' class='btn disabled' aria-label='Next'>"+
						   "<span aria-hidden='true'>&raquo;</span></a></li>");
					   }else{
						   $("#praise_nav").append("<li><a id='praise"+(data.totalPage+1)+"' aria-label='Next'>"+
						   "<span aria-hidden='true'>&raquo;</span></a></li>");
					   }
					   // 为列表中a标签添加事件
					   for(var i=0;i<=data.totalPage+1;i++){
						   praiseNav(i,data.pageNumber,data.totalPage);
					   }
				   }
			   }) 
	}
	// 初始化时添加分页事件
	var praiseCount='${praise_pageModel.totalPage+1}';
	var praisePage='${praise_pageModel.pageNumber}';
	for(var z=0;z<=praiseCount;z++){
		praiseNav(z,praisePage,praiseCount-1);
	}
	function praiseNav(i,pageNumber,totalPage){
		pageNumber=parseInt(pageNumber);
		if(i==0){
			 $("#praise"+i).click(function(){
				   queryGoods3(pageNumber-1);
			 })
		   }else if(i==totalPage+1){
			  $("#praise"+i).click(function(){
				   queryGoods3(pageNumber+1);
			 }) 
			 }else{
			 $("#praise"+i).click(function(){
				   queryGoods3(i);
			 })
		   }
	}
	// 查看表扬信
	function lookpraise(id){
		$.post('${pageContext.request.contextPath}/lookUpPraise.action',
				{"id":id},
				function(data){
					var date=dateFormat(data.createtime);
					$("#praise_content").html(data.content);
					$("#from_uname").html(data.uname);
					$("#praise_time").html(date);
					$("#pid").val(data.id);
				})
	}
	// 删除表扬信
	function removepraise(id){
		$.post('${pageContext.request.contextPath}/removePraise.action',
				{"id":id},
				function(data){
					$("#p"+data).remove();
				});
	}
	var praise='${praise_pageModel.data}';
	var praise_size='${praise_pageModel.pageSize}';
	var pp=praise.split('],');
	var arrayObj = new Array();
	for(var i=0;i<pp.length;i++){
		var p=pp[i].split(',');
		var r=p[0].split('=');
		arrayObj.push(r[1]);
	}
	var plen=arrayObj.length;
	var pmm=0;
	$.each(arrayObj,function(key,value){
		$("#lookpraise"+value).click(function(){
			lookpraise(value);
		})
		$("#deletepraise"+value).click(function(){
			pmm=pmm+1;
			$.post('${pageContext.request.contextPath}/removePraise.action',
					{"id":value},
					function(data){
						$("#p"+data).remove();
						if(plen<praise_size&&pmm==plen){
							queryGoods3(praisePage-1);
						}
						if(plen==praise_size&&pmm==plen){
							queryGoods3(praisePage);
						}
					});
		})
	})
	// 查看后删除表扬信
	$("#mydelete").click(function(){
		var v=$("#pid").val();
		pmm=pmm+1;
		$.post('${pageContext.request.contextPath}/removePraise.action',
				{"id":v},
				function(data){
					$("#p"+data).remove();
					if(plen<praise_size&&pmm==plen){
						queryGoods3(praisePage-1);
					}
					if(plen==praise_size&&pmm==plen){
						queryGoods3(praisePage);
					}
				});
	})
	// 时间戳转特定的日期格式2009-10-09
	function add0(m){return m<10?'0'+m:m}
	function dateFormat(shijianchuo){
		var time=new Date(shijianchuo);
		var y=time.getFullYear();
		var m=time.getMonth()+1;
		var d=time.getDate();
		return y+'-'+add0(m)+'-'+add0(d);
	}
})

</script>
</head>
<body style="margin-top:65px;">
  <jsp:include page="header.jsp"/>
    <div class="container-fluid">
     <div class="panel panel-info">
	   <div class="panel-heading">
	    <h3 class="panel-title">个人中心</h3>
	   </div>
	   <div class="panel-body">
	    <div class="row">
         <div class="col-md-4">
	     <div class="thumbnail">
	      <c:if test="${myInfo.pic==null||myInfo.pic=='' }">
	        <img alt="" src="${pageContext.request.contextPath }/images/test.jpg" class="img-circle" style="width:150px;height:150px;">
	      </c:if>
	      <c:if test="${myInfo.pic!=null&&myInfo.pic!='' }">
	        <img src="/pic/${myInfo.pic }" class="img-circle" style="width:150px;height:150px;">
	      </c:if>
	      <div class="caption" style="algin:center;">
	        <table class="table table-striped">
	          <tbody>
	             <tr><td style="width:100px;">用户名：</td><td>${myInfo.uname }</td></tr>
	           <c:if test="${myInfo.unumber==null }">
	             <tr><td>学号：</td><td>未知</td></tr>
	           </c:if>
	           <c:if test="${myInfo.unumber!=null }">
		         <tr><td>学号：</td><td>${myInfo.unumber }</td></tr>
		       </c:if>
		       <c:if test="${myInfo.sex==0 }">
		         <c:set var="sex" value="女"/>
		       </c:if>
		       <c:if test="${myInfo.sex==1 }">
		         <c:set var="sex" value="男"/>
		       </c:if>
		       <c:if test="${myInfo.sex==null }">
		         <tr><td>性别：</td><td>未知</td></tr>
		       </c:if>
		       <c:if test="${myInfo.sex!=null }">
		         <tr><td>性别：</td><td>${sex }</td></tr>
		       </c:if>
		       <c:if test="${myInfo.uclass==null }">
		         <tr><td>班级：</td><td>未知</td></tr>
		       </c:if>
		       <c:if test="${myInfo.uclass!=null }">
		         <tr><td>班级：</td><td>${myInfo.uclass }班</td></tr>
		       </c:if>
		       <c:if test="${myInfo.major==null }">
		         <tr><td>专业：</td><td>未知</td></tr>
		       </c:if>
		       <c:if test="${myInfo.major!=null }">
		         <tr><td>专业：</td><td>${myInfo.major }</td></tr>
		       </c:if>
		       <c:if test="${myInfo.institute==null }">
		         <tr><td>学院：</td><td>未知</td></tr>
		       </c:if>
		       <c:if test="${myInfo.institute!=null }">
		         <tr><td>学院：</td><td>${myInfo.institute }</td></tr>
		       </c:if>
	          </tbody>
	        </table>
	        <div style="float:right;margin-top:-30px;margin-right:25px;">
	          <a data-toggle="modal" data-target="#myInfo"><span class="glyphicon glyphicon-pencil" aria-hidden="true">
	                             编辑
	          </span></a>
	        </div>
	      </div>
	     </div>
	   </div>
	   <div class="col-md-8">
	        <!-- 页签区 -->
			<ul class="nav nav-tabs bg-success" role="tablist">  
			    <li role="presentation" class="active"><a href="#publish_panel" role="tab" data-toggle="tab">发布信息</a></li>
			    <li role="presentation"><a href="#follow_panel" role="tab" data-toggle="tab">关注信息</a></li>
			    <li role="presentation"><a href="#praise_panel" role="tab" data-toggle="tab">表扬信</a></li>  
			</ul>
			<!-- 面板区 -->
		    <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="publish_panel">
                 <div style="height:300px;">
                  <form class="form-inline" style="margin-left:10px;margin-top:20px;">
				     <label>类型：</label>
				     <label class="checkbox-inline">
		               <input type="checkbox" <c:if test="${fmt:length(publish_pageModel.data)==0}">disabled="disabled"</c:if>
		               value="Lost_Goods" name="lost" id="publish_lost">寻物
		             </label>
				     <label class="checkbox-inline">
		                <input type="checkbox" <c:if test="${fmt:length(publish_pageModel.data)==0}">disabled="disabled"</c:if>
		                value="Get_Goods" name="get" id="publish_get">招领
		             </label>
		             <label style="margin-left:280px;"> 排序：</label>
		             <label class="radio-inline">
					  <input type="radio" <c:if test="${fmt:length(publish_pageModel.data)==0}">disabled="disabled"</c:if>
					  name="publish_sort" value="1" id="asc_sort">升序
					 </label>
					 <label class="radio-inline">
					  <input type="radio" value="0" <c:if test="${fmt:length(publish_pageModel.data)==0}">disabled="disabled"</c:if>
					  name="publish_sort" id="desc_sort">降序
					 </label>
				    </form>
				    <c:if test="${fmt:length(publish_pageModel.data)==0}">
                      <h3 style="color:red;text-align:center;margin-top:20px;">暂无发布</h3>
                    </c:if>
				    
                  <table class="table table-hover" id="publish_table">
                    <c:if test="${publish_pageModel.data!=null }">
                    <c:forEach items="${publish_pageModel.data }" var="goods">
                     <c:if test="${goods.type=='Lost_Goods' }">
				       <c:set value="寻物" var="type"/>
				     </c:if>
				     <c:if test="${goods.type=='Get_Goods' }">
				       <c:set value="招领" var="type"/>
				     </c:if>
				     <c:if test="${goods.type==null }">
				       <c:set value="未知" var="type"/>
				     </c:if>
					<tr>
					  <td>${type }</td>
					  <td>${goods.title }</td>
					  <c:set var="goods_createtime">${goods.publish_date }</c:set>
			           <%
			              String str=pageContext.getAttribute("goods_createtime").toString();
			              String publish_goods="";
			              java.text.DateFormat format1=new java.text.SimpleDateFormat("yyyy-MM-dd");
					      java.text.DateFormat format2=new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",java.util.Locale.ENGLISH);
			              if(!"".equals(str)){
					          publish_goods=format1.format(format2.parse(str));
			              }
				       %>
			          <td><%=publish_goods %></td>
					  <td><a href="${pageContext.request.contextPath }/lookUpGoods.action?gid=${goods.id}&sid=${stuInfo.id}">查看</a></td>
					  
				    </tr>
				    </c:forEach>
				    </c:if>
				 </table>
				 </div>
		   <!-- 分页 -->
		   <c:if test="${publish_pageModel.totalPage>1 }">
		   <nav aria-label="Page navigation" style="text-align:center;">
			  <ul class="pagination" id="publish_nav">
			    <li>
			      <a <c:if test="${publish_pageModel.pageNumber==1 }">class="btn disabled"</c:if>
			      id="publish0" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			    <c:forEach begin="${1 }" end="${publish_pageModel.totalPage }" var="i">
			    <li <c:if test="${publish_pageModel.pageNumber==i }">class="active"</c:if>>
			      <a id="publish${i }">${i }<span class="sr-only">(current)</span></a>
			    </li>
			    </c:forEach>
			    <li>
			      <a id="publish${publish_pageModel.totalPage+1 }" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			  </ul>
			</nav>
		    </c:if>
                </div>
                <div role="tabpanel" class="tab-pane" id="follow_panel">
                 <div style="height:300px;">
                  <form class="form-inline" style="margin-left:10px;margin-top:20px;">
				     <label>类型：</label>
				     <label class="checkbox-inline">
		               <input type="checkbox" value="Lost_Goods" <c:if test="${fmt:length(follow_pageModel.data)==0}">disabled="disabled"</c:if>
		               name="lost" id="follow_lost">寻物
		             </label>
				     <label class="checkbox-inline">
		                <input type="checkbox" value="Get_Goods" <c:if test="${fmt:length(follow_pageModel.data)==0}">disabled="disabled"</c:if>
		                name="get" id="follow_get">招领
		              </label>
		             <label style="margin-left:280px;"> 排序：</label>
		             <label class="radio-inline">
					  <input type="radio" name="follow_sort" value="1" <c:if test="${fmt:length(follow_pageModel.data)==0}">disabled="disabled"</c:if>
					   id="fasc_sort">升序
					 </label>
					 <label class="radio-inline">
					  <input type="radio" name="follow_sort" value="0" <c:if test="${fmt:length(follow_pageModel.data)==0}">disabled="disabled"</c:if>
					   id="fdesc_sort">降序
					 </label>
				    </form>
				    <div id="follow_mes">
				    <c:if test="${fmt:length(follow_pageModel.data)==0}">
                      <h3 style="color:red;text-align:center;margin-top:20px;">暂无关注</h3>
                    </c:if>
                    </div>
                  <table class="table table-hover" id="follow_table">
                   <c:forEach items="${follow_pageModel.data }" var="goods">
				       <c:if test="${goods.type=='Lost_Goods' }">
				         <c:set value="寻物" var="type"/>
				       </c:if>
				       <c:if test="${goods.type=='Get_Goods' }">
				         <c:set value="招领" var="type"/>
				       </c:if>
				       <c:if test="${goods.type==null }">
				         <c:set value="未知" var="type"/>
				       </c:if>
					  <tr id="option${goods.id }">
					    <td>${type }</td>
					    <td>${goods.title }</td>
					    <c:set var="fgoods">${goods.publish_date }</c:set>
			           <%
			              String str=pageContext.getAttribute("fgoods").toString();
			              String follow_goods="";
			              java.text.DateFormat format1=new java.text.SimpleDateFormat("yyyy-MM-dd");
					      java.text.DateFormat format2=new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",java.util.Locale.ENGLISH);
			              if(!"".equals(str)){
					          follow_goods=format1.format(format2.parse(str));
			              }
				       %>
					    <td><%=follow_goods %></td>
					    <td>
					      <a href="${pageContext.request.contextPath }/lookUpGoods.action?gid=${goods.id}&sid=${myInfo.id}">查看</a>
					    </td>
					    <td>
					      <a id="follow_${goods.id }">取消关注</a>
					    </td>
					  </tr>
				 </c:forEach>
				 </table>
				</div>
			   <!-- 分页 -->
			   <c:if test="${follow_pageModel.totalPage>1 }">
			   <nav aria-label="Page navigation" style="text-align:center;">
				  <ul class="pagination" id="follow_nav">
				    <li>
				      <a <c:if test="${follow_pageModel.pageNumber==1 }">class="btn disabled"</c:if>
				      id="follow0" aria-label="Previous">
				        <span aria-hidden="true">&laquo;</span>
				      </a>
				    </li>
				    <c:forEach begin="${1 }" end="${follow_pageModel.totalPage }" var="i">
				    <li <c:if test="${follow_pageModel.pageNumber==i }">class="active"</c:if>>
				      <a id="follow${i }">${i }<span class="sr-only">(current)</span></a>
				    </li>
				    </c:forEach>
				    <li>
				      <a <c:if test="${follow_pageModel.pageNumber==follow_pageModel.totalPage }">class="btn disabled"</c:if>
				      id="follow${follow_pageModel.totalPage+1 }" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
				  </ul>
				</nav>
			    </c:if>
                </div>
                <div role="tabpanel" class="tab-pane" id="praise_panel" style="margin-top:20px;">
                  <div style="height:300px;" id="praise_mes">
                   <c:if test="${fmt:length(praise_pageModel.data)==0}">
                      <h3 style="color:red;text-align:center;margin-top:40px;">暂无表扬</h3>
                   </c:if>
                   <table class="table table-hover" id="praise_table">
                    <c:forEach items="${praise_pageModel.data }" var="praise">
					<tr id="p${praise.id }">
					  <td><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span></td>
					  <td>来自${praise.uname }的表扬信</td>
					  <c:set var="praisetime">${praise.createtime }</c:set>
			           <%
			              String str=pageContext.getAttribute("praisetime").toString();
			              String praise_time="";
			              java.text.DateFormat format1=new java.text.SimpleDateFormat("yyyy-MM-dd");
					      java.text.DateFormat format2=new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",java.util.Locale.ENGLISH);
			              if(!"".equals(str)){
			            	  praise_time=format1.format(format2.parse(str));
			              }
				       %>
					    <td><%=praise_time %></td>
					  <td><a id="lookpraise${praise.id }"
					  data-toggle="modal" data-target="#ckpraise_detail">查看</a></td>
					  <td><a id="deletepraise${praise.id }">直接删除</a></td>
				    </tr>
				    </c:forEach>
				 </table>
				 </div>
			   <!-- 分页 -->
			   <c:if test="${praise_pageModel.totalPage>1 }">
			   <nav aria-label="Page navigation" style="text-align:center;">
				  <ul class="pagination" id="praise_nav">
				    <li>
				      <a <c:if test="${praise_pageModel.pageNumber==1 }">class="btn disabled"</c:if>
				      aria-label="Previous" id="praise0">
				        <span aria-hidden="true">&laquo;</span>
				      </a>
				    </li>
				    <c:forEach begin="${1 }" end="${praise_pageModel.totalPage }" var="i">
				    <li <c:if test="${praise_pageModel.pageNumber==i }">class="active"</c:if>>
				      <a id="praise${i }">${i }<span class="sr-only">(current)</span></a>
				    </li>
				    </c:forEach>
				    <li>
				      <a <c:if test="${praise_pageModel.pageNumber==praise_pageModel.totalPage }">class="btn disabled"</c:if>
				       aria-label="Next" id="praise${praise_pageModel.totalPage+1 }">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
				  </ul>
				</nav>
			    </c:if>
                </div>
            </div>
	       </div>
	      </div>
	     </div>
	    </div>
       </div>
    <!-- 完善个人信息的模态对话框 -->
    <div class="modal" tabindex="-1" role="dialog" id="myInfo">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content" style="padding:20px;">
	      <div class="modal-header" style="background-color: #a5ffd8;color:#fff;">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">完善信息</h4>
	      </div>
	      <div class="modal-body" style="background-image:url(../images/bg.png)">
	        <form class="form-horizontal" enctype="multipart/form-data" method="post"
	        action="${pageContext.request.contextPath }/editmyinfo.action" id="myinfo_form">
			  <div class="form-group">
			    <label for="uname" class="col-sm-2 control-label">用户名：</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" placeholder="请输入用户名" 
			      name="uname" id="uname" value="${myInfo.uname }"/>
			      <input type="hidden" value="${myInfo.id }" name="id">
			      <input type="hidden" value="${myInfo.mphone }" name="mphone">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="unumber" class="col-sm-2 control-label">学号：</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="unumber" 
			      name="unumber" placeholder="请输入学号" value="${myInfo.unumber }">
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">性别：</label>
			    <div class="col-sm-10">
			      <label class="radio-inline">
					<input type="radio" <c:if test="${myInfo.sex==1 }">checked</c:if>
					name="sex" id="man" value="1">男
				  </label>
				  <label class="radio-inline">
					<input type="radio" <c:if test="${myInfo.sex==0 }">checked</c:if>
					name="sex" id="woman" value="0">女
				  </label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="pic" class="col-sm-2 control-label">头像：</label>
			    <div class="col-sm-10">
			      <input type="file" class="form-control" id="picFile" name="picFile">
			      <input type="hidden" value="${myInfo.pic }" name="pic">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="institute" class="col-sm-2 control-label">学院：</label>
			    <div class="col-sm-10">
			      <select class="form-control" id="institute" name="institute">
			        <c:if test="${myInfo.institute==null||myInfo.institute=='' }">
				     <option selected='selected' disabled='disabled'>请选择</option>
				    </c:if>
				    <c:forEach items="${institutes }" var="institute">
				     <option value="${institute.desc }" 
				     <c:if test="${institute.desc==myInfo.institute }">selected = "selected" </c:if>
				     >${institute.desc }</option>
				    </c:forEach>
				  </select>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="major" class="col-sm-2 control-label">专业：</label>
			    <div class="col-sm-10">
			      <select class="form-control" id="major" name="major">
			       <c:if test="${myInfo.institute==null||myInfo.institute=='' }">
				     <option selected='selected' disabled='disabled'>请选择</option>
				   </c:if>
				   <c:forEach items="${majors }" var="major">
			         <option value="${major.desc }"
			           <c:if test="${major.desc==myInfo.major }">selected = "selected" </c:if>
			         >${major.desc }</option>
			       </c:forEach>
				  </select>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="uclass" class="col-sm-2 control-label">班级：</label>
			    <div class="col-sm-10">
			     <input type="number" id="uclass" name="uclass" class="form-control" value="${myInfo.uclass }">
			    </div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer" style="background-color:#fdd4fc;">
	        <button type="button" class="btn btn-warning" data-dismiss="modal" id="myinfo_reset">取消</button>
			<button type="submit" class="btn btn-success" data-dismiss="modal" id="myinfo_submit">提交</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
    <!-- 表扬信模态对话框 -->
    <div class="modal" tabindex="-1" role="dialog" id="ckpraise_detail">
	  <div class="modal-dialog" id="modalDialog" role="document">
	    <div class="modal-content" style="padding:10px;width:400px;margin:auto;background-image:url(${pageContext.request.contextPath}/images/love.png);
	    background-size:100% 100%;margin-top:100px;">
	       <div class="modal-body" style="padding-bottom:35px;background:rgba(187,253,232,0.4)">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <input type="hidden" id="pid"/>
	         <p style="font-size:18px;color:#fcac5d;line-height:35px;" id="praise_title">亲爱的${stuInfo.uname }：</p>
	         <p style="text-indent:2em;color:#ff2400;font-size:18px;line-height:35px;" id="praise_content"></p>
	         <p style="text-align:center;color:blue;font-size:18px;line-height:35px;" id="praise_time"></p>
	         <p style="float:right;color:#fc4ba3;font-size:18px;line-height:35px;">来自：<strong id="from_uname"></strong></p>
	       </div>
	      <div class="modal-footer" style="background:rgba(187,253,232,0.4);">
	        <button type="button" id="mydelete" data-dismiss="modal" class="btn btn-warning">删除</button>
	        <button type="button" data-dismiss="modal" class="btn btn-info">取消</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
  <jsp:include page="footer.jsp"/>
</body>
</html>