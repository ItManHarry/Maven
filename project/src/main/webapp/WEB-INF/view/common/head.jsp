<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<link rel="shortcut icon" type="image/x-icon" href="<%=basePath %>/images/logoes/way.ico" media="screen" />
<!-- 网页头 -->
<div class = "container" style = "margin-top:5px;">
	<div class = "row">
		<div class = "col-xs-2">
			<img src = "<%=basePath%>images/logoes/logo1.png" class = "img-responsive">
		</div>
		<div class = "col-xs-10">
			<div class = "row">
				<div class = "col-xs-12 text-right" style = "padding-top:10px;">
					<span>
						<a href = "<%=basePath%>sys/home.do" class = "btn btn-link" title = "系统主页"><i class="fa fa-home fa-lg"></i></a>|
					</span>
					<span id = "login">
						<a href = "<%=basePath%>sys/jump.do?key=login" class = "btn btn-link" title = "系统登录"><i class = "glyphicon glyphicon-log-in"></i></a>
					</span>					
					<span id = "logout">
						<a href = "<%=basePath%>login/getOut.do" class = "btn btn-link" title = "系统登出"><i class = "glyphicon glyphicon-log-out"></i></a>
					</span>
					<span id = "loginu" class = "text-primary"><i class="fa fa-user-o"></i>&nbsp;&nbsp;${sessionScope.get('loginId')}</span>
				</div>
			</div>
		</div>
	</div>
	<div class = "row">
		<div class = "col-xs-12">
			<ul class="nav nav-tabs" id = "naves">
			  <!--li id = "manager" class = "pull-right"><a href="<%=basePath%>sys/jump.do?key=manager">系统管理</a></li>
			  <li id = "upload"  class = "pull-right"><a href="<%=basePath%>sys/jump.do?key=upload">文件上传</a></li>
			  <li id = "home" 	 class="active pull-right"><a href="<%=basePath%>sys/jump.do?key=home">共享文件</a></li-->
			  <li id = "home" 	 class="active"><a href="<%=basePath%>sys/jump.do?key=home">共享文件</a></li>
			  <li id = "upload"><a href="<%=basePath%>sys/jump.do?key=upload">文件上传</a></li>
			  <li id = "manager"><a href="<%=basePath%>sys/jump.do?key=manager">系统管理</a></li>
			</ul>
		</div>
	</div>
</div>
<script type = "text/javascript">
	var loginId = "${sessionScope.get('loginId')}";
	var navKey = "${sessionScope.get('navKey')}";
	$(function(){
		//显示隐藏登录与否
		if(loginId == ''){
			$("#logout").hide();
			$("#loginu").hide();
			$("#login").show();
		}else{
			$("#logout").show();
			$("#loginu").show();
			$("#login").hide();
		}
		if(navKey == "")
			navKey = "home";
		if(navKey == "sysCatalog")
			navKey = "manager";
		if(navKey == "catalogAuth")
			navKey = "manager";
		if(navKey == "sysUser")
			navKey = "manager";
		if(navKey == "sysTeam")
			navKey = "manager";
		if(navKey == "sysCode")
			navKey = "manager";		
		//激活导航栏
		$("#naves").find("li").each(function(){
			if($(this).attr("id") == navKey){
				$(this).addClass("active");
			}else{
				$(this).removeClass("active");
			}
		});
	});
</script>