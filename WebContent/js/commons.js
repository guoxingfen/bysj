$(document).ready(function(){
	// 计时
	var nums=60;
	// 计时器的锁
	var clock="";
	// 加密后的手机验证码
	var encrypt_code="";
	// 弹出登录框
	$("#globalLoginBtn").click(function(){
		var txt=$("#globalLoginBtn").html();
		if(txt.indexOf("注册")!=-1){
			// 进行登录
			$("#loginModal").modal("show");
		}else{
			// 退出登录
			window.location.href=path+"/logout.action";
		}
	})
	// 动态判断用户是否存在
	$("#uname").change(function(){
		var data={
				"uname":$("#uname").val(),
				"mphone":$("#uname").val(),
				"unumber":$("#uname").val()
		};
		$.post(path+"/queryStu.action",data,function(data){
			// 用户不存在
			if($("#loginModalLabel").html()=="注册"){
				if(data.code=="SUCCESS"){
					$("#uname").val("");
					$("#uname").attr("placeholder",data.message);
					$("#uname").addClass("invalid");
					$("#uname").focus();
					$("#login-form-tips").css("color","#FF8888");
					$("#login-form-tips").html("提示："+data.message);
				}else{
					$("#login-form-tips").html("");
				}
			}else{
				if(data.code=="FAIL"){
					$("#uname").val("");
					$("#uname").attr("placeholder",data.message);
					$("#uname").addClass("invalid");
					$("#uname").focus();
					$("#login-form-tips").css("color","#FF8888");
					$("#login-form-tips").html("提示："+data.message);
				}else{
					$("#login-form-tips").html("");
				}
			}
			
		})
	})
	// 显示|隐藏密码
	$("#passwordeye").attr("onclick","switchPwd();");
	// 点击登录按钮
	// 检验文本框的值是否正确
	$("#login_btn").click(function(){
		var info={
				"uname":$("#uname").val(),
				"mphone":$("#uname").val(),
				"unumber":$("#uname").val(),
				"password":$("#password").val()
		}
		if($("#loginModalLabel").html()=="注册"){
			if(valiPhone()&&valiData("#password","密码不能为空！")&&valiData("#code","验证码不能为空！")){
				$("#login_btn").html("注册中...");
				  $("#login_btn").attr("disabled",true);
				  // 发送注册请求
				  $.post(path+"/register.action",
							{"mphone":$("#uname").val(),
						     "password":$("#password").val(),
						     "code":$("#code").val(),
						     "encrypt_code":encrypt_code},
							function(data){
							if(data.code=="FAIL"){
								$("#code").val("");
								$("#code").attr("placeholder",data.message);
								$("#code").addClass("invalid");
								$("#code").focus();
								$("#login_btn").html("注册");
								$("#login_btn").attr("disabled",false);
								$("#login-form-tips").css("color","#FF8888");
								$("#login-form-tips").html("提示："+data.message);
							}else{
								//注册成功，请求主页页
								$("#loginModal").modal("toggle");
								window.location.href=path+"/queryAllInfo.action";
							}
					})
			}
		}else if($("#loginModalLabel").html()=="登录"){
			if(valiData("#uname","用户/手机号/学号不能为空！")&&valiData("#password","密码不能为空！")){
				$("#login_btn").html("登录中...");
				$("#login_btn").attr("disabled",true);
				// 发送登录请求
				$.post(path+"/login.action",info,function(data){
					// 登录失败
					if(data.code=="FAIL"){
						$("#password").val("");
						$("#password").attr("placeholder",data.message);
						$("#password").addClass("invalid");
						$("#password").focus();
						$("#login_btn").html("登录");
						$("#login_btn").attr("disabled",false);
						$("#login-form-tips").css("color","#FF8888");
						$("#login-form-tips").html("提示："+data.message);
					}else{
						if(data.obj.status=='1'){
							$("#loginModal").modal("toggle");
							window.location.href=path+"/queryAllInfo.action";
						}else{
							$("#login_btn").html("登录");
							$("#login_btn").attr("disabled",false);
							$("#login-form-tips").css("color","#FF8888");
							$("#login-form-tips").html("提示："+'你已被禁用！');
						}
						
					}
				})
			}
		}else{
			if(valiPhone()&&valiData("#password","密码不能为空！")&&valiData("#code","验证码不能为空！")){
				$("#login_btn").html("重置中...");
				$("#login_btn").attr("disabled",true);
				// 发送重置请求
				$.post(path+"/resetpwd.action",
						{"mphone":$("#uname").val(),
					     "password":$("#password").val(),
					     "code":$("#code").val(),
					     "encrypt_code":encrypt_code},
						function(data){
						if(data.code=="FAIL"){
							$("#code").val("");
							$("#code").attr("placeholder",data.message);
							$("#code").addClass("invalid");
							$("#code").focus();
							$("#login_btn").html("重置密码");
							$("#login_btn").attr("disabled",false);
							$("#login-form-tips").css("color","#FF8888");
							$("#login-form-tips").html("提示："+data.message);
						}else{
							//重置成功，请求主页页
							if(data.obj.status=='1'){
								$("#loginModal").modal("toggle");
								window.location.href=path+"/queryAllInfo.action";
							}else{
								$("#login_btn").html("登录");
								$("#login_btn").attr("disabled",false);
								$("#login-form-tips").css("color","#FF8888");
								$("#login-form-tips").html("提示："+'你已被禁用！');
							}
						}
				})
			}
		}
	})
	// 关闭登录界面
	$("#login_close").click(function(){
		remove();
		$("#login-form-tips").html("");
		if($("#loginModalLabel").html()=="登录"){
			$("#login_btn").html("登录");
		}else if($("#loginModalLabel").html()=="注册"){
			$("#login_btn").html("注册");
		}else{
			$("#login_btn").html("重置密码");
		}
		clearInterval(clock);
		$("#code_btn").attr("disabled",false);
		$("#code_btn").val("点击获取");
		$("#login_btn").attr("disabled",false);
	})
	// 点击立即注册
	$("#btnRegister").click(function(){
		remove();
		$("#login-form-tips").html("");
		if($("#btnRegister").text()=="立即注册"){	
		$("#loginModalLabel").html("注册");
		$("#mes").html("");
		$("#btnForgetpsw").html("");
		$("#btnRegister").html("立即登录");
		$("#login_btn").html("注册");
		$("#uname").attr("placeholder","请输入手机号");
		$("#register").css("display","block");
		}else{
		$("#loginModalLabel").html("登录");
		$("#mes").html("还没有账号？");
		$("#btnForgetpsw").html("忘记密码？");
		$("#btnRegister").html("立即注册");
		$("#login_btn").html("登录");
		$("#uname").attr("placeholder","请输入用户名/手机号/学号");
		$("#register").css("display","none");
		}
	})
	// 忘记密码
	$("#btnForgetpsw").click(function(){
		remove();
		$("#login-form-tips").html("");
		$("#btnForgetpsw").html("");
		$("#loginModalLabel").html("找回密码");
		$("#mes").html("");
		$("#btnRegister").html("立即登录");
		$("#login_btn").html("重置密码");
		$("#uname").val("");
		$("#uname").attr("placeholder","请输入手机号");
		$("#register").css("display","block");
	})
	// 获取验证码
	$("#code_btn").click(function(){
		if(valiPhone()){
			$("#code_btn").attr("disabled",true);
			$.post(path+"/getCode.action",{"mphone":$("#uname").val()},function(data){
				encrypt_code=data.message;
			})
			clock=setInterval(function countDown(){
			if(nums>0){
				$("#code_btn").val(nums+"s");
				nums--;
			}else{
				clearInterval(clock);
				$("#code_btn").attr("disabled",false);
				$("#code_btn").val("重新获取");
				nums=60;
			}
		},1000);
		}
	})
})

