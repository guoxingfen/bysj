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
<title>添加名言</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/style.css" />
</head>
<body>
<article class="page-container">
	<form action="" method="post" enctype="multipart/form-data"
	class="form form-horizontal" id="famousRemark_form">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span> 名言：</label>
			<div class="formControls col-xs-8 col-sm-9">
			  <c:if test="${famousRemark==null }">
			    <textarea class="textarea" placeholder="请输入名言" name="content"></textarea>
			  </c:if>
			  <c:if test="${famousRemark!=null }">
			    <textarea class="textarea" placeholder="请输入名言" name="content">${famousRemark.content }</textarea>
			  </c:if>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>来源：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text"  placeholder="请输入来源" name="from" value="${famousRemark.from }"/>
				<input type="hidden" name="id" value="${famousRemark.id }">
				<input type="hidden" name="pic" value="${famousRemark.pic }">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">&nbsp;图片：</label>
			<div class="formControls col-xs-8 col-sm-9">
			 <span class="btn-upload">
			  <a href="javascript:void();" class="btn btn-primary radius btn-upload"><i class="Hui-iconfont">&#xe642;</i> 浏览文件</a>
			  <input type="file" multiple name="picFile" class="input-file">
			</span>
		    </div>
		</div>
		
		<div class="row cl" style="margin-top:15px;">
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
	$("#famousRemark_form").validate({
		rules:{
			content:{
				required:true,
				maxlength:500,
			},
			from:{
				required:true,
			}
		},
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
			$(form).ajaxSubmit({
				type: 'post',
				url: '${pageContext.request.contextPath }/admin/addFamousRemark.action',
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