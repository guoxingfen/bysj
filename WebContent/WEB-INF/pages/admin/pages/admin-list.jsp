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
<title>管理员信息</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/style.css" />
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 人员管理 <span class="c-gray en">&gt;</span> 管理员列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
  <div class="cl pd-5 bg-1 bk-gray mt-20" style="margin-top:0px;"> 
     <span class="l"><a href="javascript:;" onclick="deleteAllCheck()" class="btn btn-danger radius">
     <i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> 
     <a href="javascript:;" onclick="admin_add('添加管理员','${pageContext.request.contextPath }/admin/addPreAdmin.action','400','350')" class="btn btn-primary radius">
     <i class="Hui-iconfont">&#xe600;</i> 添加管理员</a></span> 
	<span class="r">共有数据：<strong>${fmt:length(htusers) }</strong> 条</span> 
  </div>
 <div class="mt-20">
  <table class="table table-border table-bordered table-bg table-sort">
    <thead>
      <tr class="text-c">
        <th><input type="checkbox"></th>
        <th>账户</th>
        <th>性别</th>
        <th>角色</th>
        <th>手机号</th>
        <th>加入时间</th>
        <th>状态</th>
        <th>操作</th>
      </tr>
    </thead>
    <tbody>
      <c:if test="${fmt:length(htusers)==0 }">
        <h3 style="text-align:center;color:red;margin-top:20px;">暂无数据</h3>
      </c:if>
      <c:forEach items="${htusers }" var="htuser" varStatus="index">
      <tr class="text-c">
        <td><input type="checkbox" name="admin" value="${htuser.id }"></td>
        <td>${htuser.username }</td>
        <td>${htuser.gender }</td>
        <td>${htuser.role }</td>
        <td>${htuser.phone }</td>
        <c:set var="jointime">${htuser.jointime }</c:set>
	     <%
	       String str=pageContext.getAttribute("jointime").toString();
	       String ll="";
	       java.text.DateFormat format1=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	       java.text.DateFormat format2=new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",java.util.Locale.ENGLISH);
	       if(!"".equals(str)){
			   ll=format1.format(format2.parse(str));
	       }
		 %>
        <td><%=ll %></td>
        <td class="td-status">
          <c:if test="${htuser.status==1 }">
            <span class="label label-success radius">已启用</span>
          </c:if>
          <c:if test="${htuser.status==0 }">
            <span class="label label-danger radius">已禁用</span>
          </c:if>
        </td>
        <td class="td-manage">
          <c:if test="${htuser.status==1 }">
            <a style="text-decoration:none" onClick="admin_stop(this,${htuser.id })" href="javascript:;" title="停用"><i class="Hui-iconfont">&#xe631;</i></a>
          </c:if>
          <c:if test="${htuser.status==0 }">
            <a style="text-decoration:none" onClick="admin_start(this,${htuser.id })" href="javascript:;" title="启用"><i class="Hui-iconfont">&#xe615;</i></a>
          </c:if>
          <a title="删除" href="javascript:;" onclick="admin_del(this,${htuser.id })" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>
        </td>
      </tr>
      </c:forEach>
    </tbody>
  </table>
 </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/H-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/H-ui.admin.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/laypage.js"></script>
<script type="text/javascript">
$(function(){
	$('.table-sort').dataTable({
	});
	
});

/*管理员-停用*/
function admin_stop(obj,id){
	var sss=":"+id;
	layer.confirm('确认要停用该管理员吗？',{btn: ['确定', '取消'],title:"提示",icon:3},function(){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath }/admin/changeAdminStatus.action',
			data:{"ids":sss,"status":0},
			dataType: 'json',
			success: function(data){
				$(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_start(this,'+id+')" href="javascript:;" title="启用" style="text-decoration:none"><i class="Hui-iconfont">&#xe615;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-danger radius">已禁用</span>');
				$(obj).remove();
				layer.msg('已停用!',{icon: 6,time:1000});
			},
			error:function(data) {
				layer.msg('停用失败!', {icon: 5,time:1000});
			},
		});		
	});
}

/*管理员-启用*/
function admin_start(obj,id){
	var sss=":"+id;
	layer.confirm('确认要启用该管理员吗？',{btn: ['确定', '取消'],title:"提示",icon:3},function(){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath }/admin/changeAdminStatus.action',
			data:{"ids":sss,"status":1},
			dataType: 'json',
			success: function(data){
				$(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_stop(this,'+id+')" href="javascript:;" title="停用" style="text-decoration:none"><i class="Hui-iconfont">&#xe631;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
				$(obj).remove();
				layer.msg('已启用!', {icon: 6,time:1000});
			},
			error:function(data) {
				layer.msg('启用失败!', {icon: 5,time:1000});
			},
		});		
	});
}

// 删除管理员
function admin_del(obj,id){
	var sss=":"+id;
	layer.confirm('确认要删除该管理员吗？',{btn: ['确定', '取消'],title:"提示",icon:3},function(){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath }/admin/deleteSelectAdmin.action',
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
	var iids=new Array();
	$("input:checkbox[name=admin]:checked").each(function(key,value){
		iids.push($(this).val());
	})
	var sss="";
	$.each(iids,function(key,value){
		sss=sss+":"+value;
	})
	layer.confirm('确认要删除这'+iids.length+'位管理员？',{btn: ['确定', '取消'],title:"提示",icon:3},function(){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath }/admin/deleteSelectAdmin.action',
			data:{"ids":sss},
			dataType: 'json',
			success: function(data){
				if(data.code=='SUCCESS'){
					$("input:checkbox[name=admin]:checked").each(function(key,value){
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



// 添加管理员
function admin_add(title,url,w,h){
	layer_show(title,url,w,h);
}








</script>
</body>
</html>