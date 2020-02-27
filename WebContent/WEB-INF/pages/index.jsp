<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>失物招领--首页</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/jquery.bxslider.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.bxslider.min.js"></script>
<style type="text/css">
a:link,a:visited{text-decoration:none !important}
a:active,a:hover{text-decoration:none !important;cursor:pointer}

</style>
<script type="text/javascript">
$(document).ready(function(){
	// 轮播图片
	$("#slider1").bxSlider({
		  slideWidth: 2000, 
		  controls:true,
		  minSlides:5, 
		  maxSlides:5,
		  auto:true,
		  pause:8000,
		  infiniteLoop:true,
		  autoHover:true
	  });
	// 公告栏
	$("#slider2").bxSlider({
		mode:'vertical',
		minSlides:4,
		maxSlides:4,
		slideMargin:15,
		auto:true,
		infiniteLoop:true,
		pager:false
	})
	// 判断表扬对象是否存在
	$("#praise_uname").change(function(){
		var uname=$("#praise_uname").val();
		$.post("${pageContext.request.contextPath}/queryStu.action",{"uname":uname},function(data){
			if(data.code=='FAIL'){
				$("#praise_uname").val("");
				$("#praise_uname").attr("placeholder",data.message);
				$("#praise_uname").addClass("invalid");
				$("#praise_uname").focus();
				$("#uname_error").css("display","block");
			}else{
				$("#uname_error").css("display","none");
			}
		})
	})
	// 添加表扬信
	$("#send_praise").click(function(){
		var uname=$("#praise_uname").val();
		var content=$("#praise_content").val();
		var fromSid="${stuInfo.id}";
		if(uname==''||content==''){
			alert("表扬对象或表扬内容不能为空！！！");
		}else{
			$.post("${pageContext.request.contextPath}/addPraise.action",
					{"uname":uname,"content":content,"fromSid":fromSid},
					function(data){
						if(data.code=='SUCCESS'){
							//layer.msg("发送成功",{icon:1,time:1000});
							alert("发送成功");
							$("#praise_uname").val("");
							content=$("#praise_content").val("");
							$("#send_praise").blur();
						}
					})
		}
	})
})

