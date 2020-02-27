<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5shiv.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<![endif]-->
<title>失物招领后台管理系统--登录</title>
<link href="${pageContext.request.contextPath }/admin/css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/admin/css/H-ui.login.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/admin/css/style.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/admin/css/iconfont.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/layer.js"></script>
</head>
<script type="text/javascript">
$(document).ready(function(){
	// 改变验证码
	$("#changebtn").click(function(){
		var date=new Date().getTime();
		var src="${pageContext.request.contextPath}/admin/checkCode.action?time="+date;
		$("#img").attr("src",src);
	})
	
	// 登录 
	$("#loginbtn").click(function(){
		var username=$("#username").val();
		var password=$("#password").val();
		var code=$("#code").val();
		if(username!=''&&password!=''&&code!=''){
			$.ajax({
				type: 'POST',
				url: '${pageContext.request.contextPath }/admin/loginAdmin.action',
				data:$("#login_form").serializeArray(),
				dataType: 'json',
				success: function(data){
					if(data.code=='SUCCESS'){
						// 跳转到主页
						var id=data.obj.id;
						window.location.href='${pageContext.request.contextPath}/admin/toPreIndexAdmin.action?id='+id;
					}else{
						layer.msg(data.message, {icon: 5,time:2000});
					}
				},
			});	
		}else{
			layer.msg("账户或密码不能为空！", {icon: 5,time:2000});
		}
	})
	
	
// 保存账户与密码
$("#rr").change(function(){
	$.ajax({
		type: 'POST',
		url: '${pageContext.request.contextPath }/admin/keepStatus.action',
		data:$("#login_form").serializeArray(),
		dataType: 'json',
		async:false,
		success: function(data){
			
		},
	});
})
	
})






</script>
<body>
<div class="header">
  <h3 style="text-align:center;color:#fff;">失物招领管理员后台系统</h3>
</div>
<div class="loginWraper">
  <div id="loginform" class="loginBox">
    <form class="form form-horizontal" action="" method="post" id="login_form">
      <div class="row cl">
        <label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60d;</i></label>
        <div class="formControls col-xs-8">
          <input name="username" type="text" id="username" value="${cookie.username.value }"
           placeholder="账户" class="input-text size-L">
        </div>
      </div>
      <div class="row cl">
        <label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60e;</i></label>
        <div class="formControls col-xs-8">
          <input name="password" type="password" value="${cookie.password.value }"
          id="password"  placeholder="密码" class="input-text size-L">
        </div>
      </div>
      <div class="row cl">
        <div class="formControls col-xs-8 col-xs-offset-3">
          <input class="input-text size-L" type="text" id="code" 
          name="code"  placeholder="验证码" onblur="if(this.value==''){this.value='验证码:'}" onclick="if(this.value=='验证码:'){this.value='';}" value="验证码:" style="width:150px;">
          <img src="${pageContext.request.contextPath}/admin/checkCode.action" alt="加载中" id="img"> 
          <a id="changebtn">看不清，换一张</a> 
        </div>
      </div>
      <div class="row cl">
        <div class="formControls col-xs-8 col-xs-offset-3">
          <label for="online">
            <input type="checkbox" name="rr" id="rr" <c:if test="${cookie.rr!=null }">checked="checked"</c:if> />
            记住账户和密码</label>
        </div>
      </div>
      <div class="row cl">
        <div class="formControls col-xs-8 col-xs-offset-3">
          <input id="loginbtn"  type="button" class="btn btn-success radius size-L" value="&nbsp;登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;">
          <input  type="reset" class="btn btn-warning radius size-L" value="&nbsp;取&nbsp;&nbsp;&nbsp;&nbsp;消&nbsp;">
        </div>
      </div>
    </form>
  </div>
</div>
<div class="footer">Copyright &copy; 失物招领后台管理 </div>
</body>
</html>