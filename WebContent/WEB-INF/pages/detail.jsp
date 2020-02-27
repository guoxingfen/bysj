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
<title>失物招领--物品详情</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.min.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>

<style type="text/css">
a:link,a:visited{text-decoration:none !important}
a:active,a:hover{text-decoration:none !important;cursor:pointer}
td{
  border-top:0px !important;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	
	// 成功确认
	$("#confirm").click(function(){
		$.post('${pageContext.request.contextPath}/pleaseConfirm.action',
				{"gid":'${gi.goodsInfo.id}'},
				function(data){
					if(data.code=='SUCCESS'){
						$("#confirm").html("【已确认】<span class='glyphicon glyphicon-ok' aria-hidden='true'></span>");
						$("#confirm").attr("disabled",true).css("pointer-events","none");
						$("#ss").html("已确认");
					}
		})
	})
	
	
	
	
	
   // 举报
   $("#report").click(function(){
	   // 向后台发送举报
	   $.post('${pageContext.request.contextPath}/reportGoods.action',
			   {"sid":'${stuInfo.id}',"gid":'${gi.goodsInfo.id}'},
			   function(data){
				   if(data.code=='SUCCESS'){
					   $("#report").html("已举报");
					   $("#report").css("background-color","red");
					   $("#report").attr("disabled","disabled");
				   }
			   });
   })
   // 关注
   $("#follow").click(function(){
	   var txt=$("#follow").html();
	   if(txt=="关注"){
		   // 发送给后台进行关注
		   $.post('${pageContext.request.contextPath}/addFollow.action',
				   {"sid":'${stuInfo.id}',"gid":'${gi.goodsInfo.id}'},
				   function(data){
					   if(data.code=='SUCCESS'){
						   $("#follow").html("取消关注");
						   $("#follow").css("background-color","green");
						   $("#follow").blur();
					   }
				   });
	   }else{
		   // 取消关注
		   $.post('${pageContext.request.contextPath}/removeFollow.action',
				   {"sid":'${stuInfo.id}',"gid":'${gi.goodsInfo.id}'},
				   function(data){
					   if(data.code=='SUCCESS'){
						   $("#follow").html("关注");
						   $("#follow").css("background-color","#5cb85c");
						   $("#follow").blur();
					   }
				   });
	   }
   })
   
   // 弹出回复框
   var count='${fmt:length(commentsVo)}';
   function replyFn(number){
	   var i=0;
	   $("#reply"+number).click(function(){
		   i++;
		   if(i%2==0){
			   $("#reply_form"+number).fadeOut();
		   }else{
			   $("#reply_form"+number).fadeIn();
		   }
	   }) 
   }
   function reply(){
	   for(var i=1;i<=count;i++){
		   replyFn(i);
	   }
	}
   reply();
   // 展开或关闭回复详情
   function openFn(number){
	   $("#open"+number).click(function(){
	   var txt=$("#open"+number).html();
	   if(txt=="展开"){
		   $("#open"+number).html("关闭");
		   $("#reply_detail"+number).slideDown("slow")
	   }else{
		   $("#open"+number).html("展开");
		   $("#reply_detail"+number).slideUp("slow")
	   }
	  })
   }
   function open(){
	   for(var i=1;i<=count;i++){
		   openFn(i);
	   }
   }
   open();
   
   
})

