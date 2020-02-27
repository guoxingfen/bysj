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
<title>修改密码</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/style.css" />
</head>
<body>
<article class="page-container">
	<form action="" method="post" class="form form-horizontal" id="admin_form">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>旧密码：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" id="old_pwd"
				name="old_pwd" placeholder="请输入旧密码"/>
				<input type="hidden" name="id" value="${htuser.id }">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>新密码：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="password" id="new_pwd" class="input-text" name="new_pwd"  placeholder="请输入新密码"/>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>确认新密码：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="password" class="input-text" name="pwd"  placeholder="请重新输入新密码"/>
			</div>
		</div>
		
		<div class="row cl">
		 <div class="col-xs-offset-4 col-sm-offset-4">
		  <button class="btn btn-primary radius" type="submit">提交</button>
		  <button class="btn btn-warning radius" type="reset" style="margin-left:50px;">重置</button>
		 </div>
		</div>
	</form>
</article>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/H-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/H-ui.admin.js"></script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery.validate.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/validate-methods.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/messages_zh.js"></script> 
<script type="text/javascript">

$(function(){
	$("#admin_form").validate({
		rules:{
			old_pwd:{
				required:true,
			},
			new_pwd:{
				required:true,
			},
			pwd:{
				required:true,
				equalTo: "#new_pwd",
			}
		},
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
			$(form).ajaxSubmit({
				type: 'post',
				url: '${pageContext.request.contextPath }/admin/changePwd.action',
				success: function(data){
					if(data.code=='SUCCESS'){
						layer.msg('修改成功!',{icon:1,time:1000});
						setTimeout(function(){
							var index = parent.layer.getFrameIndex(window.name);
							//window.parent.location.reload();
							parent.layer.close(index);
						},1000);
					}else{
						layer.msg(data.message,{icon:2,time:1000});
						$("#old_pwd").val('');
						$("#old_pwd").focus();
					}
					
				}
			});
		}
	});
});
</script> 
</body>
</html>