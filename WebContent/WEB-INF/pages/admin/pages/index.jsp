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
<title>失物招领后台管理系统--首页</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/style.css" />
</head>
<body>
<header class="navbar-wrapper">
	<div class="navbar navbar-fixed-top">
		<div class="container-fluid cl"> <a class="logo navbar-logo f-l mr-10 hidden-xs" href="">失物招领后台管理</a>
			<a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;">&#xe667;</a>
			<nav class="nav navbar-nav">
				<ul class="cl">
					<li class="dropDown dropDown_hover"><a href="javascript:;" class="dropDown_A"><i class="Hui-iconfont">&#xe600;</i> 添加 <i class="Hui-iconfont">&#xe6d5;</i></a>
						<ul class="dropDown-menu menu radius box-shadow">
							<li><a href="javascript:void();" onclick="goods('添加物品','${pageContext.request.contextPath }/admin/addPreGoods.action','','510')"><i class="Hui-iconfont">&#xe612;</i> 物品</a></li>
					</ul>
				</li>
			</ul>
		</nav>
		<nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
			<ul class="cl">
				<li>${htuser.role }</li>
				<li class="dropDown dropDown_hover">
					<a href="#" class="dropDown_A">${htuser.username }<i class="Hui-iconfont">&#xe6d5;</i></a>
					<ul class="dropDown-menu menu radius box-shadow">
						<li><a href="javascript:void(0);" onClick="myselfinfo('个人信息','${pageContext.request.contextPath }/admin/lookUpAdmin.action?id=${htuser.id }','350','250')">个人信息</a></li>
						<li><a href="javascript:void(0);" onclick="changePwd('修改密码','${pageContext.request.contextPath }/admin/changePrePwd.action','400','280')">修改密码</a></li>
						<li><a id="loginOut">退出</a></li>
				</ul>
			</li>
				<li id="Hui-skin" class="dropDown right dropDown_hover"> <a href="javascript:;" class="dropDown_A" title="换肤"><i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
					<ul class="dropDown-menu menu radius box-shadow">
						<li><a  data-val="default" title="默认（黑色）">默认（黑色）</a></li>
						<li><a  data-val="blue" title="蓝色">蓝色</a></li>
						<li><a  data-val="green" title="绿色">绿色</a></li>
						<li><a  data-val="red" title="红色">红色</a></li>
						<li><a  data-val="yellow" title="黄色">黄色</a></li>
						<li><a  data-val="orange" title="橙色">橙色</a></li>
					</ul>
				</li>
			</ul>
		</nav>
	</div>
</div>
</header>
<aside class="Hui-aside">
	<div class="menu_dropdown bk_2">
		<c:if test="${htuser.role=='超级管理员' }">
		 <dl>
			<dt><i class="Hui-iconfont">&#xe62d;</i> 人员管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="${pageContext.request.contextPath }/admin/userManage.action" data-title="用户" href="javascript:void(0)">用户</a></li>
					<li><a data-href="${pageContext.request.contextPath }/admin/adminManage.action" data-title="管理员" href="javascript:void(0)">管理员</a></li>
			    </ul>
		    </dd>
	    </dl>
		</c:if>
		<dl>
			<dt><i class="Hui-iconfont">&#xe612;</i> 物品信息<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="${pageContext.request.contextPath }/admin/goodsManage.action?type=lost" data-title="失物管理" href="javascript:;">失物管理</a></li>
					<li><a data-href="${pageContext.request.contextPath }/admin/goodsManage.action?type=get" data-title="拾物管理" href="javascript:;">拾物管理</a></li>
			    </ul>
		    </dd>
	    </dl>
		<dl>
			<dt><i class="Hui-iconfont">&#xe602;</i> 公告管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="${pageContext.request.contextPath }/admin/noticesManage.action" data-title="公告信息" href="javascript:;">公告信息</a></li>
			    </ul>
		    </dd>
	    </dl>
		<dl>
			<dt><i class="Hui-iconfont">&#xe702;</i> 名人名言<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="${pageContext.request.contextPath }/admin/famousRemarkManage.action" data-title="名言管理" href="javascript:;">名言管理</a></li>
			    </ul>
		    </dd>
	    </dl>
		<dl>
			<dt><i class="Hui-iconfont">&#xe622;</i> 留言信息<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="${pageContext.request.contextPath }/admin/leaMesManage.action" data-title="留言管理" href="javascript:void(0)">留言管理</a></li>
			    </ul>
		    </dd>
	   </dl>
		<dl>
			<dt><i class="Hui-iconfont">&#xe692;</i> 数据字典<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="${pageContext.request.contextPath }/admin/instituteManage.action" data-title="学院信息" href="javascript:void(0)">学院信息</a></li>
					<li><a data-href="${pageContext.request.contextPath }/admin/majorManage.action" data-title="专业信息" href="javascript:void(0)">专业信息</a></li>
					<li><a data-href="${pageContext.request.contextPath }/admin/kindsManage.action" data-title="物品种类信息" href="javascript:void(0)">物品种类信息</a></li>
			    </ul>
		    </dd>
	   </dl>
</div>
</aside>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
	<div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
		<div class="Hui-tabNav-wp">
			<ul id="min_title_list" class="acrossTab cl">
				<li class="active">
					<span title="主页" data-href="${pageContext.request.contextPath }/admin/toZhuYe.action">主页</span>
					<em></em></li>
		</ul>
	</div>
		<div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a></div>
</div>
	<div id="iframe_box" class="Hui-article">
		<div class="show_iframe">
			<div style="display:none" class="loading"></div>
			<iframe scrolling="yes" frameborder="0" src="${pageContext.request.contextPath }/admin/toZhuYe.action"></iframe>
	</div>
</div>
</section>

<div class="contextMenu" id="Huiadminmenu">
	<ul>
		<li id="closethis">关闭当前 </li>
		<li id="closeall">关闭全部 </li>
</ul>
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/H-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/H-ui.admin.js"></script> 
<!--/_footer 作为公共模版分离出去-->
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery.contextmenu.r2.js"></script>
<script type="text/javascript">
/*个人信息*/
function myselfinfo(title,url,w,h){
	layer_show(title,url,w,h);
}

// 退出登录
$("#loginOut").click(function(){
	layer.confirm('确认要退出本系统吗？',{btn: ['确定', '取消'],title:"提示",icon:3},function(){
		window.location.href="${pageContext.request.contextPath }/admin/loginAdminOut.action";
	});
})

/*物品-添加*/
function goods(title,url,w,h){
	layer_show(title,url,w,h);
}
/*修改密码  */
 function changePwd(title,url,w,h){
	layer_show(title,url,w,h);
}
</script>
</body>
</html>