</script>
</head>
<body style="margin-top:65px;">
  <jsp:include page="header.jsp"/>
	<div class="container-fluid">
		<div class="panel panel-info">
		  <div class="panel-heading">
		    <h3 class="panel-title">寻物||领物信息</h3>
		  </div>
		  <div class="panel-body" style="padding:10px;margin-bottom:-35px;">
		    <div style="padding-left:20px;padding-right:20px;">
		     <c:choose>
		       <c:when test="${goodsPicNotNull==null }">
		         <h3 style="text-align:center;margin-bottom:35px;color:red;">暂无信息</h3>
		       </c:when>
		       <c:otherwise>
		         <ul class="bxslider" id="slider1">
			        <c:forEach items="${goodsPicNotNull }" var="goods">
			         <c:if test="${goods.type=='Lost_Goods'}">
			           <c:set var="title">【寻物启事】${goods.title }</c:set>
			         </c:if>
			         <c:if test="${goods.type=='Get_Goods'}">
			           <c:set var="title">【招领启事】${goods.title }</c:set>
			         </c:if>
			          <li>
			            <a href="${pageContext.request.contextPath }/lookUpGoods.action?gid=${goods.id}&sid=${stuInfo.id}">
			              <img src="/pic/${goods.pic }" alt="无法加载" title="${title }" style="height:200px;width:200px;" class="img-thumbnail">
			            </a>
			          </li>
			        </c:forEach>
			      </ul>
		       </c:otherwise>
		     </c:choose>
		    </div>
		  </div>
		</div>
	</div>
	<div class="container-fluid">
		<div class="row">
		   <div class="col-xs-5 col-md-3">
		      <div class="panel">
		         <div class="panel-heading" style="text-align:center;color:white;background-color:#6cffbf">
		           <h3 class="panel-title">今日天气</h3>
		         </div>
		         <div class="panel-body" style="padding-left:65px;">
		            <iframe name="weather_inc" src="http://i.tianqi.com/index.php?c=code&id=12" width="200" height="80" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
		         </div>
		         <div class="panel-heading" style="background-color:#47c0ff;text-align:center;color:white;">
		           <h3 class="panel-title">公告栏</h3>
		         </div>
		         <div class="panel-body" style="height:160px;background-color:#e4f6ff;margin-bottom:-10px;">
		             <c:if test="${noticeBoards==null }">
		              <h4 style="text-align:center;margin-top:20%;color:red;">暂无公告！！！</h4>
		             </c:if>
		             <c:if test="${noticeBoards!=null }">
		             <div style="margin-bottom:20px;">
		               <ul class="bxslider" id="slider2"  style="background-color:#e4f6ff;">
		                 <c:forEach items="${noticeBoards }" var="noticeBoard">
		                   <li><a href="${pageContext.request.contextPath }/lookupnotice.action?id=${noticeBoard.id }">${noticeBoard.title }</a></li>
		                 </c:forEach>
		               </ul>
		              </div>
		            </c:if>
		         </div>
		         <!-- 表扬区 -->
		         <div class="panel-heading" style="text-align:center;color:white;background-color:#47c0ff;margin-top:10px;">
				    <h3 class="panel-title">我要表扬</h3>
				 </div>
				 <div class="panel-body" style="background-color:#d0fdd0;margin-top:5px;">
				   <c:if test="${stuInfo==null }">
				      <h4 style="text-align:center;margin-top:27%;margin-bottom:100px;color:red;">登录后即可发表扬信！</h4>
				   </c:if>
				   <c:if test="${stuInfo!=null }">
				    <form class="form-horizontal" method="post">
					  <div class="form-group">
					   <label class="col-sm-2 control-label"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></label>
					   <div class="col-sm-10">
					      <input type="text" class="form-control" id="praise_uname" placeholder="请输入表扬对象" style="color:blue;">
					      <span class="glyphicon glyphicon-remove-sign" id="uname_error" style="float:right;margin-top:-25px;margin-right:10px;display:none;"></span>
					   </div>
					  </div>
					  <div class="form-group">
					  <label class="col-sm-2 control-label"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span></label>
					  <div class="col-sm-10">
					      <textarea class="form-control" rows="4" id="praise_content" placeholder="请输入表扬内容" style="color:green;"></textarea>
					  </div>
					  </div>
					  <button type="button" id="send_praise" class="btn btn-success" style="margin-left:50px;">
					   <span class="glyphicon glyphicon-send">发送</span>
					  </button>
					  <button type="reset" class="btn btn-danger" style="margin-left:20px;">
					   <span class="glyphicon glyphicon-remove">取消</span>
					  </button>
					</form>
				   </c:if>
				 </div>
		         
		      </div>
		   </div>
		   <div class="col-xs-13 col-md-9">
		      <div class="row">
		         <div class="col-xs-6 col-md-6">
		            <div class="panel panel-default" style="height:600px;">
		              <div class="panel-heading">
		                 <h4 style="display:inline;">寻物启事</h4>
		                 <a href="${pageContext.request.contextPath }/forlost.action?pageNumber=1" 
		                 style="float:right;">更多<span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></a>
		              </div>
		              <c:if test="${lostGoods==null }">
		                <h3 style="text-align:center;margin-top:50px;color:red;">暂无消息</h3>    
		              </c:if>
		                <table class="table table-hover">
		                  <c:forEach items="${lostGoods }" var="goods">
		                    <c:set var="date" value="${goods.publish_date }" scope="request"/>
		                    <%
		                    java.text.DateFormat format1=new java.text.SimpleDateFormat("yyyy-MM-dd");
		                    java.text.DateFormat format2=new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",java.util.Locale.ENGLISH);
		                    String time=format1.format(format2.parse(request.getAttribute("date").toString()));
		                    %>
						   <tr>
							 <td><a href="${pageContext.request.contextPath }/lookUpGoods.action?gid=${goods.id}&sid=${stuInfo.id}">${goods.title }</a></td>
							 <td style="text-align:right;"><%=time %></td>
						   </tr>
						   </c:forEach>
					   </table>
		            </div>
		         </div>
		         <div class="col-xs-6 col-md-6">
		            <div class="panel panel-default" style="height:600px;">
		              <div class="panel-heading">
		                 <h4 style="display:inline;">招领启事</h4>
		                 <a href="${pageContext.request.contextPath }/forget.action?pageNumber=1" 
		                 style="float:right;">更多<span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></a>
		              </div>
		              <c:if test="${getGoods==null }">
		                 <h3 style="text-align:center;margin-top:50px;color:red;">暂无消息</h3>    
		              </c:if>
		                <table class="table table-hover">
		                   <c:forEach items="${getGoods }" var="goods">
		                    <c:set var="date" value="${goods.publish_date }" scope="request"/>
		                    <%
		                    java.text.DateFormat format1=new java.text.SimpleDateFormat("yyyy-MM-dd");
		                    java.text.DateFormat format2=new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",java.util.Locale.ENGLISH);
		                    String time=format1.format(format2.parse(request.getAttribute("date").toString()));
		                    %>
						   <tr>
							 <td><a href="${pageContext.request.contextPath }/lookUpGoods.action?gid=${goods.id}&sid=${stuInfo.id}">${goods.title }</a></td>
							 <td style="text-align:right;"><%=time %></td>
						   </tr>
						   </c:forEach>
					   </table>
		            </div>
		         </div>
		      </div>
		   </div>
		</div>
	</div>
  <jsp:include page="footer.jsp"/>
</body>
</html>