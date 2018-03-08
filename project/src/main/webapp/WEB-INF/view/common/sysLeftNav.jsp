<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class = "panel panel-primary" style = "padding:0">
	<div class = "panel-heading">
		<i class = "fa fa-gears fa-lg"></i>&nbsp;&nbsp;&nbsp;&nbsp;系统管理
	</div>
	<div class = "panel-body" style = "padding:0">
		<ul  id = "menus">
		   	<li  class = "lit-menu-style" id = "sysCatalog">
		   		<h5><a href="<%=basePath%>sys/jump.do?key=sysCatalog">文档目录&nbsp;<i class = 'fa fa-hand-o-left'></i></a></h5>
		   	</li>
		   	<li class = "lit-menu-style" id = "catalogAuth">
		   		<h5>目录权限</h5>
		   	</li>
		   	<li class = "lit-menu-style" id = "sysUser">
		   		<h5>用户管理</h5>
		   	</li>
		   	<li class = "lit-menu-style" id = "sysTeam">
		   		<h5>组织管理</h5>
		   	</li>
		   	<li class = "lit-menu-style" id = "sysCode">
		   		<h5>系统Code</h5>
		   	</li>
		</ul>
	</div>
</div>
<script type = "text/javascript">
	var sysNavKey = "${sessionScope.get('sysNavKey')}";
	var roleId = "${sessionScope.get('roleId')}";
	$(function(){
		$("#menus").find("li").each(function(){
			var text = $(this).text();
			var id = $(this).attr("id");
			$(this).empty();
			if(sysNavKey == id){
				$(this).addClass("text-primary");
				$(this).append("<h5><a href='<%=basePath%>sys/jump.do?key="+id+"'>"+text+"<i class = 'fa fa-hand-o-left'></i></a></h5>");
			}else{
				$(this).removeClass("text-primary");
				$(this).append("<h5><a href='<%=basePath%>sys/jump.do?key="+id+"'>"+text+"</a></h5>");
			}
		});
	});
</script>
