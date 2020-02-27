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
<title>失物招领--寻物启事</title>
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
	
	// 图片展示
	$("#goods_image").click(function(){
		//$("#image").css("display","block");
		//$("#list").css("display","none");
		$("#image").show();
		$("#list").hide();
	})
	// 列表展示
	$("#goods_list").click(function(){
		//$("#image").css("display","none");
		//$("#list").css("display","block");
		$("#image").hide();
		$("#list").show();
	})
	// 消息公告
	$("#slider2").bxSlider({
		mode:'vertical',
		minSlides:6,
		maxSlides:6,
		slideMargin:12,
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
	// 异步调用函数
	function getLost(pageNumber){
		$.post("${pageContext.request.contextPath }/screenLost.action?pageNumber="+pageNumber,
	    		$("#formlost").serializeArray(),
				function(data){
	    	// 赋值
	    	$("#meslist").empty();
	    	$("#list_table").empty();
	    	$("#image").empty();
	    	$("#lostul").empty();
	    	if(data.data.length==0){
	    		$("#meslist").append("<h3 style='text-align:center;color:red;margin-top:20px;'>暂无数据</h3>")
	    		$("#image").append("<h3 style='text-align:center;color:red;margin-top:20px;'>暂无数据</h3>")
	    	}else{
	    		$.each(data.data,function(key,value){
	    			$("#list_table").append("<tr><td>"+value.kdesc+"</td><td>"+
	    					value.goodsInfo.title+"</td><td>"+dateFormat(value.goodsInfo.publish_date)+
	    					"</td><td><a href='${pageContext.request.contextPath }/lookUpGoods.action?gid="+
	    							value.goodsInfo.id+"&sid=${stuInfo.id}'>查看</a></td></tr>");
	    		})
	    		$.each(data.data,function(key,value){
			        var txt='<div class="col-md-2" style="height:220px;">'+
			        '<div class="thumbnail" style="background-color:#f3ffda;">';
			        var img='';
			        if(value.goodsInfo.pic==null||value.goodsInfo.pic==''){
			        	img='<img src="${pageContext.request.contextPath }/images/error.jpg" title="加载失败" style="height:120px;"/>';
			        }else{
			        	img='<img src="/pic/'+value.goodsInfo.pic+'"style="height:120px;"/>';
			        }
			        var p='<p style="margin-top:5px;text-align:center;"><a href="${pageContext.request.contextPath }/lookUpGoods.action?gid='+
			        value.goodsInfo.id+'&sid=${stuInfo.id}">'+
			        value.goodsInfo.title+'</a></p></div></div>';
	    			$("#image").append(txt+img+p);
	    		})
	    		// 改变总数
	    		$("#lost_total").html(data.totalRecord);
	    	}
	    	if(data.totalPage>1){
	    		if(data.pageNumber==1){
					   $("#lostul").append("<li><a id='lost0' class='btn disabled' aria-label='Previous'>"+
					   "<span aria-hidden='true'>&laquo;</span></a></li>");
				   }else{
					   $("#lostul").append("<li><a id='lost0' aria-label='Previous'>"+
					   "<span aria-hidden='true'>&laquo;</span></a></li>");
				   }
	    		for(var i=1;i<=data.totalPage;i++){
					   if(data.pageNumber==i){
					      $("#lostul").append("<li class='active'><a id='lost"+i+"'>"+i+"<span class='sr-only'>(current)</span></a></li>")
					   }else{
						  $("#lostul").append("<li><a id='lost"+i+"'>"+i+"<span class='sr-only'>(current)</span></a></li>")
					   }
				   }
	    		if(data.pageNumber==data.totalPage){
					   $("#lostul").append("<li><a id='lost"+(data.totalPage+1)+"' class='btn disabled' aria-label='Next'>"+
					   "<span aria-hidden='true'>&raquo;</span></a></li>");
				   }else{
					   $("#lostul").append("<li><a id='lost"+(data.totalPage+1)+"' aria-label='Next'>"+
					   "<span aria-hidden='true'>&raquo;</span></a></li>");
				   }
	    		// 为分页中a标签添加事件
				   for(var i=0;i<=data.totalPage+1;i++){
					   lostNav(i,data.pageNumber,data.totalPage);
				   }
	    	}
	    })
	}
	// 分页中a标签的事件
	function lostNav(i,pageNumber,totalPage){
		pageNumber=parseInt(pageNumber);
		if(i==0){
			 $("#lost"+i).click(function(){
				 getLost(pageNumber-1);
			 })
		   }else if(i==totalPage+1){
			  $("#lost"+i).click(function(){
				  getLost(pageNumber+1);
			 }) 
			 }else{
			 $("#lost"+i).click(function(){
				 getLost(i);
			 })
		   }
	}
	// 筛选
	$("#screenlost").click(function(){
		getLost(1);
	})
	
})

