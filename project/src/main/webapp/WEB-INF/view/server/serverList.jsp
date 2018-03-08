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
		<title>服务器清单</title>
		<%@include file = "../css.jsp" %>
		<link rel = "stylesheet" href = "<%=basePath%>js/extensions/css/bootstrap-table-fixed-columns.css" media="screen"/>
		<link rel="shortcut icon" type="image/x-icon" href="<%=basePath %>/images/logoes/way.ico" media="screen" />
		<%@include file = "../js.jsp" %>
		<script type = "text/javascript" src = "<%=basePath%>js/extensions/js/bootstrap-table-fixed-columns.js" charset="UTF-8"></script>
</head>
<body>
	<nav class="navbar navbar-default">
  		<div class="container-fluid">
  			<div class="navbar-header">
		      	<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
		        	<span class="sr-only">Toggle navigation</span>
		        	<span class="icon-bar"></span>
		        	<span class="icon-bar"></span>
		        	<span class="icon-bar"></span>
		      	</button>
		      	<a class="navbar-brand" href="<%=basePath%>server/toList.do">服务器管理</a>
		    </div>
		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		    	<ul class="nav navbar-nav navbar-right">
		        	<li><a href = "<%=basePath%>server/serverInfo.do?tid=0" class = "btn btn-link" title = "新增服务器"><i class="fa fa-plus fa-lg"></i>&nbsp;新增</a></li>
		        	<li><a href = "<%=basePath%>server/toList.do" class = "btn btn-link" title = "服务器清单"><i class="fa fa-list fa-lg"></i>&nbsp;清单</a></li>
		        	<li><a href = "<%=basePath%>server/exit.do" class = "btn btn-link" title = "登出服务器管理"><i class="fa fa-sign-out fa-lg"></i>&nbsp;登出</a></li>
		      	</ul>
		    </div>
  		</div>
  	</nav>
	<div class="container-fluid" id = "contentdiv"> 
		<div class = "row">
			<div class = "col-xs-12">
				<!-- 数据清单表 -->
		    	<table id = "dt"></table>
			</div>
		</div>
	</div>
	<script>
	   $(function(){
		   $('#dt').bootstrapTable({
			   url:"<%=basePath%>server/query/getAll.do", //请求后台的URL（*）
			   method: 'get', 		//请求方式（*）
			   dataType: "json",	//服务器返回数据类型
			   cache: false, 		//是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			   pagination: true, 	//是否显示分页（*）
			   sortable: true, 		//是否启用排序
			   sortOrder:"asc", 	//排序方式
			   sidePagination: "server", 	//分页方式：client客户端分页，server服务端分页（*）
			   pageSize:5, 					//每页的记录行数（*）
			   minimumCountColumns: 2,		//最少允许的列数
			   uniqueId: "tid", 			//每一行的唯一标识，一般为主键列
			   cardView: false, 			//是否显示详细视图
			   detailView: false, 			//是否显示父子表
			   dataLocale:"zh-CN",			//中文
			   fixedColumns:true,			//锁定列
			   fixedNumber:6,				//锁定的列数
			   columns: [{
			  	 	field: 'tid',
			   		title: 'TID',
			   		visible:false
			   },{
			  	 	field: 'machineName',
			   		title: '设备名称',
			   		align:'center',
					valign:'middle',
			   },{
			   		field: 'machineModel',
			   		title: '设备型号',
			   		align:'center',
					valign:'middle',
			   },{
			   		field: 'machineUsage',
			   		title: '设备用途',
			   		align:'center',
					valign:'middle',
			   },{
			  	 	field: 'serialNumber',
			   		title: '序列号',
			   		align:'center',
					valign:'middle',
			   },{
			   		field: 'rent',
			   		title: '是否租用',
			   		align:'center',
					valign:'middle',
			   },{
			   		field: 'rentEndDt',
			   		title: '到期时间',
			   		align:'center',
					valign:'middle',
			   },{
			  	 	field: 'os',
			   		title: '操作系统',
			   		align:'center',
					valign:'middle',
			   },{
			   		field: 'ip',
			   		title: 'IP地址',
			   		align:'center',
					valign:'middle',
			   },{
			   		field: 'cpuModel',
			   		title: 'CPU型号',
			   		align:'center',
					valign:'middle',
			   },{
			  	 	field: 'cpuCore',
			   		title: 'CPU核数',
			   		align:'center',
					valign:'middle',
			   },{
			   		field: 'memory',
			   		title: '内存(GB)',
			   		align:'center',
					valign:'middle',
			   },{
			   		field: 'disk',
			   		title: '磁盘大小(GB)',
			   		align:'center',
					valign:'middle',
			   },{
			  	 	field: 'usageCategory',
			   		title: '使用区分',
			   		align:'center',
					valign:'middle',
			   },{
			   		field: 'middleware',
			   		title: '中间件',
			   		align:'center',
					valign:'middle',
			   },{
			   		field: 'envirDistinguish',
			   		title: '环境区分',
			   		align:'center',
					valign:'middle',
			   },{
			  	 	field: 'machineAdd',
			   		title: '服务器所在地',
			   		align:'center',
					valign:'middle',
			   },{
			   		field: 'run',
			   		title: '运行状态',
			   		align:'center',
					valign:'middle',
			   },{
			   		field: 'manageBy',
			   		title: '运维团队',
			   		align:'center',
					valign:'middle',
			   },{
				   	field: 'action',
				   	title: 'Action',
			   		align:'center',
					valign:'middle',
			   }]
	   		}); 									
	   });	   
	</script>
</body>
</html>