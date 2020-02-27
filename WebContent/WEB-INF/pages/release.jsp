<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>失物招领--发布信息</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/jquery.bxslider.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/WdatePicker.js"></script>
<style type="text/css">
a:link,a:visited{text-decoration:none !important}
a:active,a:hover{text-decoration:none !important;cursor:pointer}

</style>
<script type="text/javascript">
$(document).ready(function(){
	// 界面
    $("#type_lost").click(function(){
    	$("#change_address").html("丢失地点");
    	$("#time_label").html("丢失时间");
    })
    $("#type_get").click(function(){
    	$("#change_address").html("捡拾地点");
    	$("#time_label").html("捡拾时间");
    })
   // 验证并提交
   $("#goods_submit").click(function(){
	   if($("#title").val()==""){
		   alert("标题不能为空");
	   }else if($("#detail").val()==""){
		   alert("信息详情不能为空");
	   }else if($("#myId").val()==''){
		   // 打开登录界面
		   $("#loginModal").modal("show");
	   }else{
		   // 提交表单
		   $("#goods_form").submit();
	   }
   })
   
   // 没有登录时，提示两下请先登录
  //myId
   $("#title").change(function(){
	   if(""==$("#myId").val()){
		   $("#loginModal").modal("show");
	   }
   })
  $("#detail").change(function(){
	  if(''==$("#myId").val()){
			$("#loginModal").modal("show");
		}
  })
   
 // 为下面的轮播图片赋值
 $("#kid").change(function(){
	 var type="";
	 if($("#type_lost").prop("checked")){
		 type=$("#type_get").val();
	 }
	 if($("#type_get").prop("checked")){
		 type=$("#type_lost").val();
	 }
	 var kid=$("#kid").val();
	 // 发送请求
	 $.post("${pageContext.request.contextPath}/changePic.action",
			 {"type":type,"kid":kid},
			 function(data){
				 if(data.code=='SUCCESS'){
					 $.each(data.obj,function(key,value){
						var txt="";
						if(value.type=='Lost_Goods'){
							txt="寻物启事";
						}else{
							txt="招领启事";
						}
						var title="【"+txt+"】"+value.title;
						$("#slider3 li img")[key+1].src="/pic/"+value.pic;
						$("#slider3 li img")[key+1].title=title;
						$("#slider3 li a")[key+1].href="${pageContext.request.contextPath }/lookUpGoods.action?gid="+value.id+"&sid=${stuInfo.id}";
					 });
					 
				 }
			 })
 })
 
//轮播图片
$("#slider3").bxSlider({
     minSlides:1, 
     maxSlides:1,
     auto:true,
     pause:8000,
     infiniteLoop:true
     
  });
 
   
})