// 验证手机号
function valiPhone() {
	var phone = $("#uname").val();
	var flag = false;
	var message = "";
	var myreg = /^(((13[0-9]{1})|(14[0-9]{1})|(17[0]{1})|(15[0-3]{1})|(15[5-9]{1})|(18[0-9]{1}))+\d{8})$/;
	if (phone == '') {
		message = "手机号码不能为空！";
	} else if (phone.length != 11) {
		message = "请输入有效的手机号码！";
	} else if (!myreg.test(phone)) {
		message = "请输入有效的手机号码！";
	} else {
		flag = true;
	}
	if (!flag) {
		$("#uname").val("");
		$("#uname").attr("placeholder", message);
		$("#uname").addClass("invalid");
		$("#uname").focus();
		$("#login-form-tips").css("color", "#FF8888");
		$("#login-form-tips").html("提示：" + message);
	} else {
		$("#login-form-tips").html("");
	}
	return flag;
}
// 检查 用户名||用户密码||验证码
function valiData(id,message){
	var value=$(id).val();
	var flag = false;
	if(value!=''){
		flag=true;
	}
	if (!flag) {
		$(id).attr("placeholder", message);
		$(id).addClass("invalid");
		$(id).focus();
		$("#login-form-tips").css("color", "#FF8888");
	    $("#login-form-tips").html("提示："+ message);
	} else {
		$("#login-form-tips").html("");
	}
	return flag;
}

// 切换显示或隐藏密码
function switchPwd(){
	if($("#passwordeye").hasClass("glyphicon-eye-close")){
		$("#passwordeye").removeClass("glyphicon-eye-close").addClass("glyphicon-eye-open");
		$("#password").attr("type","text");
	}else{
		$("#passwordeye").removeClass("glyphicon-eye-open").addClass("glyphicon-eye-close");
		$("#password").attr("type","password");
	}
}

// 移除placeholder样式
function remove(){
	$("#uname").removeClass("invalid");
	$("#password").removeClass("invalid");
	$("#code").removeClass("invalid");
	$("#uname").val("");
	$("#password").val("");
	$("#code").val("");
}

















































































