</script>
</head>
<body style="margin-top:65px;">
  <jsp:include page="header.jsp"/>
    <div class="container-fluid">
     <div class="row">
       <div class="col-md-8">
		    <div class="panel panel-info" style="height:600px;">
			  <div class="panel-heading">
			    <h3 style="display:inline" class="panel-title">寻物区（共<span style="color:red;" id="lost_total">${pageLostModel.totalRecord }</span>条数据）</h3>
			    <a id="goods_list"><span class="glyphicon glyphicon-th-list" style="float:right;" aria-hidden="true"></span></a>
			    <a id="goods_image"><span class="glyphicon glyphicon-th-large" style="float:right;margin-right:10px;" aria-hidden="true"></span></a>
			  </div>
			  <div class="panel-body" style="height:480px;">
			    <div id="list" style="display:none;">
			      <div id="meslist">
			        <c:if test="${fmt:length(pageLostModel.data)==0 }">
			          <h3 style="text-align:center;color:red;margin-top:20px;">暂无数据</h3>
			        </c:if>
			      </div>
			     <c:if test="${fmt:length(pageLostModel.data)>0 }">
			      <table class="table table-hover" id="list_table">
			       <c:forEach items="${pageLostModel.data }" var="goodsList">
			        <tr>
			          <c:if test="${goodsList.kdesc==null }">
			           <td>未知</td>
			          </c:if>
			          <c:if test="${goodsList.kdesc!=null }">
			           <td>${goodsList.kdesc }</td>
			          </c:if>
			          <td>${goodsList.goodsInfo.title }</td>
			          <c:set var="goods_createtime">${goodsList.goodsInfo.publish_date }</c:set>
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
			          <td><a href="${pageContext.request.contextPath }/lookUpGoods.action?gid=${goodsList.goodsInfo.id}&sid=${stuInfo.id}">查看</a></td>
			        </tr>
			       </c:forEach>
			      </table>
			     </c:if>
			    </div>
			    <div class="row" id="image">
			       <c:if test="${fmt:length(pageLostModel.data)==0 }">
			        <h3 style="text-align:center;color:red;margin-top:20px;">暂无数据</h3>
			       </c:if>
			     <c:if test="${fmt:length(pageLostModel.data)>0 }">
			      <c:forEach items="${pageLostModel.data }" var="goodsImg">
			      <div class="col-md-2" style="height:220px;">
			        <div class="thumbnail" style="background-color:#f3ffda;">
			         <c:if test="${goodsImg.goodsInfo.pic==null||goodsImg.goodsInfo.pic=='' }">
			          <img src="${pageContext.request.contextPath }/images/error.jpg" title="加载失败" style="height:120px;"/>
			         </c:if>
			         <c:if test="${goodsImg.goodsInfo.pic!=null&&goodsImg.goodsInfo.pic!='' }">
			          <img src="/pic/${goodsImg.goodsInfo.pic }" style="height:120px;"/>
			         </c:if>
			          <p style="margin-top:5px;text-align:center;"><a href="${pageContext.request.contextPath }/lookUpGoods.action?gid=${goodsImg.goodsInfo.id}&sid=${stuInfo.id}">${goodsImg.goodsInfo.title }</a></p>
			        </div>
			      </div>
			      </c:forEach>
			      </c:if>
			      </div>
			    </div>
			   <c:if test="${pageLostModel.totalPage>1 }">
			    <nav aria-label="Page navigation" style="text-align:center;">
						<ul class="pagination" id="lostul">
						  <li>
						    <a <c:if test="${pageLostModel.pageNumber==1 }">class="btn disabled"</c:if> 
						    href="${pageContext.request.contextPath }/forlost.action?pageNumber=${pageLostModel.pageNumber-1}" aria-label="Previous">
						      <span aria-hidden="true">&laquo;</span>
						    </a>
						  </li>
						  <c:forEach begin="1" end="${pageLostModel.totalPage }" var="i">
						   <li <c:if test="${pageLostModel.pageNumber==i }">class="active"</c:if>>
						   <a href="${pageContext.request.contextPath }/forlost.action?pageNumber=${i}">${i }</a></li>
						  </c:forEach>
						  <li>
						    <a <c:if test="${pageLostModel.pageNumber==pageLostModel.totalPage }">class="btn disabled"</c:if>
						    href="${pageContext.request.contextPath }/forlost.action?pageNumber=${pageLostModel.pageNumber+1}" aria-label="Next">
						      <span aria-hidden="true">&raquo;</span>
						    </a>
						  </li>
						</ul>
				   </nav>
				 </c:if>
			</div>
       </div>
       <div class="col-md-4">
         <div class="panel panel-info" style="height:260px;">
			  <div class="panel-heading">
			    <h3 class="panel-title" style="display:inline">喜报公告</h3>
			    <span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span>
			  </div>
			  <div class="panel-body">
			    <div style="margin-bottom:20px;">
		                <c:if test="${fmt:length(goodNews)==0 }">
		                  <h3 style="text-align:center;color:red;">暂无公告</h3>
		                </c:if>
		               <c:if test="${fmt:length(goodNews)>0 }">
		                <ul class="bxslider" id="slider2"  style="background-color:#e4f6ff;">
		                 <c:forEach items="${goodNews }" var="goodn">
		                 <li><strong style="color:red;">${goodn.uname }</strong>成功寻回了
                          <strong style="color:red;">${goodn.desc }</strong></li>
		                 </c:forEach>
		                 <c:if test="${fmt:length(goodNews)<7 }">
		                   <c:forEach begin="1" end="${7-fmt:length(goodNews) }">
		                     <li><i>期待下一位的出现！！！</i></li>
		                   </c:forEach>
		                 </c:if>
		                </ul>
		               </c:if>
		              </div>
			  </div>
			</div>
         <div class="panel panel-warning" style="margin-top:-10px;">
		  <div class="panel-heading">
		    <h3 class="panel-title">筛选区</h3>
		  </div>
		  <div class="panel-body">
		    <form id="formlost" action="" class="form-horizontal" method="post">
               <div class="form-group">
                  <label class="col-sm-3 control-label">种类：</label>
                  <div class="col-sm-9">
                    <c:forEach items="${kinds }" var="kind">
                     <label class="checkbox-inline">
					    <input class="kids" type="checkbox" name="kids" value="${kind.id }">${kind.desc }
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
               <button type="button" id="screenlost" class="btn btn-success" style="margin-left:30%;">筛选</button>
               <button type="reset" class="btn btn-danger" style="margin-left:10%;">重置</button>
		    </form>
		  </div>
		</div>
       </div>
     </div>
   </div>
  <jsp:include page="footer.jsp"/>
</body>
</html>