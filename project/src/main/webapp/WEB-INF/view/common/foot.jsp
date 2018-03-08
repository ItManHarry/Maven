<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class = "row">
	<div class = "col-xs-12 text-center" style = "margin-top:10px;margin-bottom:10px;" id = "footdiv">
		<img src = "<%=basePath %>images/logoes/logo_black.png">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		COPYRIGHT&nbsp;&copy;&nbsp;2017&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DOOSAN ALL RIGHTS RESERVED.
	</div>
</div>	
