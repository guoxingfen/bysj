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
<title>主页</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/style.css" />
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<table class="table table-border table-bordered table-bg" style="margin-top:20px;">
		<thead>
			<tr class="text-c">
				<th colspan="9" scope="col">信息统计</th>
			</tr>
			<tr class="text-c">
				<th>统计</th>
				<th>用户</th>
				<th>管理员</th>
				<th>失物</th>
				<th>拾物</th>
				<th>公告</th>
				<th>名人名言</th>
				<th>留言</th>
			</tr>
		</thead>
		<tbody>
		   <tr class="text-c">
		     <td>总数</td>
		     <td>${stuTotal }</td>
		     <td>${htuserTotal }</td>
		     <td>${lostTotal }</td>
		     <td>${getTotal }</td>
		     <td>${noticeBoardTotal }</td>
		     <td>${famousRemarkTotal }</td>
		     <td>${leaMesTotal }</td>
		   </tr>
		   <tr class="text-c">
		     <td style="color:blue;">已启用</td>
		     <td><span class="label label-success radius">${stuStart }</span></td>
		     <td><span class="label label-success radius">${htuserStart }</span></td>
		     <td>--</td>
		     <td>--</td>
		     <td>--</td>
		     <td>--</td>
		     <td>--</td>
		   </tr>
		   <tr class="text-c">
		     <td style="color:blue;">已确认</td>
		     <td>--</td>
		     <td>--</td>
		     <td><span class="label label-success radius">${lostConfirm }</span></td>
		     <td><span class="label label-success radius">${getConfirm }</span></td>
		     <td>--</td>
		     <td>--</td>
		     <td>--</td>
		   </tr>
		</tbody>
</table>




<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/H-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/H-ui.admin.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/laypage.js"></script>
<script type="text/javascript">

</script>
</body>
</html>