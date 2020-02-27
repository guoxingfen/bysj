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
<title>名言信息</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/style.css" />
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 名人名言 <span class="c-gray en">&gt;</span> 名言管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
  <div class="cl pd-5 bg-1 bk-gray mt-20" style="margin-top:0px;"> 
     <span class="l"><a href="javascript:;" onclick="deleteAllCheck()" class="btn btn-danger radius">
     <i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> 
     <a href="javascript:;" onclick="famousRemark('添加名言','${pageContext.request.contextPath }/admin/addPreFamousRemark.action','450','350')" class="btn btn-primary radius">
     <i class="Hui-iconfont">&#xe600;</i> 添加名言</a></span> 
	<span class="r">共有数据：<strong>${fmt:length(famousRemarks) }</strong> 条</span> 
  </div>
 <div class="mt-20">
  <table class="table table-border table-bordered table-bg table-sort">
    <thead>
      <tr class="text-c">
        <th><input type="checkbox"></th>
        <th>序号</th>
        <th>图片</th>
        <th>名言</th>
        <th>来源</th>
        <th>发布时间</th>
        <th>操作</th>
      </tr>
    </thead>
    <tbody>
      <c:if test="${fmt:length(famousRemarks)==0 }">
        <h3 style="text-align:center;color:red;margin-top:20px;">暂无数据</h3>
      </c:if>
      <c:forEach items="${famousRemarks }" var="famousRemark" varStatus="index">
      <tr class="text-c">
        <td><input type="checkbox" name="famousRemark" value="${famousRemark.id }"></td>
        <td>${index.index+1 }</td>
        <td><img class="thumbnail" style="width:150px;height:150px;" alt=""
         <c:if test="${famousRemark.pic==null||famousRemark.pic=='' }">
           src="${pageContext.request.contextPath }/images/404.jpeg"
         </c:if>
         <c:if test="${famousRemark.pic!=null&&famousRemark.pic!=''}">
           src="/pic/${famousRemark.pic }"
         </c:if>
         ></td>
        <td>${famousRemark.content }</td>
        <td>${famousRemark.from }</td>
        <c:set var="createtime">${famousRemark.createtime }</c:set>
	     <%
	       String str=pageContext.getAttribute("createtime").toString();
	       String ll="";
	       java.text.DateFormat format1=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	       java.text.DateFormat format2=new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",java.util.Locale.ENGLISH);
	       if(!"".equals(str)){
			   ll=format1.format(format2.parse(str));
	       }
		 %>
        <td><%=ll %></td>
        <td class="td-manage">
          <a style="text-decoration:none" onClick="famousRemark('添加名言','${pageContext.request.contextPath }/admin/editFamousRemark.action?id=${famousRemark.id }','450','350')" href="javascript:;" title="编辑"><i class="Hui-iconfont">&#xe6df;</i></a>
          <a title="删除" href="javascript:;" onclick="famousRemark_del(this,${famousRemark.id })" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>
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

//删除名言
function famousRemark_del(obj,id){
	var sss=":"+id;
	layer.confirm('确认要删除这条名言吗？',{btn: ['确定', '取消'],title:"提示",icon:3},function(){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath }/admin/deleteSelectFamousRemark.action',
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
	$("input:checkbox[name=famousRemark]:checked").each(function(key,value){
		ids.push($(this).val());
	})
	var sss="";
	$.each(ids,function(key,value){
		sss=sss+":"+value;
	})
	layer.confirm('确认要删除这'+ids.length+'条名言吗？',{btn: ['确定', '取消'],title:"提示",icon:3},function(){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath }/admin/deleteSelectFamousRemark.action',
			data:{"ids":sss},
			dataType: 'json',
			success: function(data){
				if(data.code=='SUCCESS'){
					$("input:checkbox[name=famousRemark]:checked").each(function(key,value){
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
// 添加名言
function famousRemark(title,url,w,h){
	layer_show(title,url,w,h);
}








</script>
</body>
</html>