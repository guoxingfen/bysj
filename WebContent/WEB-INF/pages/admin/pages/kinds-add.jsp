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
<title>添加物品种类</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/style.css" />
</head>
<body>
<article class="page-container">
	<form action="" method="post" class="form form-horizontal" id="kinds_form">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>物品种类编码：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" placeholder="请输入物品种类编码" name="code" value="${kind.code }">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>物品种类名称：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text"  placeholder="请输入物品种类名称" name="desc" value="${kind.desc }"/>
				<input type="hidden" value="${kind.id }" name="id"/>
			</div>
		</div>
		<div class="row cl" style="margin-top:40px;">
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
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/messages_zh.js"></script> 
<script type="text/javascript">

$(function(){
	$("#kinds_form").validate({
		rules:{
			code:{
				required:true,
			},
			desc:{
				required:true,
			}
		},
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
			$(form).ajaxSubmit({
				type: 'post',
				url: '${pageContext.request.contextPath }/admin/addKinds.action',
				success: function(data){
					layer.msg('操作成功!',{icon:1,time:1000});
					setTimeout(function(){
						var index = parent.layer.getFrameIndex(window.name);
						window.parent.location.reload();
						parent.layer.close(index);
					},1000);
				},
                error: function(err){
					layer.msg('操作失败!',{icon:2,time:1000});
				}
			});
		}
	});
});
</script> 
</body>
</html>