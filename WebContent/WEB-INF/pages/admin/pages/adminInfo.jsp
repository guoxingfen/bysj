<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<title>个人信息</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/style.css" />
</head>
<body>
<article class="page-container">
	<table class="table ">
	  <tbody>
	    <tr class="text-r">
	      <td>账户：</td><td class="text-l">${htuser.username }</td>
	    </tr>
	    <tr class="text-r">
	      <td>性别：</td><td class="text-l">${htuser.gender }</td>
	    </tr>
	    <tr class="text-r">
	      <td>角色：</td><td class="text-l">${htuser.role }</td>
	    </tr>
	    <tr class="text-r">
	      <td>手机号：</td><td class="text-l">${htuser.phone }</td>
	    </tr>
	  </tbody>
	</table>
</article>

</body>
</html>