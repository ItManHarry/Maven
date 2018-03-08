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
					<div class = "col-xs-10">
						<h6 class = "text-success"><i class = "fa fa-lightbulb-o fa-lg"></i>&nbsp;目录处于锁定状态下,不可进行编辑,点击启用后方可编辑!</h6>
					</div>
					<div class = "col-xs-1">
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
		<div class="modal fade" id="catalogform" tabindex="-1" role="dialog" aria-labelledby="updateFormLabel" aria-hidden="true">
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
									<label class = "col-xs-3 control-label">目录:</label>
									<div class = "col-xs-8">
										<input type = "text" class = "form-control" placeholder = "目录..." name = "name" id = "name"/>
									</div>
								</div>
								<div class = "form-group">
									<label class = "col-xs-3 control-label">根目录:</label>
									<div class = "col-xs-8">
										<select class = "form-control" id = "root">
											<option value = "0">否</option>
											<option value = "1">是</option>
										</select>
									</div>
								</div>
								<div class = "form-group">
									<label class = "col-xs-3 control-label">父目录:</label>
									<div class = "col-xs-6">
										<input type = "text" class = "form-control" name = "parentName" id = "parentName" readonly/>
										<input type = "hidden" name = "parentId" id = "parentId"/>
									</div>
									<div class = "col-xs-2">
										<button type = "button" class = "btn btn-primary btn-block btn-sm" id = "selectPNodeBtn"><i class="fa fa-folder"></i>&nbsp;&nbsp;选择</button>
									</div>
								</div>
								<div class = "form-group">
									<label class = "col-xs-3 control-label">最终目录:</label>
									<div class = "col-xs-8">
										<select class = "form-control" name = "leaf" id = "leaf"></select>
									</div>
								</div>
								<div class = "form-group">
									<label class = "col-xs-3 control-label">状态:</label>
									<div class = "col-xs-8">
										<select class = "form-control" name = "status" id = "status"></select>
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
		<!-- 选择父节点 -->
		<div class="modal fade" id="selectPNode" tabindex="-1" role="dialog" aria-labelledby="selectPNodeLabel" aria-hidden="true">
		   	<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						选择父目录&nbsp;&nbsp;<i class="fa fa-folder-o"></i>
			            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
			                  &times;
			            </button>
		         	</div>
		         	<div class="modal-body">
		         		<div class = "panel panel-default">
							<div class = "panel-body">
								<div class = "row" id = "tcodes" style = "margin-top:2px;position:relative;height:270px; overflow:auto;">
									<div class = "col-md-12">
										<ul id = "tree" class = "ztree"></ul>
									</div>
								</div>
							</div>
						</div>
					</div>
		      	</div>
			</div>
		</div>
	</div>
	<script>
	   var zTree = null;//目录树	
	   var cids = [];	//所有子节点ID
	   var setting = {	//树配置
	        check: {
	            enable: false
	        },
	        view: {
	            dblClickExpand: false,
	            showLine: true,
	            selectedMulti: false
	        },
	        data: {
	            simpleData: {
	                enable:true,
	                idKey: "id",
	                pIdKey: "pId",
	                rootPId: ""
	            }
	        },
	        callback: {
	            beforeClick: function(treeId, treeNode) {
	            	$.ajax({
		 			   type:"post",
		 			   url:"<%=basePath%>sys/catalog/getSysCatalog.do",
		 			   data:{tid:treeNode.id},
		 			   success:function(r){				 				   
		 				   if(r.leaf == 2){				 					  
		 					  sys_alert("系统消息", "最终目录不能作为父目录!", false, function(){});
		 				   }else{
		 					    var ps = [];
				     		    ps.push(treeNode.name);
				     		    var pn =  treeNode.getParentNode();
				     		    while(pn != null){
				     		    	ps.push(pn.name);
				     		    	pn = pn.getParentNode();
				     		    }
				     		    var path = [];
				     		    for(var i = ps.length - 1; i >= 0; i--){
				     		    	path.push(ps[i]);
				     		    }
				     		    $("#parentId").val(treeNode.id);
				     		    $("#parentName").val(path.join("/"));
				     		   	$("#selectPNode").modal("hide");
		 				   }
		 			   },
		 			   error:function(){
		 				   sys_alert("警告", "服务请求异常,请联系管理员!", false,  function(){});
		 			   }
			 		});
	            }
	        }
	    };
	   $(function(){
		   if('${authed}' == 'N'){
				$("#contentdiv").html("<h2 class = 'text-center text-danger'>您不具备目录管理权限,请联系管理员!</h2>");
			}else{
				//定义表格
			   $('#dt').bootstrapTable({
				   url:"<%=basePath%>sys/catalog/getAll.do", //请求后台的URL（*）
				   method: 'get', 		//请求方式（*）
				   dataType: "json",	//服务器返回数据类型
				   //toolbar: '#toolbar', //工具按钮用哪个容器
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
				   		field: 'ptname',
				   		title: '父目录'
				   },{
				   		field: 'name',
				   		title: '目录'
				   },{
				   		field: 'status',
				   		title: '状态'
				   },{
					   	field: 'action',
					   	title: 'Action'
				   }]
		   		});
			   //$("#dt").bootstrapTable('hideColumn', 'tid');	//隐藏ID列
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
				   $("#catalogform").modal("hide");
				   initValidator();
			   });
			   //表单校验
			   initValidator();
			   //点击保存按钮
			   $("#savebtn").click(function(){
				   initValidator();
				   $('#tf').bootstrapValidator('validate');
				   if($('#tf').data('bootstrapValidator').isValid()){
					   if($("#root").val() == 0 && $("#parentName").val() == ""){
						   sys_alert("系统消息", "父目录没有选择!", false, function(){});
					   }else{
						   if($.inArray($("#parentId").val(), cids) != -1){
							   sys_alert("系统消息", "父目录不能为当前目录及当前目录的子目录!", false, function(){});
						   }else{
							   $("#savebtn").attr("disabled", "disabled");//禁用保存按钮
							   $.ajax({
								   url:$("#tf").attr("action"),
								   type:"post",
								   data:$("#tf").serialize(),
								   success:function(r){
									   sys_alert("系统消息", r.result, false, function(){
										    $("#catalogform").modal("hide");
									   		$("#savebtn").removeAttr("disabled");//启用保存按钮
									   		$('#tf').data('bootstrapValidator').resetForm(true);
									   		//刷新表格
									   		$('#dt').bootstrapTable("refresh");
						            	});
								   },
								   error:function(){
									   
								   }
							   });  
						   }
					   }
				   } 
			   });
			   $("#root").change(function(){
				   if($(this).val() == 0){
					   $("#selectPNodeBtn").removeAttr("disabled");
				   }else{
					   $("#selectPNodeBtn").attr("disabled", "disabled");
					   $("#parentId").val("0");
					   $("#parentName").val("");
				   }
			   });
			   //选择父节点事件
			   $("#selectPNodeBtn").click(function(){
					//加载树结构,成功加载后显示窗体
				    $.ajax({
						type:"post",
						url:"<%=basePath%>sys/catalog/tree/getAll.do",
						data:{basePath:"<%=basePath%>"},
						success:function(r){
							var t = $("#tree");
							var zNodes = r.nodes;
							zTree = $.fn.zTree.init(t, setting, zNodes);
							$('#selectPNode').modal({backdrop:false});//设置点击窗体外的区域不可关闭窗体
						   	$("#selectPNode").modal("show");
						}
					});
			   });
			   //加载树结构
			   loadCatalogTree();
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
	                name: {
	                    message: '目录不能为空',
	                    validators: {
	                        notEmpty: {
	                            message: '目录不能为空'
	                        }
	                    }
	                }
	            }
			});
	   }
	   //新增
	   function add(){
		   	fillSelect("leaf","LEAF","","");	//最终目录
		   	fillSelect("status","CSTS","","");	//在用状态
		 	$("#root").removeAttr("disabled");
		 	$("#parentId").val("");
		 	$("#parentName").val("");
		 	$("#selectPNodeBtn").removeAttr("disabled");
		 	$("#root").val(0);
		 	$("#name").val("");
		   	destroyValidator("tf");
		   	$(".modal-title").text("新增");
		   	$("#tid").val(0);
		   	$('#tf').attr("action", "<%=basePath%>sys/catalog/add.do");
		   	showForm();
		   	$('#tf').data('bootstrapValidator').resetForm(true);
	   }
	   //编辑
	   function edit(e){
		   destroyValidator("tf");
		   $("#parentId").val("");
		   $("#parentName").val("");
		   $("#selectPNodeBtn").removeAttr("disabled");
		   $("#root").attr("disabled","disabled");
		   $(".modal-title").text("修改");
		   $('#tf').attr("action", "<%=basePath%>sys/catalog/update.do");
		   var tid = $(e).parent().parent().find("td:eq(0)").text();
		   $.ajax({
			   type:"post",
			   url:"<%=basePath%>sys/catalog/getSysCatalog.do",
			   data:{tid:tid},
			   success:function(r){
				   //赋值
				   $("#tid").val(tid);
				   $("#name").val(r.name);
				   if(r.parentId == "0" || r.parentId == "null" || r.parentId == null){
					   $("#root").val(1);
					   $("#selectPNodeBtn").attr("disabled", "disabled");
				   }
				   $("#parentId").val(r.parentId);
				   fillSelect("leaf","LEAF","",r.leaf);	//最终目录
				   fillSelect("status","CSTS","",r.status);	//在用状态
				   //重新加载树,然后获取路径
				   $.ajax({
						type:"post",
						url:"<%=basePath%>sys/catalog/tree/getAll.do",
						data:{basePath:"<%=basePath%>"},
						success:function(r){
							var t = $("#tree");
							var zNodes = r.nodes;
							zTree = $.fn.zTree.init(t, setting, zNodes);
							var treeNode = zTree.getNodeByParam("id", tid);
						    var ps = [];
			     		    var pn =  treeNode.getParentNode();
			     		    while(pn != null){
			     		    	 ps.push(pn.name);
			     		    	 pn = pn.getParentNode();
			     		    }
			     		    var path = [];
			     		    for(var i = ps.length - 1; i >= 0; i--){
			     		    	 path.push(ps[i]);
			     		    }
			     		    $("#parentName").val(path.join("/"));
			     		    //获取所有的子节点
			     		    idStr = tid+",";
			     		    getAllChildrenNodes(treeNode);
			     		    cids = idStr.split(",");
						    showForm();
						}
					});
			   },
			   error:function(){
				   sys_alert("警告", "服务请求异常,请联系管理员!", false,  function(){});
			   }
		   });
	   }
	   //停用/启用目录
	   function changeStatus(e, status){
		   var tid = $(e).parent().parent().find("td:eq(0)").text();
		   $.ajax({
			   type:"post",
			   url:"<%=basePath%>sys/catalog/status.do",
			   data:{tid:tid, status:status},
			   success:function(r){
				 	//刷新表格
			   		$('#dt').bootstrapTable("refresh");
			   },
			   error:function(){
				   sys_alert("警告", "服务请求异常,请联系管理员!", false,  function(){});
			   }
		   });
	   }
	   //加载目录树
	   function loadCatalogTree(){
			$.ajax({
				type:"post",
				url:"<%=basePath%>sys/catalog/tree/getAll.do",
				data:{basePath:"<%=basePath%>"},
				success:function(r){
					var t = $("#tree");
					var zNodes = r.nodes;
					zTree = $.fn.zTree.init(t, setting, zNodes);
				}
			});
	   }
	   //递归获取所有子目录的id值
	   function getAllChildrenNodes(treeNode){
       	 	var childrenNodes = treeNode.children;
        	if (childrenNodes.length != 0) {
            	for (var i = 0; i < childrenNodes.length; i++) {
                	idStr += childrenNodes[i].id + ',';
                	getAllChildrenNodes(childrenNodes[i]);
            	}
        	}else{
        		return ;
        	}
		}
	   //显示form窗体
	   function showForm(){
		   $('#catalogform').modal({backdrop:false});//设置点击窗体外的区域不可关闭窗体
		   $("#catalogform").modal("show");
	   }
	</script>
</body>
</html>