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
<title>失物招领--搜索</title>
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
	// 名言轮播
	$("#slider2").bxSlider({
		minSlides:1,
		maxSlides:1,
		auto:true,
		infiniteLoop:true,
		pager:false
	})
	
	// 时间戳转特定的日期格式2009-10-09
	function add0(m){return m<10?'0'+m:m}
	function dateFormat(shijianchuo){
		var time=new Date(shijianchuo);
		var y=time.getFullYear();
		var m=time.getMonth()+1;
		var d=time.getDate();
		return y+'-'+add0(m)+'-'+add0(d);
	}
	
	function getSearch(pageNumber){
		
		$.post("${pageContext.request.contextPath }/screenSearch.action?pageNumber="+pageNumber,
				$("#searchform").serializeArray(),
				function(data){
			$("#info").empty();
			$("#searchul").empty();
			if(data.data.length==0){
				$("#info").append("<tr><td colspan='4'><h3 style='text-align:center;color:red;margin-top:20px;'>暂无数据</h3></td></tr>");
			}else{
				$.each(data.data,function(key,value){
					var type="";
					if(value.goodsInfo.type=='Lost_Goods'){
						type="寻物";
					}else{
						type="招领";
					}
					var date=dateFormat(value.goodsInfo.publish_date);
					if("寻物"==type){
						$("#info").append("<tr><td>"+type+"</td><td>"+value.kdesc+"</td><td><a href='${pageContext.request.contextPath }/lookUpGoods.action?gid="+
								value.goodsInfo.id+"&sid=${stuInfo.id}'>"+
								value.goodsInfo.title+"</a></td><td>"+date+"</td></tr>");
					}else{
						$("#info").append("<tr><td style='color:red;'>"+type+"</td><td>"+value.kdesc+"</td><td><a href='${pageContext.request.contextPath }/lookUpGoods.action?gid="+
								value.goodsInfo.id+"&sid=${stuInfo.id}'>"+
								value.goodsInfo.title+"</a></td><td>"+date+"</td></tr>");
					}
					
				})
				// 改变总数
				$("#search_total").html(data.totalRecord);
			}
			if(data.totalPage>1){
	    		if(data.pageNumber==1){
					   $("#searchul").append("<li><a id='search0' class='btn disabled' aria-label='Previous'>"+
					   "<span aria-hidden='true'>&laquo;</span></a></li>");
				   }else{
					   $("#searchul").append("<li><a id='search0' aria-label='Previous'>"+
					   "<span aria-hidden='true'>&laquo;</span></a></li>");
				   }
	    		for(var i=1;i<=data.totalPage;i++){
					   if(data.pageNumber==i){
					      $("#searchul").append("<li class='active'><a id='search"+i+"'>"+i+"<span class='sr-only'>(current)</span></a></li>")
					   }else{
						  $("#searchul").append("<li><a id='search"+i+"'>"+i+"<span class='sr-only'>(current)</span></a></li>")
					   }
				   }
	    		if(data.pageNumber==data.totalPage){
					   $("#searchul").append("<li><a id='search"+(data.totalPage+1)+"' class='btn disabled' aria-label='Next'>"+
					   "<span aria-hidden='true'>&raquo;</span></a></li>");
				   }else{
					   $("#searchul").append("<li><a id='search"+(data.totalPage+1)+"' aria-label='Next'>"+
					   "<span aria-hidden='true'>&raquo;</span></a></li>");
				   }
	    		// 为分页中a标签添加事件
				   for(var i=0;i<=data.totalPage+1;i++){
					   searchNav(i,data.pageNumber,data.totalPage);
				   }
	    	}
			
		})
	}
	
	// 分页中a标签的事件
	function searchNav(i,pageNumber,totalPage){
		pageNumber=parseInt(pageNumber);
		if(i==0){
			 $("#search"+i).click(function(){
				 getSearch(pageNumber-1);
			 })
		   }else if(i==totalPage+1){
			  $("#search"+i).click(function(){
				  getSearch(pageNumber+1);
			 }) 
			 }else{
			 $("#search"+i).click(function(){
				 getSearch(i);
			 })
		   }
	}
	
	
	
	$("#searchscreen").click(function(){
		getSearch(1);
	})
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
})

