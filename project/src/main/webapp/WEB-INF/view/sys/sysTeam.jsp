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
		<title>系统管理</title>
		<link rel="shortcut icon" type="image/x-icon" href="<%=basePath %>/images/logoes/way.ico" media="screen" />
		<%@include file = "../css.jsp" %>
		<style>
			html { overflow-x:hidden; }
		</style>
		<%@include file = "../js.jsp" %>
</head>
<body>
	<jsp:include page="../common/head.jsp"></jsp:include>	
	<div class="container container-sys-add" id = "contentdiv"> 
		<div class = "row">
			<div class = "col-xs-2"> 
				<jsp:include page="../common/sysLeftNav.jsp"></jsp:include>	
			</div>
			<div class = "col-xs-10">
				<div class = "row" style = "padding-bottom:5px;">
					<div class = "col-xs-1 col-xs-offset-10">
						<button id="btn-add" type="button" class="btn btn-link btn-xs btn-block">
							<span class="fa fa-plus" aria-hidden="true">&nbsp;&nbsp;新增</span>
						</button>
					</div>
					<div class = "col-xs-1">
						<button id="btn-refresh" type="button" class="btn btn-link btn-xs btn-block">
							<span class="fa fa-refresh" aria-hidden="true">&nbsp;&nbsp;刷新</span>
						</button>
					</div>
				</div>
				<div class = "row">
					<div class = "col-xs-12">
						<!-- 数据清单表 -->
				    	<table id = "dt"></table>
					</div>
				</div>
			</div>
		</div>
		<!-- 修改记录表单 -->
		<div class="modal fade" id="teamform" tabindex="-1" role="dialog" aria-labelledby="updateFormLabel" aria-hidden="true">
		   	<div class="modal-dialog">
				<div class="modal-content">
		         	<div class="modal-header">
			            <h4 class="modal-title" id="myModalLabel">修改</h4>
		         	</div>
		         	<div class="modal-body">
						<form role = "form" class = "form-horizontal" id = "tf" action = "" method = "post">
							<fieldset>
								<input type = "hidden" name = "tid" id = "tid"/>
								<div class = "form-group">
									<label class = "col-xs-3 control-label">法人所属:</label>
									<div class = "col-xs-8">
										<select class = "form-control" name = "bg" id = "bg"></select>
									</div>  
								</div>
								<div class = "form-group">
									<label class = "col-xs-3 control-label">Team代码:</label>
									<div class = "col-xs-8">
										<input type = "text" class = "form-control" placeholder = "Team代码......" name = "teamcd" id = "teamcd"/>
									</div>  
								</div>
								<div class = "form-group">
									<label class = "col-xs-3 control-label">Team名称:</label>
									<div class = "col-xs-8">
										<input type = "text" class = "form-control" placeholder = "Team名称......" name = "teamnm" id = "teamnm"/>
									</div>
								</div>
								<div class = "form-group">
									<div class = "col-xs-4 col-xs-offset-8">
										<div class = "checkbox">
											<button type = "button" class = "btn btn-primary btn-sm" id = "savebtn"><i class = "fa fa-save fa-lg"></i>&nbsp;&nbsp;保存</button>
											<button type = "button" class = "btn btn-default btn-sm" id = "cancelbtn"><i class="fa fa-remove fa-lg"></i>&nbsp;&nbsp;取消</button>
										</div>
									</div>  
								</div>
							</fieldset>
						</form>
					</div>
		      	</div>
			</div>
		</div>
	</div>
	<script>
	   $(function(){
		   if('${authed}' == 'N'){
				$("#contentdiv").html("<h2 class = 'text-center text-danger'>您不具备组织管理权限,请联系管理员!</h2>");
			}else{
			 //定义表格
			   $('#dt').bootstrapTable({
				   url:"<%=basePath%>sys/team/getAll.do", //请求后台的URL（*）
				   method: 'get', 		//请求方式（*）
				   dataType: "json",	//服务器返回数据类型
				   cache: false, 		//是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				   pagination: true, 	//是否显示分页（*）
				   sortable: true, 		//是否启用排序
				   sortOrder: "asc", 	//排序方式
				   sidePagination: "server", 		//分页方式：client客户端分页，server服务端分页（*）
				   pageSize: 10, 					//每页的记录行数（*）
				   minimumCountColumns: 2,		 	//最少允许的列数
				   uniqueId: "tid", 				//每一行的唯一标识，一般为主键列
				   cardView: false, 				//是否显示详细视图
				   detailView: false, 				//是否显示父子表
				   dataLocale:"zh-CN",
				   columns: [{
				  	 	field: 'tid',
				   		title: 'TID'
				   },{
				  	 	field: 'bg',
				   		title: '法人所属'
				   },{
				   		field: 'teamcd',
				   		title: 'Team代码'
				   },{
				   		field: 'teamnm',
				   		title: 'Team名称'
				   },{
					   	field: 'action',
					   	title: 'Action'
				   }]
		   		});
			   //按钮事件-新增
			   $("#btn-add").click(function(){
				   add();
			   });
			   //按钮事件-刷新
			   $("#btn-refresh").click(function(){
				   $('#dt').bootstrapTable("refresh");
			   });
			   //取消编辑
			   $("#cancelbtn").click(function(){
				   $("#teamform").modal("hide");
				   initValidator();
			   });
			   //表单校验
			   initValidator();
			   //点击保存按钮
			   $("#savebtn").click(function(){
				   initValidator();
				   $('#tf').bootstrapValidator('validate');
				   if($('#tf').data('bootstrapValidator').isValid()){
					   $("#savebtn").attr("disabled","disabled");//禁用保存按钮
					   $.ajax({
						   url:$("#tf").attr("action"),
						   type:"post",
						   data:$("#tf").serialize(),
						   success:function(r){
							   sys_alert("系统消息", r.result, false, function(){
								    $("#teamform").modal("hide");
							   		$("#savebtn").removeAttr("disabled");//启用保存按钮
							   		$('#tf').data('bootstrapValidator').resetForm(true);
							   		//刷新表格
							   		$('#dt').bootstrapTable("refresh");
				            	});
						   },
						   error:function(){
							   sys_alert("系统消息", "ERROR", false, function(){});
						   }
					   });
				   }
			   });
			}
	   });
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
	                teamcd: {
	                    message: 'Team代码不能为空',
	                    validators: {
	                        notEmpty: {
	                            message: 'Team代码不能为空'
	                        }
	                    }
	                },
	                teamnm: {
	                    message: 'Team名称不能为空',
	                    validators: {
	                        notEmpty: {
	                            message: 'Team名称不能为空'
	                        }
	                    }
	                }
	            }
			});
	   }
	   //新增
	   function add(){
		   fillSelect("bg","BG","0","");
		   $("#savebtn").removeAttr("disabled");//启用保存按钮
		   destroyValidator("tf");
		   $(".modal-title").text("新增");
		   $("#tid").val(0);
		   $("#bg").val('');
		   $("#teamcd").val('');
		   $("#teamnm").val('');
		   $('#tf').attr("action", "<%=basePath%>sys/team/add.do");
		   showForm();
		   $('#tf').data('bootstrapValidator').resetForm(true);
	   }
	   //编辑
	   function edit(e){
		   destroyValidator("tf");
		   $(".modal-title").text("修改");
		   $('#tf').attr("action", "<%=basePath%>sys/team/update.do");
		   var tid = $(e).parent().parent().find("td:eq(0)").text();
		   $.ajax({
			   type:"post",
			   url:"<%=basePath%>sys/team/getTeam.do",
			   data:{tid:tid},
			   success:function(r){
				   //赋值
				   $("#tid").val(tid);
				   fillSelect("bg","BG","0",r.bg);
				   $("#teamcd").val(r.teamcd);
				   $("#teamnm").val(r.teamnm);
				   showForm();
			   },
			   error:function(){
				   sys_alert("警告", "服务请求异常,请联系管理员!", false,  function(){});
			   }
		   });
	   }
	   //显示form窗体
	   function showForm(){
		   $('#teamform').modal({backdrop:false});//设置点击窗体外的区域不可关闭窗体
		   $("#teamform").modal("show");
	   }
	</script>
</body>
</html>