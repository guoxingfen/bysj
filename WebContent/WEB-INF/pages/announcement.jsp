<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>失物招领--公告详情</title>
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
		  minSlides:1, 
		  maxSlides:1,
		  auto:true,
		  infiniteLoop:true,
		  pager:false
	  });
	// 公告栏
	$("#slider2").bxSlider({
		mode:'vertical',
		minSlides:8,
		maxSlides:8,
		slideMargin:15,
		auto:true,
		infiniteLoop:true,
		pager:false
	})
})

</script>
</head>
<body style="margin-top:65px;">
  <jsp:include page="header.jsp"/>
     <div class="container-fluid">
     <div class="row">
       <div class="col-md-4">
         <div class="panel" style="border-bottom:0px;">
		   <div class="panel-heading" style="background-color:#47c0ff;text-align:center;color:white;">
		       <h3 class="panel-title">公告栏</h3>
		   </div>
		   <div class="panel-body" style="height:315px;background-color:#e4f6ff;margin-bottom:-10px;">
		      <c:if test="${noticeBoards==null }">
		        <h4 style="text-align:center;margin-top:30%;color:red;">暂无公告！！！</h4>
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
		    <ul class="bxslider" id="slider1">
		      <li><img alt="无法加载" src="${pageContext.request.contextPath }/images/help.png"></li>
		      <li><img alt="无法加载" src="${pageContext.request.contextPath }/images/lost.jpg"></li>
		      <li><img alt="无法加载" src="${pageContext.request.contextPath }/images/happy.jpg"></li>
		    </ul>
      </div>
     </div>
     <div class="col-md-8">
	    <div class="panel panel-default" style="height:661px;background-image:url(${pageContext.request.contextPath }/images/bg.png);">
		   <div class="panel-heading">
			 <img alt="" src="${pageContext.request.contextPath }/images/notice.jpeg" style="width:840px;height:150px;">
		   </div>
			  <div class="panel-body">
			    <c:if test="${nb!=null }">
                <h1 style="text-align:center;">${nb.title }</h1>
			    <HR style="FILTER: progid:DXImageTransform.Microsoft.Shadow(color:#987cb9,direction:145,strength:15)" width="100%" color=#987cb9 SIZE=1>
			    <c:set var="nbtime" value="${nb.createtime }"/>
		        <%
		         String str=pageContext.getAttribute("nbtime").toString();
		         String time="";
		         if(str!=null){
		        	 java.text.DateFormat format1=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			         java.text.DateFormat format2=new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",java.util.Locale.ENGLISH);
			         time=format1.format(format2.parse(str));
		         }
		        %>
			    <div style="text-align:center;">发布时间：<%=time %></div>
			    <div style="height:250px;">
			      <p style="font-size:18px;">亲爱的站友：</p>
			      <p style="text-indent:2em;font-size:18px;">${nb.detail }</p>
			    </div>
			    <div style="font-size:18px;float:right;margin-right:20px;">广医失物招领处</div><br/>
			    <img src="${pageContext.request.contextPath }/images/gy.png" style="width:60px;height:40px;float:right;margin-right:-100px;"
			    title="广医失物招领处"/>
			    </c:if>
			  </div>
		  </div>
     </div>
   </div>
  </div>
  <jsp:include page="footer.jsp"/>
</body>
</html>