<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>失物招领--留言中心</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<style type="text/css">
a:link,a:visited{text-decoration:none !important}
a:active,a:hover{text-decoration:none !important;cursor:pointer}

</style>
<script type="text/javascript">
$(document).ready(function(){
	
})

</script>
</head>
<body style="margin-top:65px;">
  <jsp:include page="header.jsp"/>
	<div class="container-fluid">
	 <div class="row">
	   <div class="col-md-4">
	     <div class="panel panel-default">
		   <!-- Default panel contents -->
		   <div class="panel-heading" style="background-color:#9DC45F">留言注意事项</div>
		   <!-- List group -->
		   <ul class="list-group">
			 <li class="list-group-item">网站管理人员有权删除留言中的违法违规言论以及不良内容。</li>
			 <li class="list-group-item">请承担一切因你的言论而直接或间接导致的民事或刑事法律责任。</li>
			 <li class="list-group-item">请遵守国家有关法律法规的管理规定，尊重网上道德，使用文明语言。</li>
			 <li class="list-group-item">本栏目非论坛性质，只用于网站管理员和公众之间的交流，不用于公众之间的交流</li>
			 <li class="list-group-item">请勿发表任何形式的广告，禁止企业推广产品或服务</li>
		   </ul>
		</div>
	     <div class="panel panel-info">
		  <div class="panel-heading">
		    <h3 class="panel-title">留言发布</h3>
		  </div>
		  <div class="panel-body">
		    <c:if test="${stuInfo==null }">
		      <h3 style="color:red;text-align:center;margin-top:20px;">登录后即可留言!!!</h3>
		    </c:if>
		    <c:if test="${stuInfo!=null }">
		    <form action="${pageContext.request.contextPath }/addLeaMes.action" method="post">
			 <div class="form-group">
			  <input type="hidden" name="sid" value="${stuInfo.id }"/>
			  <textarea rows="6" class="form-control" placeholder="请输入留言！！！" name="message"></textarea>
		     </div>
		     <button class="btn btn-success" type="submit">发布</button>
		     <button class="btn btn-warning" type="reset">重置</button>
		   </form>
		   </c:if>
		  </div>
		 </div>
	   </div>
	   <div class="col-md-8">
	     <div class="panel panel-warning">
		  <div class="panel-heading">
		    <h3 class="panel-title">公众留言区<span>（<c:if test="${leaMes_pageModel!=null }">${leaMes_pageModel.totalRecord }</c:if>条）</span></h3>
		  </div>
		  <div class="panel-body">
		    <ul class="list-unstyled" style="height:700px;">
		     <c:forEach items="${leaMes_pageModel.data }" var="leames">
		      <li>
			    <c:if test="${leames.pic!=null&&leames.pic!='' }">
			     <img src="/pic/${leames.pic }" alt="正在加载" class="img-circle" width="50px" height="50px" style="margin-bottom:-25px;"/>
			    </c:if>
			    <c:if test="${leames.pic==null||leames.pic=='' }">
			     <img src="${pageContext.request.contextPath }/images/test.jpg" alt="正在加载" class="img-circle" width="50px" height="50px" style="margin-bottom:-25px;"/>
			    </c:if>
			    <c:if test="${leames.uname==null }">
			      <strong style="color:red;">管理员</strong>
			    </c:if>
			    <c:if test="${leames.uname!=null }">
			      <strong>${leames.uname }</strong>
			    </c:if>
			    
			    <br/>
			    <p style="margin-left:55px;">
			             ${leames.message }
			    </p>
			    <c:set var="ldate">${leames.date }</c:set>
	           <%
	              String str=pageContext.getAttribute("ldate").toString();
	              String ll="";
	              java.text.DateFormat format1=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			      java.text.DateFormat format2=new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",java.util.Locale.ENGLISH);
	              if(!"".equals(str)){
			          ll=format1.format(format2.parse(str));
	              }
		       %>
			    <p style="float:right;">留言时间：<span><%=ll %></span></p>
			    <hr style="margin-top:40px;">
			  </li>
			  </c:forEach>
		    </ul>
		  <div style="text-align:center;">
		   <c:if test="${leaMes_pageModel.totalPage>1 }">
		    <nav aria-label="Page navigation">
			  <ul class="pagination">
			    <li>
			      <a <c:if test="${leaMes_pageModel.pageNumber==1 }">class="btn disabled"</c:if>
			      href="${pageContext.request.contextPath }/queryAllLeaMes.action?pageNumber=${leaMes_pageModel.pageNumber-1}" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			    <c:forEach begin="${1 }" end="${leaMes_pageModel.totalPage }" var="i">
			    <li <c:if test="${leaMes_pageModel.pageNumber==i }">class="active"</c:if>>
			     <a href="${pageContext.request.contextPath }/queryAllLeaMes.action?pageNumber=${i}">${i }</a></li>
			    </c:forEach>
			    <li>
			      <a <c:if test="${leaMes_pageModel.pageNumber==leaMes_pageModel.totalPage }">class="btn disabled"</c:if>
			      href="${pageContext.request.contextPath }/queryAllLeaMes.action?pageNumber=${leaMes_pageModel.pageNumber+1}" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			  </ul>
			</nav>
			</c:if>
		  </div>
		  </div>
		</div>
	   </div>
	 </div>
	</div>
  <jsp:include page="footer.jsp"/>
</body>
</html>