</script>
</head>
<body style="margin-top:65px;">
  <jsp:include page="header.jsp"/>
  <div class="container-fluid">
        <div class="row">
          <div class="col-md-8">
                <div class="panel panel-info">
		          <div class="panel-heading">
		            <h3 class="panel-title">发布信息</h3>
		          </div>
		          <div class="panel-body">
				 <form class="form-horizontal"  id="goods_form" method="post" 
				 enctype="multipart/form-data" action="${pageContext.request.contextPath }/addGoodsInfo.action">
				    <div class="form-group">
					   <label for="type" class="col-sm-2 col-sm-offset-2 control-label">信息类型</label>
					   <div class="col-sm-5">
					     <label class="radio-inline">
	                        <input type="radio" name="type" checked="checked" id="type_lost" value="Lost_Goods">失物启事
	                     </label>
	                     <label class="radio-inline">
	                        <input type="radio" name="type" id="type_get" value="Get_Goods">招领启事
	                     </label>
					   </div>
					</div>
				    <div class="form-group">
					   <label for="kid" class="col-sm-2 col-sm-offset-2 control-label">物品类型</label> 
					   <div class="col-sm-5">
					     <select class="form-control" name="kid" id="kid">
					       <c:forEach items="${kinds }" var="kind">
						    <option value="${kind.id }">${kind.desc }</option>
						   </c:forEach>
						 </select>
					   </div>
					</div>
					<div class="form-group">
					   <label for="title" class="col-sm-2 col-sm-offset-2 control-label">信息标题</label> 
					   <div class="col-sm-5">
					     <input type="text" class="form-control" id="title" name="title" placeholder="请输入信息标题，不大于25个字" maxlength="25">
					   </div>
					</div>
					<div class="form-group">
					   <label for="detail" class="col-sm-2 col-sm-offset-2 control-label">信息详情</label> 
					   <div class="col-sm-5">
					     <textarea class="form-control" id="detail" name="detail" rows="4"></textarea>
					   </div>
					</div>
					<div class="form-group">
					   <label for="picutreFile" class="col-sm-2 col-sm-offset-2 control-label">上传图片</label> 
					   <div class="col-sm-5">
					     <input type="file" class="form-control" id="pictureFile" name="pictureFile">
					   </div>
					</div>
					<div class="form-group">
					   <label for="address" id="change_address" class="col-sm-2 col-sm-offset-2 control-label">丢失地点</label> 
					   <div class="col-sm-5">
					     <input type="text" placeholder="请输入地点" id="address" name="address" class="form-control"/>
					   </div>
					</div>
					<div class="form-group">
					   <label for="date" id="time_label" class="col-sm-2 col-sm-offset-2 control-label">丢失时间</label> 
					   <div class="col-sm-5">
					     <input type="text" name="date" id="date"
			 class="input-text Wdate form-control" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd HH:mm:ss'})">
					   </div>
					</div>
					<div class="form-group">
					   <label for="contact_address" class="col-sm-2 col-sm-offset-2 control-label">联系地址</label> 
					   <div class="col-sm-5">
					     <input type="text" class="form-control" id="contact_address" name="contact_address" placeholder="请输入联系地址">
					   </div>
					</div>
					<input type="hidden" name="sid" id="myId" value="${stuInfo.id }">
					<div class="col-sm-offset-5">
					  <button type="reset" class="btn btn-primary">重置</button>
					  <button type="button" class="btn btn-success" style="margin-left:100px;" id="goods_submit">提交</button>
					</div>
				</form>
				</div>
				</div>
         </div>
         <div class="col-md-4">
         <div class="panel panel-warning">
			<div class="panel-heading">
              <h3 class="panel-title" style="display:inline;">好人榜：</h3>
              <span><small>拾到物品最多的前五位</small></span>
            </div>
            <ul class="list-group">
              <c:forEach items="${goodManList }" var="goodMan">
			  <li class="list-group-item list-group-item-info">
				 <span class="badge">${goodMan.frequency }</span>
				<c:if test="${goodMan.uname!=null }">
				 <a href="${pageContext.request.contextPath }/queryStuAllInfo.action?sid=${goodMan.sid}&pageNumber=1">${goodMan.uname }</a>
				</c:if>
				<!-- 测试 -->
				<c:if test="${goodMan.uname==null }">
				  <a href="#">剑无双</a>
				</c:if>
			  </li>
			  </c:forEach>
			  <c:if test="${fmt:length(goodManList)<5 }">
			    <c:forEach begin="1" end="${5-fmt:length(goodManList) }">
			      <li class="list-group-item list-group-item-info">
				    <span class="badge"></span>
				    <a href="#">待加入...</a>
			      </li>
			    </c:forEach>
			  </c:if>
           </ul>
		</div>
         <div class="panel panel-danger">
			<div class="panel-heading">
              <h3 class="panel-title">类似物品</h3>
            </div>
            <div  class="panel-body" style="height:242px;">
            <ul id="slider3">
			  <li><a>
			    <img style="height:200px;width:400px;"  src="${pageContext.request.contextPath }/images/jz.gif"/>
			   </a>
			  </li>
			  <li><a>
			    <img style="height:200px;width:400px;"  src="${pageContext.request.contextPath }/images/jz.gif"/>
			   </a>
			  </li>
			  <li><a>
			    <img style="height:200px;width:400px;"  src="${pageContext.request.contextPath }/images/jz.gif"/>
			   </a>
			  </li>
			  <li><a>
			    <img style="height:200px;width:400px;"  src="${pageContext.request.contextPath }/images/jz.gif"/>
			   </a>
			  </li>
			  <li><a>
			    <img style="height:200px;width:400px;"  src="${pageContext.request.contextPath }/images/jz.gif"/>
			   </a>
			  </li>
           </ul>
           </div>
		</div>
		</div>
		</div>
	   </div>  
  <jsp:include page="footer.jsp"/>
</body>
</html>