</script>
</head>
<body style="margin-top:65px;">
  <jsp:include page="header.jsp"/>
	<div class="container-fluid">
	  <div class="row">
	    <div class="col-md-8">
	      <div class="panel panel-info" style="height:760px;">
			 <div class="panel-heading">
			   <h3 class="panel-title">信息列表（共<span id="search_total" style="color:red;">${pageModel.totalRecord }</span>条数据）</h3>
			 </div>
			 <div class="panel-body" style="height:700px;">
			    <table class="table table-hover">
			      <thead>
			        <tr><th>信息类型</th><th>物品种类</th><th>信息标题</th><th>发布时间</th></tr>
			      </thead>
			       <c:if test="${fmt:length(pageModel.data)==0 }">
			        <h3 style="text-align:center;color:red;margin-top:20px;">暂无数据</h3>
			       </c:if>
			      <tbody id="info">
			        <c:if test="${fmt:length(pageModel.data)>0 }">
			         <c:forEach items="${pageModel.data }" var="goodsInfoVo">
			          <c:if test="${goodsInfoVo.goodsInfo.type=='Lost_Goods' }">
			            <c:set value="寻物"  var="aa"/>
			          </c:if>
			          <c:if test="${goodsInfoVo.goodsInfo.type=='Get_Goods' }">
			            <c:set value="招领"  var="aa"/>
			          </c:if>
			          <tr>
			           <td <c:if test="${aa=='招领' }">style="color:red;"</c:if> >${aa }</td>
			           <c:if test="${goodsInfoVo.kdesc==null }">
			             <td>未知</td>
			           </c:if>
			           <c:if test="${goodsInfoVo.kdesc!=null }">
			             <td>${goodsInfoVo.kdesc }</td>
			           </c:if>
			           <td>
			            <a href="${pageContext.request.contextPath }/lookUpGoods.action?gid=${goodsInfoVo.goodsInfo.id}&sid=${stuInfo.id}">
			             ${goodsInfoVo.goodsInfo.title }
			            </a>
			           </td>
			           <c:set var="time">${goodsInfoVo.goodsInfo.publish_date }</c:set>
			           <%
			              String str=pageContext.getAttribute("time").toString();
			              String publish_time="";
			              java.text.DateFormat format1=new java.text.SimpleDateFormat("yyyy-MM-dd");
					      java.text.DateFormat format2=new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",java.util.Locale.ENGLISH);
			              if(!"".equals(str)){
					          publish_time=format1.format(format2.parse(str));
			              }
				       %>
			           <td><%=publish_time %></td></tr>
			         </c:forEach>
			        </c:if>
			      </tbody>
                </table>
			 </div>
			   <c:if test="${pageModel.totalPage>1 }">
                <nav aria-label="Page navigation" style="text-align:center;margin-top:-80px;">
						<ul class="pagination" id="searchul">
						  <li>
						    <a <c:if test="${pageModel.pageNumber==1 }">class="btn disabled"</c:if> 
						    href="${pageContext.request.contextPath }/tosearch.action?pageNumber=${pageModel.pageNumber-1}" aria-label="Previous">
						      <span aria-hidden="true">&laquo;</span>
						    </a>
						  </li>
						  <c:forEach begin="1" end="${pageModel.totalPage }" var="i">
						   <li <c:if test="${pageModel.pageNumber==i }">class="active"</c:if>>
						   <a href="${pageContext.request.contextPath }/tosearch.action?pageNumber=${i}">${i }</a></li>
						  </c:forEach>
						  <li>
						    <a <c:if test="${pageModel.pageNumber==pageModel.totalPage }">class="btn disabled"</c:if>
						    href="${pageContext.request.contextPath }/tosearch.action?pageNumber=${pageModel.pageNumber+1}" aria-label="Next">
						      <span aria-hidden="true">&raquo;</span>
						    </a>
						  </li>
						</ul>
				   </nav>
				</c:if>
		  </div>
	    </div>
	    <div class="col-md-4">
	       <div class="panel panel-warning">
			 <div class="panel-heading">
			   <h3 class="panel-title">筛选区</h3>
			 </div>
			 <div class="panel-body">
			   <form action="" class="form-horizontal" id="searchform">
			   <div class="form-group">
                  <label class="col-sm-3 control-label">关键字：</label>
                  <div class="col-sm-9">
                     <label class="control-label" style="font-size:16px;">${keyword }</label>
                  </div>
               </div>
               <input type="hidden" name="keyword" value="${keyword }"/>
               <div class="form-group">
                  <label class="col-sm-3 control-label">类型：</label>
                  <div class="col-sm-9">
                     <label class="checkbox-inline">
					    <input type="checkbox" name="lost" value="Lost_Goods">寻物
					  </label>
                     <label class="checkbox-inline">
					    <input type="checkbox" name="get" value="Get_Goods">招领
					  </label>
                  </div>
               </div>
               <div class="form-group">
                  <label class="col-sm-3 control-label">状态：</label>
                  <div class="col-sm-9">
                     <label class="checkbox-inline">
					    <input type="checkbox" name="status" value="0">未确认
					  </label>
					  <label class="checkbox-inline">
					    <input type="checkbox" name="status" value="1">已确认
					  </label>
                  </div>
               </div>
               <div class="form-group">
                  <label class="col-sm-3 control-label">种类：</label>
                  <div class="col-sm-9">
                    <c:forEach items="${kinds }" var="kind">
                     <label class="checkbox-inline">
					    <input type="checkbox" name="kids" value="${kind.id }">${kind.desc }
					  </label>
					</c:forEach>
                  </div>
               </div>
               <div class="form-group">
                  <label class="col-sm-3 control-label">时间：</label>
                  <div class="col-sm-9">
                     <label class="checkbox-inline">
					    <input class="days" type="checkbox"  name="days" value="3">前3天
					  </label>
                     <label class="checkbox-inline">
					    <input class="days" type="checkbox"  name="days" value="7">前1周
					  </label>
                     <label class="checkbox-inline">
					    <input class="days" type="checkbox"  name="days" value="30">前1个月
					  </label>
                  </div>
               </div>
               <div class="form-group">
                  <label class="col-sm-3 control-label">排序：</label>
                  <div class="col-sm-9">
                      <label class="radio-inline">
					    <input type="radio" name="sort" value="1">升序
					  </label>
                      <label class="radio-inline">
					    <input type="radio" name="sort" value="0">降序
					  </label>
                  </div>
               </div>
               <button type="button" id="searchscreen" class="btn btn-success" style="margin-left:30%;">筛选</button>
               <button type="reset" class="btn btn-danger" style="margin-left:10%;">重置</button>
		    </form>
			 </div>
		  </div>
	       <div class="panel panel-info" style="border:0px;">
			 <div class="panel-heading">
			   <h3 class="panel-title">名言区</h3>
			 </div>
			 <div class="panel-body" style="margin-top:-5px;">
			<div class="bxslider" id="slider2">
			 <c:if test="${fmt:length(famousRemarks)==0 }">
			   <h3 style="text-align:center;color:red;margin-top:20px;">暂无名言</h3>
			 </c:if>
			 <c:if test="${fmt:length(famousRemarks)>0 }">
			 <c:forEach items="${famousRemarks }" var="famousRemark">
			 <div class="thumbnail">
			  <c:if test="${famousRemark.pic==null||famousRemark.pic=='' }">
		        <img src="${pageContext.request.contextPath }/images/famous.jpg" style="width:100%;height:150px;">
		      </c:if>
			  <c:if test="${famousRemark.pic!=null&&famousRemark.pic!='' }">
		        <img src="/pic/${famousRemark.pic }" style="width:100%;height:150px;">
		      </c:if>
		      <div class="caption">
		        <blockquote>
				  <p>${famousRemark.content }</p>
				  <footer>${famousRemark.from } </footer>
				</blockquote>
		      </div>
		    </div>
		    </c:forEach>
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