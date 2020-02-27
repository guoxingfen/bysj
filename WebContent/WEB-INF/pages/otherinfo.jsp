<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>失物招领--他人信息</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<style type="text/css">
a:link,a:visited{text-decoration:none !important}
a:active,a:hover{text-decoration:none !important;cursor:pointer}

</style>
<script type="text/javascript">
//寻物查询
// 招领查询
// 排序
function queryGoods(pageNumber){
	// 设置当前页数
	$("#pageNumber").val(pageNumber);
	// 提交表单
	$("#search_form").submit();
}
$(document).ready(function(){
	
	
})

</script>
</head>
<body style="margin-top:65px;">
  <jsp:include page="header.jsp"/>
    <div class="container-fluid">
     <div class="row">
      <div class="col-md-4">
      <div class="panel panel-info">
	   <div class="panel-heading">
	    <h3 class="panel-title" style="text-align:center;">个人信息</h3>
	   </div>
	   <div class="panel-body">
	     <div class="thumbnail">
	      <c:if test="${otherStuInfo.pic==null||otherStuInfo.pic=='' }">
	        <img alt="" src="${pageContext.request.contextPath }/images/test.jpg" class="img-circle" style="width:150px;height:150px;">
	      </c:if>
	      <c:if test="${otherStuInfo.pic!=null&&otherStuInfo.pic!='' }">
	        <img alt="" src="/pic/${otherStuInfo.pic }" class="img-circle" style="width:150px;height:150px;">
	      </c:if>
	      <div class="caption" style="algin:center;">
	        <table class="table table-striped">
	          <tbody>
	           <tr><td style="width:100px;">用户名：</td><td>${otherStuInfo.uname }</td></tr>
	           <c:if test="${otherStuInfo.unumber==null }">
	             <tr><td>学号：</td><td>未知</td></tr>
	           </c:if>
	           <c:if test="${otherStuInfo.unumber!=null }">
		         <tr><td>学号：</td><td>${otherStuInfo.unumber }</td></tr>
		       </c:if>
		       <c:if test="${otherStuInfo.sex==0 }">
		         <c:set var="sex" value="女"/>
		       </c:if>
		       <c:if test="${otherStuInfo.sex==1 }">
		         <c:set var="sex" value="男"/>
		       </c:if>
		       <c:if test="${otherStuInfo.sex==null }">
		         <tr><td>性别：</td><td>未知</td></tr>
		       </c:if>
		       <c:if test="${otherStuInfo.sex!=null }">
		         <tr><td>性别：</td><td>${sex }</td></tr>
		       </c:if>
		       <c:if test="${otherStuInfo.uclass==null }">
		         <tr><td>班级：</td><td>未知</td></tr>
		       </c:if>
		       <c:if test="${otherStuInfo.uclass!=null }">
		         <tr><td>班级：</td><td>${otherStuInfo.uclass }班</td></tr>
		       </c:if>
		       <c:if test="${otherStuInfo.major==null }">
		         <tr><td>专业：</td><td>未知</td></tr>
		       </c:if>
		       <c:if test="${otherStuInfo.major!=null }">
		         <tr><td>专业：</td><td>${otherStuInfo.major }</td></tr>
		       </c:if>
		       <c:if test="${otherStuInfo.institute==null }">
		         <tr><td>学院：</td><td>未知</td></tr>
		       </c:if>
		       <c:if test="${otherStuInfo.institute!=null }">
		         <tr><td>学院：</td><td>${otherStuInfo.institute }</td></tr>
		       </c:if>
	          </tbody>
	        </table>
	      </div>
	     </div>
	   </div>
	  </div>
	  </div>
	  <div class="col-md-8">
	    <div class="panel panel-warning">
		  <div class="panel-heading">
		    <h3 class="panel-title">发布信息（共<span style="color:red;">${pageModel.totalRecord }</span>条数据）</h3>
		  </div>
		  <div class="panel-body"  style="height:370px;">
		  <form class="form-inline" style="margin-left:10px;" action="${pageContext.request.contextPath }/queryStuAllInfo.action" method="post" id="search_form">
		     <label>类型：</label>
		     <label class="checkbox-inline">
               <input type="checkbox" value="Lost_Goods" <c:if test="${queryFactor.lost!=null }">checked="checked"</c:if> 
               name="lost" onclick="queryGoods(1);">寻物
             </label>
		     <label class="checkbox-inline">
                <input type="checkbox" value="Get_Goods" <c:if test="${queryFactor.get!=null }">checked="checked"</c:if>
                name="get" onclick="queryGoods(1);">招领
              </label>
              <input type="hidden" name="pageNumber" id="pageNumber"/>
              <input name="sid" type="hidden" value="${otherStuInfo.id }"/>
             <label style="margin-left:240px;"> 排序：</label>
             <label class="radio-inline">
			  <input type="radio" name="sort" value="1" <c:if test="${queryFactor.sort==1 }">checked="checked"</c:if>
			   onclick="queryGoods(1);">升序
			 </label>
			 <label class="radio-inline">
			  <input type="radio" name="sort" value="0" <c:if test="${queryFactor.sort==0 }">checked="checked"</c:if>
			   onclick="queryGoods(1);">降序
			 </label>
		    </form>
		    <table class="table table-hover">
		     <c:forEach items="${pageModel.data }" var="goods">
		       <c:if test="${goods.type=='Lost_Goods' }">
		         <c:set value="寻物" var="type"/>
		       </c:if>
		       <c:if test="${goods.type=='Get_Goods' }">
		         <c:set value="招领" var="type"/>
		       </c:if>
		       <c:if test="${goods.type==null }">
		         <c:set value="未知" var="type"/>
		       </c:if>
			  <tr>
			    <td>${type }</td>
			    <td>${goods.title }</td>
			    <c:set var="goods_createtime">${goods.publish_date }</c:set>
	           <%
	              String str=pageContext.getAttribute("goods_createtime").toString();
	              String publish_goods="";
	              java.text.DateFormat format1=new java.text.SimpleDateFormat("yyyy-MM-dd");
			      java.text.DateFormat format2=new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",java.util.Locale.ENGLISH);
	              if(!"".equals(str)){
			          publish_goods=format1.format(format2.parse(str));
	              }
		       %>
			    <td><%=publish_goods %></td>
			    <td>
			      <a href="${pageContext.request.contextPath }/lookUpGoods.action?gid=${goods.id}&sid=${otherStuInfo.id}">查看</a>
			    </td>
			  </tr>
			 </c:forEach>
		    </table>
		  </div>
		  <div class="panel-footer" style="height:100px;background-color:#fff;border-top:0px;">
		    <!-- 分页 -->
		   <c:if test="${pageModel.totalPage>1 }">
		   <nav aria-label="Page navigation" style="text-align:center;">
			  <ul class="pagination">
			    <li>
			      <a <c:if test="${pageModel.pageNumber==1 }">class="btn disabled"</c:if>
			      onclick="queryGoods(${pageModel.pageNumber-1});" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			    <c:forEach begin="${1 }" end="${pageModel.totalPage }" var="i">
			    <li <c:if test="${pageModel.pageNumber==i }">class="active"</c:if>>
			      <a onclick="queryGoods(${i});">${i }<span class="sr-only">(current)</span></a>
			    </li>
			    </c:forEach>
			    <li>
			      <a <c:if test="${pageModel.pageNumber==pageModel.totalPage }">class="btn disabled"</c:if>
			      onclick="queryGoods(${pageModel.pageNumber+1});" aria-label="Next">
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
  <jsp:include page="footer.jsp"/>
</body>
</html>