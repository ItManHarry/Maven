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
					<!--div class = "col-xs-3">
						<div class="input-group">
		                    <input type="text" id = "userCdParam" class="form-control input-sm">
		                    <span class="input-group-btn">
		                        <button class="btn btn-default btn-sm" type="button" onclick = "reloadData();">Find</button>
		                    </span>
		                </div>
					</div-->
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
		<div class="modal fade" id="userform" tabindex="-1" role="dialog" aria-labelledby="updateFormLabel" aria-hidden="true">
		   	<div class="modal-dialog">
				<div class="modal-content">
		         	<div class="modal-header">
			            <h4 class="modal-title" id="myModalLabel">修改</h4>
		         	</div>
		         	<div class="modal-body">
						<form role = "form" class = "form-horizontal" id = "uf" action = "" method = "post">
							<fieldset>
								<input type = "hidden" name = "tid" id = "tid"/>
								<div class = "form-group">
									<label class = "col-xs-3 control-label">法人所属:</label>
									<div class = "col-xs-8">
										<select class = "form-control" name = "bg" id = "bg"></select>
									</div>  
								</div>
								<div class = "form-group">
									<label class = "col-xs-3 control-label">Team所属:</label>
									<div class = "col-xs-8">
										<select class = "form-control" name = "teamid" id = "teamid"></select>
									</div>  
								</div>
								<div class = "form-group">
									<label class = "col-xs-3 control-label">用户代码:</label>
									<div class = "col-xs-8">
										<input type = "text" class = "form-control" placeholder = "用户代码......" name = "usercd" id = "usercd"/>  
									</div>
								</div>
								<div class = "form-group">
									<label class = "col-xs-3 control-label">用户姓名:</label>
									<div class = "col-xs-8">
										<input type = "text" class = "form-control" placeholder = "用户姓名......" name = "usernm" id = "usernm"/>  
									</div>
								</div>
								<div class = "form-group">
									<label class = "col-xs-3 control-label">用户角色:</label>
									<div class = "col-xs-8">
										<select class = "form-control" name = "roleid" id = "roleid"></select>
									</div>  
								</div>
								<div class = "form-group">
									<label class = "col-xs-3 control-label">是否在用:</label>
									<div class = "col-xs-8">
										<select class = "form-control" name = "status" id = "status">
											<option value = "1">在用</option>
											<option value = "2">停用</option>
										</select>
									</div>
								</div>
								<div class = "form-group">
									<div class = "col-xs-4 col-xs-offset-8">
										<div class = "checkbox">
											<button type = "button" class = "btn btn-primary btn-sm" id = "savebtn"><i class="fa fa-save fa-lg"></i>&nbsp;&nbsp;保存</button>
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
				$("#contentdiv").html("<h2 class = 'text-center text-danger'>您不具备用户管理权限,请联系管理员!</h2>");
			}else{
			 //加载表格数据
			   var userCd = $("#userCdParam").val();
			   $('#dt').bootstrapTable({
				   url:"<%=basePath%>sys/user/getAll.do?userCd="+userCd, //请求后台的URL（*）
				   method: 'get', 		//请求方式（*）
				   dataType: "json",	//服务器返回数据类型
				   //toolbar: '#toolbar', //工具按钮用哪个容器
				   cache: false, 		//是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				   pagination: true, 	//是否显示分页（*）
				   sortable: true, 		//是否启用排序
				   sortOrder: "asc", 	//排序方式
				   //queryParams: {userCd:"20112004",pageSize: 10},	//传递参数（*）
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
				  	 	field: 'team',
				   		title: 'Team所属'
				   },{
				  	 	field: 'usercd',
				   		title: '用户代码'
				   },{
				   		field: 'usernm',
				   		title: '用户姓名'
				   },{
				   		field: 'role',
				   		title: '用户角色'
				   },{
				   		field: 'status',
				   		title: '是否在用'
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
				  reloadData();
			   });
			   //取消编辑
			   $("#cancelbtn").click(function(){
				   $("#userform").modal("hide");
				   initValidator();
			   });
			   //表单校验
			   initValidator();
			   //点击保存按钮
			   $("#savebtn").click(function(){
				   initValidator();
				   $('#uf').bootstrapValidator('validate');
				   if($('#uf').data('bootstrapValidator').isValid()){
					   $("#savebtn").attr("disabled", "disabled");//禁用保存按钮
					   $.ajax({
						   url:$("#uf").attr("action"),
						   type:"post",
						   data:$("#uf").serialize(),
						   success:function(r){
							   if(r.result == "exist"){
								   sys_alert("系统消息", "用户已存在!", false, function(){
									   $("#savebtn").removeAttr("disabled");//启用保存按钮
								   });
							   }else{
								   sys_alert("系统消息", r.result, false, function(){
									    $("#userform").modal("hide");
								   		$("#savebtn").removeAttr("disabled");//启用保存按钮
								   		$('#uf').data('bootstrapValidator').resetForm(true);
								   		//刷新表格
								   		$('#dt').bootstrapTable("refresh");
					            	});
							   }
						   },
						   error:function(){
							   
						   }
					   });
				   }
			   });
			   $("#bg").change(function(){
				   fillTeams($(this).val(), 0);
			   });
			}
	   });
	   //重新加载数据
	   function reloadData(){
		   //var userCd = $("#userCdParam").val();
		   //$('#dt').bootstrapTable("refresh", {"url":"<%=basePath%>user/all.action?userCd="+userCd});
		   $('#dt').bootstrapTable("refresh");
	   }
	   //初始化校验
	   function initValidator(){
		   $('#uf').bootstrapValidator({
				message: 'This value is not valid',
	            feedbackIcons: {
	                valid: 'glyphicon glyphicon-ok',
	                invalid: 'glyphicon glyphicon-remove',
	                validating: 'glyphicon glyphicon-refresh'
	            },
	            fields: {
	            	usercd: {
	                    message: '用户代码不能为空',
	                    validators: {
	                        notEmpty: {
	                            message: '用户代码不能为空'
	                        }
	                    }
	                },
	                usernm: {
	                    message: '用户姓名不能为空',
	                    validators: {
	                        notEmpty: {
	                            message: '用户姓名不能为空'
	                        }
	                    }
	                },
	                teamid: {
	                    message: '请选择Team所属',
	                    validators: {
	                        notEmpty: {
	                            message: '请选择Team所属'
	                        }
	                    }
	                }
	            }
			});
	   }
	   //新增
	   function add(){
		   fillSelect("bg","BG","0","");		//法人信息
		   fillTeams(1, 0);						//加载Team信息
		   fillSelect("roleid","ROLE","0","");	//角色信息
		   fillSelect("status","STATUS","0","");//系统状态
		   $("#userCd").removeAttr("disabled");
		   $("#savebtn").removeAttr("disabled");//启用保存按钮
		   $("#moduleCd").val("none");
		   destroyValidator("uf");
		   $(".modal-title").text("新增");
		   $("#tid").val(0);
		   $('#uf').attr("action", "<%=basePath%>sys/user/add.do");
		   showForm();
		   $('#uf').data('bootstrapValidator').resetForm(true);
	   }
	   //编辑
	   function edit(e){
		   $("#userCd").attr("disabled", "disabled");
		   $("#savebtn").removeAttr("disabled");//启用保存按钮
		   destroyValidator("uf");
		   $(".modal-title").text("修改");
		   $('#uf').attr("action", "<%=basePath%>sys/user/update.do");
		   var tid = $(e).parent().parent().find("td:eq(0)").text();
		   $.ajax({
			   type:"post",
			   url:"<%=basePath%>sys/user/getUser.do",
			   data:{tid:tid},
			   success:function(r){
				   //赋值
				   $("#tid").val(tid);
				   $("#usercd").val(r.usercd);
				   $("#usernm").val(r.usernm);
				   fillSelect("bg","BG","0",r.bg);				//法人信息
				   fillTeams(r.bg, r.teamid);					//加载Team信息
				   fillSelect("roleid","ROLE","0",r.roleid);	//角色信息
				   fillSelect("status","STATUS","0",r.status);  //系统状态
				   showForm();
			   },
			   error:function(){
				   sys_alert("警告", "服务请求异常,请联系管理员!", false,  function(){});
			   }
		   });
	   }
	   //加载Team信息
	   function fillTeams(bg, v){
		   $.ajax({
			   type:"post",
			   url:"<%=basePath%>sys/team/getTeams.do",
			   data:{bg:bg},
			   success:function(r){
				  $("#teamid").empty();
				  for(var i = 0; i < r.length; i++){
					  if(v == r[i].tid)
					  	$("#teamid").append("<option value = '"+r[i].tid+"' selected>"+r[i].teamnm+"</option>");
					  else
						$("#teamid").append("<option value = '"+r[i].tid+"'>"+r[i].teamnm+"</option>");
				  }
			   },
			   error:function(){
				   sys_alert("警告", "服务请求异常,请联系管理员!", false,  function(){});
			   }
		   });
	   }
	   //显示form窗体
	   function showForm(){
		   $('#userform').modal({backdrop:false});//设置点击窗体外的区域不可关闭窗体
		   $("#userform").modal("show");
	   }
	</script>
</body>
</html>