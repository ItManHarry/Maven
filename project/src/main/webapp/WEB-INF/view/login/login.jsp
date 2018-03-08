<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<title>系统登录</title>
		<link rel="shortcut icon" type="image/x-icon" href="<%=basePath %>/images/logoes/way.ico" media="screen" />
		<%@include file = "../css.jsp" %>
		<%@include file = "../js.jsp" %>
	</head>
	<body>
		<jsp:include page="../common/head.jsp"></jsp:include>	
		<div class = "container container-sys-add">
			<div class = "row">
				<div class = "col-xs-4 col-xs-offset-4" style = "padding:0;margin-top:50px;">
					<form role = "form" class = "form-horizontal" id = "lf" method = "post" action = "<%=basePath%>login/getIn.do">
						<fieldset>
							<div class = "form-group">
								<div class = "col-xs-12">
									<div class="input-group input-group-sm">
									  	<span class="input-group-addon" id="sizing-addon-user"><i class = "fa fa-user-o fa-lg"></i>&nbsp;</span>
									  	<input type = "text" class = "form-control" placeholder = "AD账号..." name = "userId" id = "userId" aria-describedby="sizing-addon-user">
									</div>
								</div>
							</div><br>
							<div class = "form-group">
								<div class = "col-xs-12">
									<div class="input-group input-group-sm">
									  	<span class="input-group-addon" id="sizing-addon-pwd"><i class = "fa fa-key fa-lg"></i></span>
									  	<input type = "password" class = "form-control" placeholder = "密码..." name = "password" id = "password" aria-describedby="sizing-addon-pwd">
									</div>
								</div>  
							</div>
							<div class = "form-group">
								<div class = "col-xs-12 text-center text-danger">${errorMsg}</div> 
							</div>
							<div class = "form-group">
								<div class = "col-xs-12">
									<input type = "hidden" name = "key" value = "${key}">
									<button type = "submit" id = "loginbtn" class = "btn btn-primary btn-block btn-sm">
										登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录
									</button>
								</div> 
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
		<script type = "text/javascript">
			$(function(){
				
			});
			//校验是否为空
			function check(){
				initValidator();
				 $('#lf').bootstrapValidator('validate');
				 if($('#lf').data('bootstrapValidator').isValid()){
					return true;
				 }else{
					return false;
				 }
			}
			//初始化bootstrap校验
			function initValidator(){
				   $('#lf').bootstrapValidator({
						message: 'This value is not valid',
			            feedbackIcons: {
			                valid: 'glyphicon glyphicon-ok',
			                invalid: 'glyphicon glyphicon-remove',
			                validating: 'glyphicon glyphicon-refresh'
			            },
			            fields: {
			            	userId: {
			                    validators: {
			                        notEmpty: {
			                            message: 'AD账号不能为空'
			                        }
			                    }
			                },
			                password: {
			                    validators: {
			                        notEmpty: {
			                            message: '密码不能为空'
			                        }
			                    }
			                }
			            }
					});
			   }
		</script>
	</body>
</html>