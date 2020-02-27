<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<title>失物信息</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/style.css" />
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 物品信息 <span class="c-gray en">&gt;</span> 失物管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <form action="${pageContext.request.contextPath }/admin/reportGoodsManage.action" method="get" id="report_form">
     <div class="text-c"> 举报人数大于或等于：
        <input type="hidden" name="type" value="Lost_Goods"/>
		<input type="number" required="required" class="input-text" style="width:250px" placeholder="请输入举报人数" name="report" value="${report }">
		<button type="submit" class="btn btn-success radius"><i class="Hui-iconfont">&#xe665;</i> 搜索物品</button>
	</div>
	</form>
	<div class="cl pd-5 bg-1 bk-gray mt-20"> 
		<span class="l">
		<a href="javascript:;" onclick="deleteAllCheck()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>
		<a href="javascript:;" onclick="goods('添加物品','${pageContext.request.contextPath }/admin/addPreGoods.action','','510')" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加物品</a></span> 
		<span class="r">共有数据：<strong>${fmt:length(adminGoodsInfoes) }</strong> 条</span> 
	</div>
	<div class="mt-20">
	 <table class="table table-border table-bordered  table-bg table-sort">
		<thead>
			<tr class="text-c">
				<th><input type="checkbox" name=""></th>
				<th>序号</th>
				<th>图片</th>
				<th>类型</th>
				<th>用户名</th>
				<th>信息标题</th>
				<th>详情</th>
				<th>丢失时间</th>
				<th>丢失地点</th>
				<th>联系地址</th>
				<th>手机号码</th>
				<th>发布时间</th>
				<th>状态</th>
				<th>举报人数</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fmt:length(adminGoodsInfoes)==0 }">
		  <h3 style="text-align:center;color:red;margin-top:20px;">暂无数据</h3>
		</c:if>
		<c:forEach items="${adminGoodsInfoes }" var="adminGoodsInfo" varStatus="index">
		<tr class="text-c">
				<td><input type="checkbox" value="${adminGoodsInfo.id }" name="lost"></td>
				<td>${index.index+1 }</td>
				<td>
				 <c:if test="${adminGoodsInfo.pic==null||adminGoodsInfo.pic=='' }">
				   <img style="height:50px;width:50px;" src="${pageContext.request.contextPath }/images/404.jpeg"/>
				 </c:if>
				 <c:if test="${adminGoodsInfo.pic!=null&&adminGoodsInfo.pic!='' }">
				   <img style="height:50px;width:50px;" src="/pic/${adminGoodsInfo.pic }"/>
				 </c:if>
				</td>
				<td>${adminGoodsInfo.kdesc }</td>
				<td>
				  <c:if test="${adminGoodsInfo.uname==null }">
				    <p class="c-red">
				      <a>管理员</a>
				    </p>
				  </c:if>
				  <c:if test="${adminGoodsInfo.uname!=null }">
				    <p class="c-blue">
				      <a>${adminGoodsInfo.uname }</a>
				    </p>
				  </c:if>
				</td>
				<td class="text-l">${adminGoodsInfo.title }</td>
				<td class="text-l">${adminGoodsInfo.detail }</td>
				<c:set var="date">${adminGoodsInfo.date }</c:set>
			     <%
			       String str=pageContext.getAttribute("date").toString();
			       String ll="";
			       java.text.DateFormat format1=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			       java.text.DateFormat format2=new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",java.util.Locale.ENGLISH);
			       if(!"".equals(str)){
					   ll=format1.format(format2.parse(str));
			       }
				 %>
				<td><%=ll %></td>
				<td>${adminGoodsInfo.address }</td>
				<td>${adminGoodsInfo.contact_address }</td>
				<td>${adminGoodsInfo.phone }</td>
				<c:set var="publish_date">${adminGoodsInfo.publish_date }</c:set>
				<%
				   str=pageContext.getAttribute("publish_date").toString();
				   if(!"".equals(str)){
					  ll=format1.format(format2.parse(str));
				    }
				%>
				<td><%=ll %></td>
<!-- 要添加相应的状态功能，没找回，已找回，已删除 -->
				<td class="td-status" id='status'>
				 <c:if test="${adminGoodsInfo.status==0 }">
				   <span class="label label-danger radius">寻找中</span>
				 </c:if>
				 <c:if test="${adminGoodsInfo.status==1 }">
				   <span class="label label-success radius">已找回</span>
				 </c:if>
				</td>
				<td>
				 <span class="c-warning">${adminGoodsInfo.report }</span>
				</td>
				<td class="td-manage">
					<a title="编辑" href="javascript:;" onclick="goods('编辑','${pageContext.request.contextPath }/admin/addPreGoods.action?id=${adminGoodsInfo.id }','','510')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a> 
					<a title="删除" href="javascript:;" onclick="lostGoods_del(this,${adminGoodsInfo.id })" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>
					<c:if test="${adminGoodsInfo.uname==null&&adminGoodsInfo.status==0 }">
					<a title="确认" href="javascript:;" onclick="changeStatus(this,${adminGoodsInfo.id })" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e1;</i></a>
					</c:if>
					</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/H-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/H-ui.admin.js"></script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery.validate.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/messages_zh.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/laypage.js"></script>
<script type="text/javascript">
$(function(){
	$('.table-sort').dataTable({
	});
	
});

/*失物-添加*/
function goods(title,url,w,h){
	layer_show(title,url,w,h);
}
/*失物-状态*/
function changeStatus(obj,id){
	layer.confirm('确认该物品已找回吗？',{btn: ['确定', '取消'],title:"提示",icon:3},function(){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath }/admin/updateGoodsStatus.action',
			data:{"id":id},
			dataType: 'json',
			success: function(data){
				$(obj).parents("tr").children("td#status").empty();
				$(obj).parents("tr").children("td#status").append('<span class="label label-success radius">已找回</span>');
				$(obj).remove();
				layer.msg('已确认!',{icon:1,time:1000});
			},
			error:function(data) {
				layer.msg('确认失败', {icon: 2,time:1000});
			},
		});		
	});
}
/*失物-删除*/
function lostGoods_del(obj,id){
	var sss=":"+id;
	layer.confirm('确认要删除这条物品信息吗？',{btn: ['确定', '取消'],title:"提示",icon:3},function(){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath }/admin/deleteSelectGoods.action',
			data:{"ids":sss},
			dataType: 'json',
			success: function(data){
				$(obj).parents("tr").remove();
				layer.msg('已删除!',{icon:1,time:1000});
			},
			error:function(data) {
				layer.msg('删除失败', {icon: 2,time:1000});
			},
		});		
	});
}
// 批量删除
function deleteAllCheck(){
	var ids=new Array();
	$("input:checkbox[name=lost]:checked").each(function(key,value){
		ids.push($(this).val());
	})
	var sss="";
	$.each(ids,function(key,value){
		sss=sss+":"+value;
	})
	layer.confirm('确认要删除这'+ids.length+'条物品信息吗？',{btn: ['确定', '取消'],title:"提示",icon:3},function(){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath }/admin/deleteSelectGoods.action',
			data:{"ids":sss},
			dataType: 'json',
			success: function(data){
				if(data.code=='SUCCESS'){
					$("input:checkbox[name=lost]:checked").each(function(key,value){
						$(value).parents("tr").remove();
					})
					layer.msg(data.message,{icon:1,time:1000});
				}else{
					layer.msg(data.message,{icon:2,time:1000});
				}
			}
		});		
	});
}
</script> 
</body>
</html>