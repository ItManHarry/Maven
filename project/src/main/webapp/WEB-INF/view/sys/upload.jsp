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
		<title>文件上传</title>
		<link rel="shortcut icon" type="image/x-icon" href="<%=basePath %>/images/logoes/way.ico" media="screen" />
		<%@include file = "../css.jsp" %>
		<%@include file = "../js.jsp" %>
		<script type = "text/javascript" src = "<%=basePath%>js/jquery.form.js"></script>
	</head>
	<body>
		<jsp:include page="../common/head.jsp"></jsp:include>	
		<div class = "container container-sys-add" id = "contentdiv">
			<div class = "row" style = "padding:0;">
				<div class = "col-xs-3"> 
					<div class = "panel panel-default">
						<div class = "panel-heading">
							<i class = "fa fa-file-text-o fa-lg"></i>&nbsp;&nbsp;文件目录
						</div>
						<div class = "panel-body">
							<div class = "row">
								<div class = "col-xs-12">
									<ul id = "tree" class = "ztree"></ul>
								</div>
							</div>
						</div>
						<div class = "panel-footer">
							<div class = "row">
								<div class = "col-xs-6">
									<button class = "btn btn-link btn-block" id = "previous" onclick = "add();">
										<i class = "fa fa-plus"></i>&nbsp;&nbsp;新增目录
									</button>
								</div>
								<div class = "col-xs-6">
									<button class = "btn btn-link btn-block" id = "next" onclick = "update();">
										<i class = "fa fa-pencil"></i>&nbsp;&nbsp;修改目录
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class = "col-xs-9">
					<div class = "row">
						<div class = "col-xs-12">
							<div class = "panel panel-default">
								<div class = "panel-heading">
									<div class = "row">
										<div class = "col-xs-12 text-right">
											<button id = "addfile" class = "btn btn-link"><i class = "fa fa-plus-circle"></i>&nbsp;&nbsp;添加</button>
										</div>
									</div>
								</div>
								<form enctype="multipart/form-data" method="post" id = "uploadForm" name = "uploadForm" action = "<%=basePath%>sys/upload/file/doUpload.do">
									<div class = "panel-body" id = "files">
										<div class="row">
											<div class = "col-xs-11">
												<div class="form-group">
													<input type="file" class = "form-control" name = "file"/>
													<input type = "hidden" name = "catalog" id = "catalog" value = "0"/>
													<input type = "hidden" name = "fullPath" id = "fullPath" value = ""/>
												</div>
											</div>
										</div>
									</div>
								</form>
								<div class = "panel-footer">
									<div class = "row">
										<div  class = "col-xs-10 text-primary">
											<h5 id = "path"></h5>
										</div>
										<div class = "col-xs-2 text-right">
											<button type = "button" id = "uploadbtn" class="btn btn-link"><i class = "fa fa-upload"></i>&nbsp;&nbsp;上传</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class = "row">
						<div class = "col-xs-12">
							<table class = "table table-condensed table-hover">
								<thead>
									<tr>
										<th>文件</th>
										<th>文件夹</th>
										<th>上传时间</th>
										<th>&nbsp;</th>
									</tr>
								</thead>
								<tbody id = "docdata"></tbody>
							</table>
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
											<ul id = "ptree" class = "ztree"></ul>
										</div>
									</div>
								</div>
							</div>
						</div>
			      	</div>
				</div>
			</div>
		</div>
		<script type = "text/javascript">
			var tid = 0, parentId = 0, parentName = "", name = "" , leaf = 0, status = 0;//目录form各个值
			var uPid = 0, uPName = "";//新增时设置父目录ID及NAME
		 	var cids = [];		//所有子节点ID
		 	var zTree = null;	//目录树	
		 	var idStr = "";
			//加载树结构
		   	var addSetting = {
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
			 				   $("#catalog").val(r.tid);
			 				   tid = r.tid;
			 				   name = r.name;
			 				   leaf = r.leaf;
			 				   status = r.status;
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
				     		   //新增
				     		   $("#parentId").val(treeNode.id);
				     		   $("#parentName").val(path.join("/"));
				     		   $("#fullPath").val(path.join("/"));
				     		   $("#path").text("文件夹 : "+path.join(" / "));
				     		   //加载上传的文件
				     		   loadDocuments(tid);
				     		   //修改
				     		   uPid = treeNode.getParentNode().id;
				     		   path = [];
				     		   var pss = [];
				     		   for(var i = 1; i < ps.length; i++){
				     			   pss.push(ps[i]);
				     		   }
				     		   for(var i = pss.length - 1; i >= 0; i--){
				     		    	path.push(pss[i]);
				     		   }
				     		   uPName = path.join("/");
			 			   },
			 			   error:function(){
			 				   sys_alert("警告", "服务请求异常,请联系管理员!", false,  function(){});
			 			   }
				 		});
		            }
		        }
		    };
		   	var updateSetting = {	//树配置
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
					$("#contentdiv").html("<h2 class = 'text-center text-danger'>您不具备文件上传的权限,请联系管理员!</h2>");
				}else{
					//加载树
					loadCatalog();
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
									   		//刷新树
									   		loadCatalog();
						            	});
								   },
								   error:function(){
									   
								   }
							   });  
						   }
					   } 
				   });
				   //选择父节点事件
				   $("#selectPNodeBtn").click(function(){
					   idStr = "";
					   cids = [];
						//加载树结构,成功加载后显示窗体
					    $.ajax({
							type:"post",
							url:"<%=basePath%>sys/upload/catalog/getAll.do",
							data:{basePath:"<%=basePath%>"},
							success:function(r){
								var t = $("#ptree");
								var zNodes = r.nodes;
								zTree = $.fn.zTree.init(t, updateSetting, zNodes);
								var treeNode = zTree.getNodeByParam("id", tid);
								 //获取所有的子节点
				     		    idStr = tid+",";
				     		    getAllChildrenNodes(treeNode);
				     		    cids = idStr.split(",");
								$('#selectPNode').modal({backdrop:false});//设置点击窗体外的区域不可关闭窗体
							   	$("#selectPNode").modal("show");
							}
						});
				   });
					 //add more files
					$("#addfile").click(function(){
						$("#files").append("<div class = 'row'>"+
								"<div class = 'col-xs-11'>"+
									"<div class='form-group'><input type='file' class = 'form-control' name = 'file'/></div>"+
								"</div>"+
								"<div class = 'col-xs-1 text-right' style = 'padding:0'>"+
									"<button class = 'btn btn-link' onclick = 'rmFile(this)'><i class = 'fa fa-minus-circle fa-lg'></i></button>"+
								"</div></div>");
					});
					 //执行上传
					 $("#uploadbtn").click(function(){
						 if($("#catalog").val() == 0){
							 sys_alert("系统消息", "请选择文件目录!", false, function(){});
						 }else{
							 $("#uploadbtn").attr("disabled", "disabled");
							 $("#uploadForm").ajaxSubmit({
								  type:"post",
								  url:"<%=basePath%>sys/upload/file/doUpload.do",
								  contentType:"application/x-www-form-urlencoded; charset=utf-8",
								  success:function(r){
									  sys_alert("系统消息", r.result, false, function(){
										  $("#uploadbtn").removeAttr("disabled");
										  $("#uploadForm").find(":file").each(function(){
											  $(this).val("");
										  });
										  loadDocuments(tid);
									  });
								  },
								  error:function(){
									  sys_alert("系统消息", "上传异常,文件大小可能超过了100M!", false, function(){
										  $("#uploadbtn").removeAttr("disabled");
										  $("#uploadForm").find(":file").each(function(){
											  $(this).val("");
										  });
									  });
								  }
							  });
						 }
					 });
				}
			});
			//加载树
			function loadCatalog(){
				tid = 0;
				$("#tid").val(0);
				$("#parentName").val("");
				$.ajax({
					type:"post",
					url:"<%=basePath%>sys/upload/catalog/getAll.do",
					data:{basePath:"<%=basePath%>"},
					success:function(r){
						var t = $("#tree");
						var zNodes = r.nodes;
						zTree = $.fn.zTree.init(t, addSetting, zNodes);
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
			   cids = [];
			   if($("#parentName").val() != ""){
				   if(leaf == 2){				 					  
						  sys_alert("系统消息", "最终目录不能作为父目录!", false, function(){});
				   }else{
					 //检查是否选择了父目录
				   	fillSelect("leaf","LEAF","","");	//最终目录
				   	fillSelect("status","CSTS","","");	//在用状态
				 	$("#selectPNodeBtn").attr("disabled", "disabled");
				 	$("#name").val("");
				   	destroyValidator("tf");
				   	$(".modal-title").text("新增");
				   	$("#tid").val(0);
				   	$('#tf').attr("action", "<%=basePath%>sys/upload/catalog/add.do");
				   	showForm();
				   	$('#tf').data('bootstrapValidator').resetForm(true); 
				   }
			   }else{
				   sys_alert("系统消息", "请选择父目录!", false, function(){});
			   }
		   }
		   //修改
		   function update(){
			   if(tid == 0){
				   sys_alert("系统消息", "请选择要修改的目录!", false, function(){});
			   }else{
				   $("#tid").val(tid);
				   $("#name").val(name);
				   destroyValidator("tf");
				   $("#selectPNodeBtn").removeAttr("disabled");
				   $('#tf').attr("action", "<%=basePath%>sys/upload/catalog/update.do");
				   $("#parentId").val(uPid);
	     		   $("#parentName").val(uPName);
				   fillSelect("leaf","LEAF","",leaf);	//最终目录
				   fillSelect("status","CSTS","",status);	//在用状态
				   showForm();
			   }
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
			//移除附件
			function rmFile(e){
				$(e).parent().parent().remove();
			}
			//加载文件夹下的文件
			function loadDocuments(catalog){
				var url = "<%=basePath%>sys/download/file/download.do?docId=";
				$.ajax({
					type:"post",
					url:"<%=basePath%>sys/doc/getDocuments.do",
					data:{catalog:catalog,flag:"U"},
					success:function(r){
						$("#docdata").empty();
						if(r.length == 0)
							$("#docdata").append("<tr><td colspan = '4' class = 'text-center text-danger'>该文件夹下没有上传任何文件!</td></tr>");
						else
							for(var i = 0 ; i < r.length; i++){
								$("#docdata").append("<tr><td>"+r[i].docName+"</td><td>"+r[i].folderPath+"</td><td>"+r[i].uploadedDt+"</td><td><a href = '"+url+r[i].tid+"' class = 'btn btn-link'><i class = 'fa fa-download'></i>&nbsp;下载</a><button class = 'btn btn-link' onclick = 'deleteDoc("+r[i].tid+")'><i class = 'fa fa-trash'></i>&nbsp;删除</button></td></tr>");
							}
					},
					error:function(){
						sys_alert("系统消息", "数据获取异常!", false, function(){});
					}
				});
			}
			//删除文件
			function deleteDoc(docId){
				$.ajax({
					type:"post",
					url:"<%=basePath%>sys/doc/deleteDocument.do",
					data:{tid:docId},
					success:function(r){
						sys_alert("系统消息", r.result, false, function(){
							loadDocuments(tid);
						});
					},
					error:function(){
						sys_alert("系统消息", "文件删除异常,请联系管理员!", false, function(){});
					}
				});
			}
		</script>
	</body>
</html>