</script>
</head>
<body style="margin-top:65px;">
  <jsp:include page="header.jsp"/>
     <div class="container-fluid">
       <div class="panel panel-info">
        <div class="panel-heading">
         <c:if test="${gi.goodsInfo.type=='Lost_Goods'}">
		   <c:set var="txt">【寻物启事】</c:set>
		 </c:if>
		 <c:if test="${gi.goodsInfo.type=='Get_Goods'}">
		   <c:set var="txt">【招领启事】</c:set>
		 </c:if>
		 <c:if test="${personInfo==null }">
		   <h3 class="panel-title">${txt }--【管理员】</h3>
		 </c:if>
		 <c:if test="${personInfo!=null }">
         <h3 class="panel-title">${txt }--<a style="color:#3CB372;" href="${pageContext.request.contextPath }/queryStuAllInfo.action?sid=${personInfo.id}&pageNumber=1">【${personInfo.uname }】</a>
         <c:if test="${stuInfo.id==personInfo.id&&stuInfo!=null }">
         <span style="margin-left:20px;" class="glyphicon glyphicon-star-empty" 
         aria-hidden="true"></span><span>如果已找到，请确认</span>
         <span style="margin-right:20px;" class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>
          <c:if test="${gi.goodsInfo.status==0 }">
            <a id="confirm" style="color:red;" title="成功请点击！！！" >【请确认】<span class="glyphicon glyphicon-ok" aria-hidden="true"></span></a>
          </c:if>
          <c:if test="${gi.goodsInfo.status==1 }">
            <a id="confirm" style="color:red;pointer-events:none;" disabled="true" title="成功请点击！！！" >【已确认】<span class="glyphicon glyphicon-ok" aria-hidden="true"></span></a>
          </c:if>
         </c:if></h3>
         </c:if>
        </div>
        <div class="panel-body">
         <div class="row">
           <div class="col-md-7">
	         <h3 style="text-align:center;">${gi.goodsInfo.title }</h3>
	         <hr/>
	         <p style="text-align:center;margin-top:-10px;">
	           <c:set var="goods_createtime">${gi.goodsInfo.publish_date }</c:set>
	           <%
	              String str=pageContext.getAttribute("goods_createtime").toString();
	              String publish_goods="";
	              java.text.DateFormat format1=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			      java.text.DateFormat format2=new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",java.util.Locale.ENGLISH);
	              if(!"".equals(str)){
			          publish_goods=format1.format(format2.parse(str));
	              }
		       %>
		       <span>发布时间：<strong id="createtime"><%=publish_goods %></strong></span>
		       <span style="margin-left:20px;">浏览量：<strong id="pageview">${gi.goodsInfo.pageview }</strong></span>
		       <c:if test="${gi.goodsInfo.status==0&&gi.goodsInfo.type=='Lost_Goods' }">
		         <c:set var="status">寻找中...</c:set>
		       </c:if>
		       <c:if test="${gi.goodsInfo.status==0&&gi.goodsInfo.type=='Get_Goods' }">
		         <c:set var="status">认领中...</c:set>
		       </c:if>
		       <c:if test="${gi.goodsInfo.status==1 }">
		         <c:set var="status">已确认</c:set>
		       </c:if>
		       <span style="margin-left:20px;">状态：<strong style="color:red;" id="ss">${status }</strong></span>
	         </p>
	         <div class="row">
	            <div class="col-md-5">
	              <p style="float:right;">
	               <c:if test="${gi.goodsInfo.pic==null||gi.goodsInfo.pic=='' }">
			          <img src="${pageContext.request.contextPath }/images/error.jpg" title="加载失败" class="img-thumbnail" style="width:200px;height:200px;"/>
			       </c:if>
	               <c:if test="${gi.goodsInfo.pic!=null&&gi.goodsInfo.pic!='' }">
			          <img src="/pic/${gi.goodsInfo.pic }" alt="正在加载" class="img-thumbnail" style="width:200px;height:200px;">
			       </c:if>
	              </p>
	              <p style="float:right;padding:10px;">
	               <c:if test="${report==null }">
	                <button id="report" type="button" class="btn btn-warning" style="margin-right:30px;width:70px;"
	                <c:if test="${stuInfo==null }">data-toggle="tooltip" data-placement="left" title="登录后才能举报" disabled="disabled"</c:if>     
	                >举报</button>
	               </c:if>
	               <c:if test="${report!=null }">
	               <button id="report" type="button" class="btn" style="margin-right:30px;width:70px;background-color:red" disabled="disabled">已举报</button>
	               </c:if>
	               <c:if test="${follow==null }">
	               <button id="follow" type="button" class="btn btn-success" style="width:80px;"
	                <c:if test="${stuInfo==null }">data-toggle="tooltip" data-placement="left" title="登录后才能关注" disabled="disabled"</c:if>     
	                >关注</button>
	                </c:if>
	                <c:if test="${follow!=null }">
	                  <button id="follow" type="button" class="btn btn-success" style="width:80px;background-color:green;">取消关注</button>
	                </c:if>
	              </p>
	            </div>
	            <div class="col-md-7">
	              <table class="table bg-success">
	                <tbody>
	                  <tr><td style="width:90px;">物品种类：</td><td><strong>${gi.kdesc }</strong></td></tr>
	                  <tr><td style="vertical-align:middle;">详细描述：</td>
	                  <td>${gi.goodsInfo.detail }</td>
	                  </tr>
	                  <c:set var="goods_date" value="${gi.goodsInfo.date }"/>
	                  <%
	                  str=pageContext.getAttribute("goods_date").toString();
	                  String time="";
	                  if(!"".equals(str)){
	                	 time=format1.format(format2.parse(str));
	                  }
	                  %>
	                  <tr><td>丢失地点：</td><td>${gi.goodsInfo.address }</td></tr>
	                  <tr><td>丢失时间：</td><td><%=time %></td></tr>
	                  <tr><td>联系地址：</td><td>${gi.goodsInfo.contact_address }</td></tr>
	                  <tr><td>班级：</td><td>${personInfo.uclass }</td></tr>
	                  <tr><td>专业：</td><td>${personInfo.major }</td></tr>
	                  <tr><td>学院：</td><td>${personInfo.institute }</td></tr>
	                  <tr><td>手机号码：</td>
	                  <td>
	                  <c:if test="${stuInfo==null }">
	                     <a data-toggle="tooltip" title="登录后可以查看" data-placement="right">xxxxxxxxxxx</a>
	                  </c:if>
	                  <c:if test="${stuInfo!=null }">
	                       ${gi.goodsInfo.phone }
	                  </c:if>
	                  </td>
	                  </tr>
	                </tbody>
	              </table>
	            </div>
	         </div>
           </div>
           <div class="col-md-5" style="margin-top:60px;">
			  <div class="panel panel-warning">
			     <div class="panel-heading">
			       <h3 class="panel-title">评论区</h3>
			     </div>
			     <div class="panel-body">
			      <c:if test="${stuInfo==null }">
			         <h4>请先登录！！！</h4>
			      </c:if>
			      <c:if test="${stuInfo!=null }">
			       <form action="${pageContext.request.contextPath }/addComment.action" method="post">
			        <div class="form-group">
			         <textarea rows="5" class="form-control" placeholder="请输入留言！！！" name="content" required="required"></textarea>
			         <input type="hidden" name="sid" value="${stuInfo.id }">
			         <input type="hidden" name="gid" value="${gi.goodsInfo.id }">
			        </div> 
			         <button class="btn btn-success" type="submit">发送</button>
			         <button class="btn btn-warning" type="reset">取消</button>
			       </form>
			       </c:if>
			       <hr/>
			       <h3>评论列表</h3>
			       <c:if test="${fmt:length(commentsVo)==0}">
			         <h4 style="text-align:center;line-height:30px;">暂无评论</h4>
			       </c:if>
			       <ul class="list-unstyled">
			         <c:forEach items="${commentsVo }" var="comment" varStatus="status">
			         <li>
			          <c:if test="${comment.pic==null||comment.pic=='' }">
			            <img src="${pageContext.request.contextPath }/images/test.jpg" alt="加载失败" class="img-circle" width="50px" height="50px" style="margin-bottom:-25px;"/>
			          </c:if>
			          <c:if test="${comment.pic!=null&&comment.pic!='' }">
			            <img src="/pic/${comment.pic }" alt="正在加载" class="img-circle" width="50px" height="50px" style="margin-bottom:-25px;"/>
			          </c:if>
			           <strong class="username">${comment.uname }</strong><br/>
			           <p class="bg-info" style="margin-left:55px;">${comment.content }</p>
			           <c:set var="comment_time" value="${comment.createtime }"/>
			           <%
			            str=pageContext.getAttribute("comment_time").toString();
			            String publish_comment="";
			            if(!"".equals(str)){
			            	publish_comment=format1.format(format2.parse(str));
			            }
		               %>
			           <p style="margin-left:55px;"><%=publish_comment %><span>
			             <a id="reply${status.index+1 }" style="margin-left:30px;">回复</a>
			             <a id="open${status.index+1 }" style="margin-left:10px;">展开</a>
			             <c:if test="${comment.sid==stuInfo.id }">
			               <a href="${pageContext.request.contextPath }/removeComment.action?id=${comment.id }&gid=${comment.gid}&sid=${stuInfo.id}" style="margin-left:10px;">删除</a>
			             </c:if>
			             </span>
			           </p>
			           <!-- 回复明细 -->
			           <div id="reply_detail${status.index+1 }" style="display:none;margin-top:-10px;">
			            <c:if test="${fmt:length(comment.replys)==0 }">
			               <h5 style="text-align:center;margin-top:30px;">暂无回复</h5>
			            </c:if>
			            <c:forEach items="${comment.replys }" var="reply">
			             <div style="margin-left:50px;">
			               <hr style="margin-bottom:5px;"/>
			               <c:if test="${reply.pic==null||reply.pic=='' }">
			                 <img src="${pageContext.request.contextPath }/images/test.jpg" alt="正在加载" class="img-circle" width="50px" height="50px" style="margin-bottom:-25px;"/>
			               </c:if>
			               <c:if test="${reply.pic!=null&&reply.pic!='' }">
			                 <img src="/pic/${reply.pic }" alt="正在加载" class="img-circle" width="50px" height="50px" style="margin-bottom:-25px;"/>
			               </c:if>
			               <strong class="username">${reply.uname }</strong><br/>
			               <p class="bg-info" style="margin-left:55px;">${reply.content }</p>
			               <c:set var="reply_time" value="${reply.createtime }"/>
			               <%
			                str=pageContext.getAttribute("reply_time").toString();
			                String publish_reply="";
			                if(!"".equals(str)){
			                	publish_reply=format1.format(format2.parse(str));
			                }
		                   %>
			               <p style="margin-left:55px;"><%=publish_reply %>
			               <c:if test="${reply.sid==stuInfo.id }">
			                 <a href="${pageContext.request.contextPath }/removeReply.action?id=${reply.id }&gid=${comment.gid}&sid=${stuInfo.id}" style="margin-left:30px;">删除</a>
			               </c:if>
			               </p>
			             </div>
			            </c:forEach>
			           </div>
			          <!-- 回复留言 -->
			           <div id="reply_form${status.index+1 }" style="display:none;">
			             <c:if test="${stuInfo==null }">
			                <h5 style="text-align:center;margin-top:20px;">请先登录！！！</h5>
			             </c:if>
			             <c:if test="${stuInfo!=null }">
			             <form action="${pageContext.request.contextPath }/addReply.action" method="post">
			               <div class="form-group">
			                 <textarea rows="3" class="form-control" placeholder="请输入回复" name="content"></textarea>
			                 <input type="hidden" name="cid" value="${comment.id }"/>
			                 <input type="hidden" name="sid" value="${stuInfo.id }"/>
			                 <input type="hidden" name="gid" value="${gi.goodsInfo.id }">
			               </div>
			               <button class="btn btn-success" type="submit">确定</button>
			               <button class="btn btn-warning" type="reset">取消</button>
			             </form>
			             </c:if>
			           </div>
			           <hr style="margin-bottom:5px;"/>
			         </li>
			         </c:forEach>
			       </ul>
			     </div>
			   </div>
			  </div>
           </div>
         </div>
        </div>
      </div>
  <jsp:include page="footer.jsp"/>
</body>
</html>