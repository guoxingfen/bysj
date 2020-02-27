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
<title>添加物品</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/style.css" />
</head>
<body>
<article class="page-container">
	<form action=""  enctype="multipart/form-data"
	method="post" class="form form-horizontal" id="goods_form">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">物品类型：</label>
			<div class="formControls col-xs-8 col-sm-9 skin-minimal">
			  <div class="radio-box">
				 <input name="type" type="radio" <c:if test="${goodsInfoVo.goodsInfo.type=='Lost_Goods' }">checked</c:if>
				 id="lost" value="Lost_Goods">
				 <label for="lost">失物</label>
			  </div>
			  <div class="radio-box">
				 <input name="type" type="radio" <c:if test="${goodsInfoVo.goodsInfo.type=='Get_Goods' }">checked</c:if>
				 value="Get_Goods" id="get">
				 <label for="get">招领</label>
			  </div>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>物品种类：</label>
			<div class="formControls col-xs-8 col-sm-9">
			  <span class="select-box">
				<select class="select" size="1" name="kid">
					<option disabled='disabled' selected>请选择物品种类 </option>
					<c:forEach items="${kinds }" var="kind">
					  <option value="${kind.id }"
					  <c:if test="${kind.id==goodsInfoVo.goodsInfo.kid }">selected = "selected" </c:if>
					  >${kind.desc }</option>
				    </c:forEach>
				</select>
			 </span>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>标题：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${goodsInfoVo.goodsInfo.title }"
				placeholder="请输入物品信息标题" name="title">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>详情：</label>
			<div class="formControls col-xs-8 col-sm-9">
			  <c:if test="${goodsInfoVo==null }">
			    <textarea class="textarea" placeholder="请输入物品信息详情" name="detail"></textarea>
			  </c:if>
			  <c:if test="${goodsInfoVo!=null }">
			    <textarea class="textarea" placeholder="请输入物品信息详情" name="detail">${goodsInfoVo.goodsInfo.detail }</textarea>
			  </c:if>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">物品图片：</label>
			<div class="formControls col-xs-8 col-sm-9">
			 <span class="btn-upload form-group">
				<input class="input-text upload-url" type="text" name="uploadfile-2" id="uploadfile-2" readonly style="width:200px">
				<a href="javascript:void();" class="btn btn-primary upload-btn"><i class="Hui-iconfont">&#xe642;</i> 浏览文件</a>
				<input type="file" multiple name="picFile" class="input-file">
				<input type="hidden" name="pic" value="${goodsInfoVo.goodsInfo.pic }">
			 </span> 
		    </div>
		</div>
		<div class="row cl">
		  <c:set var="date">${goodsInfoVo.goodsInfo.date } </c:set>
			 <%
			   String str=pageContext.getAttribute("date").toString();
			   String ll="";
			   java.text.DateFormat format1=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			   java.text.DateFormat format2=new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",java.util.Locale.ENGLISH);
			   if(!"".equals(str)){
			      ll=format1.format(format2.parse(str));
			   }
			   pageContext.setAttribute("date", ll);
			%>
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>丢失/拾到时间：</label>
			<div class="formControls col-xs-8 col-sm-9">
			 <input type="text" name="date" value="${date }"
			 class="input-text Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd HH:mm:ss'})">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>丢失/拾到地点：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${goodsInfoVo.goodsInfo.address }"
				name="address" placeholder="请输入丢失或拾到物品的具体地点"/>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>联系地点：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${goodsInfoVo.goodsInfo.contact_address }"
				name="contact_address"  placeholder="请输入联系你的具体地点"/>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>手机号码：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${goodsInfoVo.goodsInfo.phone }"  name="phone"  placeholder="请输入你的联系号码"/>
				<input type="hidden" name="id" value="${goodsInfoVo.goodsInfo.id }">
				<input type="hidden" name="sid" value="${goodsInfoVo.goodsInfo.sid }">
				<input type="hidden" name="pageview" value="${goodsInfoVo.goodsInfo.pageview }">
				<input type="hidden" name="status" value="${goodsInfoVo.goodsInfo.status }">
			</div>
		</div>
		<div class="row cl">
		 <div class="col-xs-offset-5 col-sm-offset-5">
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
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery.validate.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/validate-methods.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/messages_zh.js"></script> 
<script type="text/javascript">
$(function(){
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	$("#goods_form").validate({
		rules:{
			kid:{
				required:true,
			},
			title:{
				required:true,
			},
			detail:{
				required:true,
			},
			date:{
				required:true,
			},
			address:{
				required:true,
			},
			contact_address:{
				required:true,
			},
			phone:{
				required:true,
				isMobile:true,
			}
		},
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
			$(form).ajaxSubmit({
				type: 'post',
				url: '${pageContext.request.contextPath }/admin/addGoods.action',
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