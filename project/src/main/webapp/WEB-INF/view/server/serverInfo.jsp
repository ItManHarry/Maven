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
		<title>服务器</title>
		<%@include file = "../css.jsp" %>
		<link rel = "stylesheet" href = "<%=basePath%>css/bootstrap-datepicker3.min.css" media="screen"/>
		<link rel="shortcut icon" type="image/x-icon" href="<%=basePath %>/images/logoes/way.ico" media="screen" />
		<%@include file = "../js.jsp" %>
		<script type = "text/javascript" src = "<%=basePath%>js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
		<script type = "text/javascript" src = "<%=basePath%>js/locales/bootstrap-datepicker.zh-CN.min.js" charset="UTF-8"></script>
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
		<form role = "form" class = "form-horizontal" id = "tf" action = "<%=basePath%>server/admin/save.do" method = "post">
			<fieldset>
				<legend>基本信息</legend>
				<input type = "hidden" name = "tid" id = "tid" value = "${si.tid }"/>
				<div class = "form-group">
					<label class = "col-xs-1 control-label">设备名称:</label>
					<div class = "col-xs-3">
						<input type = "text" class = "form-control" placeholder = "设备名称......" name = "machineName" id = "machineName" value = "${si.machineName}"/>  
					</div>  
					<label class = "col-xs-1 control-label">设备型号:</label>
					<div class = "col-xs-3">
						<input type = "text" class = "form-control" placeholder = "设备型号......" name = "machineModel" id = "machineModel" value = "${si.machineModel}"/>  
					</div> 
					<label class = "col-xs-1 control-label">序列号:</label>
					<div class = "col-xs-3">
						<input type = "text" class = "form-control" placeholder = "序列号......" name = "serialNumber" id = "serialNumber" value = "${si.serialNumber}"/> 
					</div>  
				</div>
				<div class = "form-group" id = "rentinfo">
					<label class = "col-xs-1 control-label">设备用途:</label>
					<div class = "col-xs-3">
						<input type = "text" class = "form-control" placeholder = "设备用途......" name = "machineUsage" id = "machineUsage" value = "${si.machineUsage}"/> 
					</div>  
					<label class = "col-xs-1 control-label">是否租用:</label>
					<div class = "col-xs-3">
						<select class = "form-control" name = "rent" id = "rent"></select>  
					</div> 
					<label class = "col-xs-1 control-label">到期时间:</label>
					<div class = "col-xs-3">
						<div class = "input-group date" id = "rentEndDtDiv">
							<span class="input-group-addon">
					        	<i class="fa fa-calendar"></i>
					        </span>
							<input type='text' class="form-control" name = "rentEndDt" id = 'rentEndDt' placeholder = "租用到期日......" value = "${si.rentEndDt}" readonly/>
						</div>
					</div> 
				</div>
			</fieldset>
			<fieldset>
				<legend>设备信息</legend>
				<div class = "form-group">
					<label class = "col-xs-1 control-label">操作系统:</label>
					<div class = "col-xs-3">
						<select class = "form-control" name = "os" id = "os"></select>  
					</div> 
					<label class = "col-xs-1 control-label">IP地址:</label>
					<div class = "col-xs-3">
						<input type = "text" class = "form-control" placeholder = "IP地址......" name = "ip" id = "ip" value = "${si.ip}"/> 
					</div> 
					<label class = "col-xs-1 control-label">CPU:</label>
					<div class = "col-xs-3">
						<input type = "text" class = "form-control" placeholder = "CPU......" name = "cpuModel" id = "cpuModel" value = "${si.cpuModel }"/> 
					</div>  
				</div>
				<div class = "form-group">
					<label class = "col-xs-1 control-label">CPU核数:</label>
					<div class = "col-xs-3">
						<input type = "text" class = "form-control" placeholder = "CPU核数......" name = "cpuCore" id = "cpuCore" value = "${si.cpuCore }"/>   
					</div> 
					<label class = "col-xs-1 control-label">系统内存:</label>
					<div class = "col-xs-3">
						<div class="input-group">
						 	<input type = "text" class = "form-control" placeholder = "系统内存......" name = "memory" id = "memory" value = "${si.memory }"/>
						  	<span class="input-group-addon">GB</span>
						</div>
					</div>  
					<label class = "col-xs-1 control-label">磁盘容量:</label>
					<div class = "col-xs-3">
						<div class="input-group">
						 	<input type = "text" class = "form-control" placeholder = "磁盘容量......" name = "disk" id = "disk" value = "${si.disk }"/>
						  	<span class="input-group-addon">GB</span>
						</div>
					</div>  
				</div>
				<fieldset>
					<legend>运行信息</legend>
					<div class = "form-group">
						<label class = "col-xs-1 control-label">使用类别:</label>
						<div class = "col-xs-3">
							<select class = "form-control" name = "usageCategory" id = "usageCategory"></select>  
						</div> 
						<label class = "col-xs-1 control-label">中间件:</label>
						<div class = "col-xs-3">
							<select class = "form-control" name = "middleware" id = "middleware"></select> 
						</div> 
						<label class = "col-xs-1 control-label">运维团队:</label>
						<div class = "col-xs-3">
							<select class = "form-control" name = "manageBy" id = "manageBy"></select>
						</div>  
					</div>
					<div class = "form-group">
						<label class = "col-xs-1 control-label">所属机房:</label>
						<div class = "col-xs-3">
							<select class = "form-control" name = "machineAdd" id = "machineAdd"></select>  
						</div> 
					</div>
					<div class = "form-group">
						<label class = "col-xs-1 control-label">使用区分:</label>
						<div class = "col-xs-3">
							<label class="radio-inline">
							  <input type="radio" name="envirDistinguish" checked value="1"> 正式环境
							</label>
							<label class="radio-inline">
							  <input type="radio" name="envirDistinguish" value="2"> 测试环境
							</label>
						</div> 
					</div>
					<div class = "form-group">
						<label class = "col-xs-1 control-label">运行状态:</label>
						<div class = "col-xs-3">
							<label class="radio-inline">
							  <input type="radio" name="run" checked value="1"> 运行正常
							</label>
							<label class="radio-inline">
							  <input type="radio" name="run" value="2"> 停止运行
							</label>
						</div>  
					</div>
				</fieldset>
			</fieldset>
			<div class = "form-group">
				<div class = "col-xs-12 text-right">
					<button type = "submit" class = "btn btn-primary"><i class = "fa fa-save fa-lg"></i>&nbsp;&nbsp;保存</button>
				</div>  
			</div>
		</form>
	</div>
	<script>
	   $(function(){
		   initValidator();
		   $('#rentEndDtDiv').datepicker({
			   	language:"zh-CN",
	            autoclose:true,
	            clearBtn:true,
	            todayHighlight:true,
	            todayBtn:'linked',
			    format:'yyyy-mm-dd'
			});
		 	//是否租用
		   	fillSelect("rent","RENT","0","${si.rent}");
		  	//操作系统
		   	fillSelect("os","OSTP","0","${si.os}");	
		  	//使用类别
		   	fillSelect("usageCategory","MCHUSAGE","0","${si.usageCategory}");	
		  	//中间件
		   	$("#usageCategory").change(function(){
			   	if($(this).val() == 2)
				   fillSelect("middleware","MIDDLEWARE","0", "${si.middleware}");	
				else
					$("#middleware").empty();
		   	});
		  	if("${si.usageCategory}" == 2){
		  		fillSelect("middleware","MIDDLEWARE","0", "${si.middleware}");	
		  	}
		  	//所在机房
		   	fillSelect("machineAdd","SERADD","0","${si.machineAdd}");	
		  	//运维团队
		   	fillTeams(1, "${si.manageBy}");	
		  	//使用区分
		  	if("${si.envirDistinguish}" != ""){
		  		$(":radio[name=envirDistinguish]").each(function(){
		  			if("${si.envirDistinguish}" == $(this).val())
		  				$(this).attr("checked","checked");
		  			else
		  				$(this).removeAttr("checked");
		  		});
		  	}
		  	//运行状态
		  	if("${si.run}" != ""){
		  		$(":radio[name=run]").each(function(){
		  			if("${si.run}" == $(this).val())
		  				$(this).attr("checked","checked");
		  			else
		  				$(this).removeAttr("checked");
		  		});
		  	}
		  		
	   });
	   //加载Team信息
	   function fillTeams(bg, v){
		   $.ajax({
			   type:"post",
			   url:"<%=basePath%>sys/team/getTeams.do",
			   data:{bg:bg},
			   success:function(r){
				  $("#manageBy").empty();
				  for(var i = 0; i < r.length; i++){
					  if(v == r[i].tid)
					  	$("#manageBy").append("<option value = '"+r[i].tid+"' selected>"+r[i].teamnm+"</option>");
					  else
						$("#manageBy").append("<option value = '"+r[i].tid+"'>"+r[i].teamnm+"</option>");
				  }
			   },
			   error:function(){
				   sys_alert("警告", "服务请求异常,请联系管理员!", false,  function(){});
			   }
		   });
	   }
	   //初始化校验
	   function initValidator(){
		   $('#tf').bootstrapValidator({
				message: 'This value is not valid',
	            feedbackIcons: {
	                valid: 'glyphicon glyphicon-ok',
	                invalid: 'glyphicon glyphicon-remove',
	                validating: 'glyphicon glyphicon-refresh'
	            },
	            fields: {
	            	machineName: {
	                    message: '设备名称不能为空',
	                    validators: {
	                        notEmpty: {
	                            message: '设备名称不能为空'
	                        }
	                    }
	                },
	                machineUsage: {
	                    message: '设备用途不能为空',
	                    validators: {
	                        notEmpty: {
	                            message: '设备用途不能为空'
	                        }
	                    }
	                },
	                ip: {
	                    message: 'IP地址不能为空',
	                    validators: {
	                        notEmpty: {
	                            message: 'IP地址不能为空'
	                        }
	                    }
	                }
	            }
			});
	   }
	</script>
</body>
</html>