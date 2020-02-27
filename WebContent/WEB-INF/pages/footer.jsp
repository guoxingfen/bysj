<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>失物招领</title>
<style type="text/css">

.footer {
  margin-top:20px;
  width: 100%;
  height: 100px;
  background-color: #f5f5f5;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	
})

</script>
</head>
<body>
<footer class="footer">
   <div class="container">
     <div style="text-align:center; margin-top:30px;margin-bottom:-10px;">
        <ul class="list-inline">
          <li><a href="${pageContext.request.contextPath }/queryAllInfo.action">网站首页</a></li>
          <li><a href="${pageContext.request.contextPath }/queryAllLeaMes.action?pageNumber=1">留言中心</a></li>
          <li><a href="${pageContext.request.contextPath }/mystatistics.action">统计分析</a></li>
          <li><a href="${pageContext.request.contextPath }/law.action">法律声明</a></li>
          <li><a href="${pageContext.request.contextPath }/aboutus.action">关于我们</a></li>
        </ul>
     </div>
     <hr style="height:1px;border:none;border-top:1px solid #ddd;"/>
     <div style="margin-top:-15px;">
       <ul class="list-inline">
          <li>友情链接：</li>
          <li><a href="https://stu.gdmu.edu.cn">广医数字校园网</a></li>
          <li><a href="https://tsg.gdmu.edu.cn">广医图书馆</a></li>
          <li><a href="#">百事学塘</a></li>
          <li style="float:right;">Copyright ©2019 广医失物招领 版权所有</li>
       </ul>
     </div>
   </div>
</footer>
</body>
</html>