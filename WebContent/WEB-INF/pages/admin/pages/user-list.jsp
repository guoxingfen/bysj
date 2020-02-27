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
<title>用户信息</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/style.css" />
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 人员管理 <span class="c-gray en">&gt;</span> 用户列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
  <div class="cl pd-5 bg-1 bk-gray mt-20" style="margin-top:0px;"> 
     <span class="l"><a href="javascript:;" onclick="stopAllCheck();" class="btn btn-danger radius">
     <i class="Hui-iconfont">&#xe631;</i> 批量停用</a> 
     <a href="javascript:;" onclick="startAllCheck();" class="btn btn-primary radius">
     <i class="Hui-iconfont">&#xe615;</i> 批量启用</a></span> 
	<span class="r">共有数据：<strong>${fmt:length(stuInfoes) }</strong> 条</span> 
  </div>
 <div class="mt-20">
  <table class="table table-border table-bordered table-bg table-sort">
    <thead>
      <tr class="text-c">
        <th><input type="checkbox"></th>
        <th>序号</th>
        <th>用户名</th>
        <th>学号</th>
        <th>性别</th>
        <th>班级</th>
        <th>专业</th>
        <th>学院</th>
        <th>手机号</th>
        <th>状态</th>
        <th>操作</th>
      </tr>
    </thead>
    <tbody>
     <c:if test="${fmt:length(stuInfoes)==0 }">
       <h3 style="text-align:center;color:red;margin-top:20px;">暂无数据</h3>
     </c:if>
     <c:forEach items="${stuInfoes }" var="stuInfo" varStatus="index">
      <tr class="text-c">
        <td><input type="checkbox" name="user" value="${stuInfo.id }"></td>
        <td>${index.index+1 }</td>
        <td>${stuInfo.uname }</td>
        <td>${stuInfo.unumber }</td>
        <c:if test="${stuInfo.sex==1 }">
          <c:set var="sex">男</c:set>
        </c:if>
        <c:if test="${stuInfo.sex==0 }">
          <c:set var="sex">女</c:set>
        </c:if>
        <c:if test="${stuInfo.sex==null }">
          <c:set var="sex">保密</c:set>
        </c:if>
        <td>${sex }</td>
        <td>${stuInfo.uclass }</td>
        <td>${stuInfo.major }</td>
        <td>${stuInfo.institute }</td>
        <td>${stuInfo.mphone }</td>
        <td class="td-status">
          <c:if test="${stuInfo.status==1 }"><span class="label label-success radius">已启用</span></c:if>
          <c:if test="${stuInfo.status==0 }"><span class="label label-danger radius">已禁用</span></c:if>
        </td>
        <td class="td-manage">
         <c:if test="${stuInfo.status==1 }">
          <a style="text-decoration:none" onClick="user_stop(this,${stuInfo.id })" href="javascript:;" title="停用"><i class="Hui-iconfont">&#xe631;</i></a>
         </c:if>
         <c:if test="${stuInfo.status==0 }">
          <a style="text-decoration:none" onClick="user_start(this,${stuInfo.id })" href="javascript:;" title="启用"><i class="Hui-iconfont">&#xe615;</i></a>
         </c:if>
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

/*用户-停用*/
function user_stop(obj,id){
	var sss=":"+id;
	layer.confirm('确认要停用该用户吗？',{btn: ['确定', '取消'],title:"提示",icon:3},function(){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath }/admin/changeuserStatus.action',
			data:{"ids":sss,"status":0},
			dataType: 'json',
			success: function(data){
				$(obj).parents("tr").find(".td-manage").prepend('<a onClick="user_start(this,'+id+')" href="javascript:;" title="启用" style="text-decoration:none"><i class="Hui-iconfont">&#xe615;</i></a>');
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

/*用户-启用*/
function user_start(obj,id){
	var sss=":"+id;
	layer.confirm('确认要启用该用户吗？',{btn: ['确定', '取消'],title:"提示",icon:3},function(){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath }/admin/changeuserStatus.action',
			data:{"ids":sss,"status":1},
			dataType: 'json',
			success: function(data){
				$(obj).parents("tr").find(".td-manage").prepend('<a onClick="user_stop(this,'+id+')" href="javascript:;" title="停用" style="text-decoration:none"><i class="Hui-iconfont">&#xe631;</i></a>');
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

// 批量停用
function stopAllCheck(){
	var ids=new Array();
	$("input:checkbox[name=user]:checked").each(function(key,value){
		ids.push($(this).val());
	})
	var sss="";
	$.each(ids,function(key,value){
		sss=sss+":"+value;
	})
	layer.confirm('确认要停用这'+ids.length+'位用户吗？',{btn: ['确定', '取消'],title:"提示",icon:3},function(){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath }/admin/changeuserStatus.action',
			data:{"ids":sss,"status":0},
			dataType: 'json',
			success: function(data){
				if(data.code=='SUCCESS'){
					$("input:checkbox[name=user]:checked").each(function(key,value){
						var id=$(value).val();
						$(value).parents("tr").find(".td-manage").empty();
						$(value).parents("tr").find(".td-manage").prepend('<a onClick="user_start(this,'+id+')" href="javascript:;" title="启用" style="text-decoration:none"><i class="Hui-iconfont">&#xe615;</i></a>');
						$(value).parents("tr").find(".td-status").html('<span class="label label-danger radius">已禁用</span>');
					})
					layer.msg('已停用!',{icon: 6,time:1000});
				}else{
					layer.msg('停用失败，未选择数据!', {icon: 5,time:1000});
				}
			}
		});		
	});
}
// 批量启用
function startAllCheck(){
	var ids=new Array();
	$("input:checkbox[name=user]:checked").each(function(key,value){
		ids.push($(this).val());
	})
	var sss="";
	$.each(ids,function(key,value){
		sss=sss+":"+value;
	})
	layer.confirm('确认要启用这'+ids.length+'位用户吗？',{btn: ['确定', '取消'],title:"提示",icon:3},function(){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath }/admin/changeuserStatus.action',
			data:{"ids":sss,"status":1},
			dataType: 'json',
			success: function(data){
				if(data.code=='SUCCESS'){
					$("input:checkbox[name=user]:checked").each(function(key,value){
						var id=$(value).val();
						$(value).parents("tr").find(".td-manage").empty();
						$(value).parents("tr").find(".td-manage").prepend('<a onClick="user_stop(this,'+id+')" href="javascript:;" title="停用" style="text-decoration:none"><i class="Hui-iconfont">&#xe631;</i></a>');
						$(value).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
					})
					layer.msg('已启用!', {icon: 6,time:1000});
				}else{
					layer.msg('启用失败，未选择数据!', {icon: 5,time:1000});
				}
			}
		});		
	});
}

</script>
</body>
</html>