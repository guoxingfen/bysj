<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>失物招领</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/login.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/commons.js"></script>
<style type="text/css">

</style>
<script type="text/javascript">
// 项目相对路径：/bysj
var path='${pageContext.request.contextPath }'

</script>
</head>
<body>
  <nav class="navbar navbar-default navbar-fixed-top">
  <div class="container-fluid" style="">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="${pageContext.request.contextPath }/queryAllInfo.action">
        <img src="${pageContext.request.contextPath }/images/logo.png" style="width:80px;height:50px;margin-top:-15px;margin-right:-25px;margin-left:-10px;"/>
      </a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul id="nav" class="nav navbar-nav" style="font-size:16px;">
        <li <c:if test="${status==1 }">class="active"</c:if>> <a href="${pageContext.request.contextPath }/queryAllInfo.action">网站首页</a></li>
	    <li <c:if test="${status==2 }">class="active"</c:if> ><a href="${pageContext.request.contextPath }/forlost.action?pageNumber=1">寻物启事</a></li>
	    <li <c:if test="${status==3 }">class="active"</c:if> ><a href="${pageContext.request.contextPath }/forget.action?pageNumber=1">招领启事</a></li>
	    <li <c:if test="${status==4 }">class="active"</c:if> ><c:if test="${! empty stuInfo }">
	    <a href="${pageContext.request.contextPath }/torelease.action">发布信息</a></c:if>
	    <c:if test="${ empty stuInfo }">
	    <a id="publisInfo">发布信息</a></c:if>
	    </li>
	    <li <c:if test="${status==5 }">class="active"</c:if> ><a href="${pageContext.request.contextPath }/mystatistics.action">统计分析</a></li>
	    <li <c:if test="${status==6 }">class="active"</c:if> ><a href="${pageContext.request.contextPath }/queryAllLeaMes.action?pageNumber=1">留言中心</a></li>
	    <li><a href="#" id="globalLoginBtn">
	      <c:if test="${!empty stuInfo}">[退出登录]</c:if>
	      <c:if test="${empty stuInfo }">登录|注册</c:if></a>
	    </li>
      </ul>
      <c:if test="${!empty stuInfo }">
	      <a href="${pageContext.request.contextPath }/myinfo.action?sid=${stuInfo.id}&pageNumber=1" style="margin-left:35px;font-size:16px;">欢迎，${stuInfo.uname }
	      <img <c:if test="${stuInfo.pic==null||stuInfo.pic=='' }">src="${pageContext.request.contextPath }/images/test.jpg"</c:if>
	       <c:if test="${stuInfo.pic!=null&&stuInfo.pic!='' }">src="/pic/${stuInfo.pic }"</c:if>
	       class="img-circle" style="width:50px;height:50px;"></a>
	  </c:if>
      <form class="navbar-form navbar-right" action="${pageContext.request.contextPath }/tosearch.action" method="post">
        <div class="form-group">
          <input type="text" class="form-control" name="keyword" placeholder="请输入关键字">
        </div>
        <input type="hidden" name="pageNumber" value="1"/>
        <button type="submit" class="btn btn-success">搜索</button>
      </form>
    </div>
  </div>
</nav>
<!-- 模态对话框 -->
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
		aria-labelledby="mySmallModalLabel" aria-hidden="true"
		style="display: none;">
		<div style="display: table; width: 100%; height: 100%;">
			<div style="vertical-align: middle; display: table-cell;">
				<div class="modal-dialog modal-sm" style="width: 540px;">
					<div class="modal-content" style="border: none;">
						<div class="col-left"></div>
						<div class="col-right">
							<div class="modal-header">
								<button type="button" id="login_close" class="close"
									data-dismiss="modal">
									<span aria-hidden="true">×</span><span class="sr-only">Close</span>
								</button>
								<span class="modal-title" id="loginModalLabel"
									style="font-size: 18px;">登录</span> <span id="login-form-tips"
									class="tips-error"></span>
							</div>
							<div class="modal-body">
								<section class="box-login v5-input-txt" id="box-login">
									<form id="login_form" action="" method="post"
										autocomplete="off">
										<ul class="list-unstyled">
											<li class="form-group"><input class="form-control"
												id="uname" maxlength="50" name="uname"
												placeholder="请输入用户名/手机号/学号" type="text" /></li>
											<li class="form-group"><input class="form-control"
												id="password" name="password" placeholder="请输入密码"
												type="password" /> <a id="passwordeye"
												class="glyphicon glyphicon-eye-close"
												style="float: right; margin-top: -25px; padding-right: 10px"></a>
											</li>
											<li class="form-inline" aria-hidden="true"
												style="display: none;" id="register"><input
												class="form-control" id="code" name="code"
												placeholder="请输入验证码" type="text" size="12" /> <input
												class="btn btn-success" style="float: right" id="code_btn"
												value="点击获取" type="button" /></li>
										</ul>
									</form>
									<p class="good-tips marginB10">
										<a id="btnForgetpsw" class="fr">忘记密码？</a> <span id="mes">还没有账号？</span>
										<a id="btnRegister">立即注册</a>
									</p>
									<div class="login-box marginB10">
										<button id="login_btn" type="button"
											class="btn btn-micv5 btn-block globalLogin">登录</button>
									</div>
								</section>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$("#publisInfo").click(function(){
		$("#loginModal").modal("show");
	})
	</script>
</body>
</html>