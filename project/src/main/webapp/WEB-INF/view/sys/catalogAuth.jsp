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
				<div class = "row">
					<div class = "col-xs-4">
						<div class = "panel panel-default">
							<div class = "panel-heading">
								<i class="fa fa-user-o"></i>&nbsp;&nbsp;系统用户
							</div>
							<div class = "panel-body">
								<!--ul class="pager">
							    	<li class="previous disabled" id = "previous"><a href="javascript:previous();"><i class = "fa fa-angle-left fa-lg"></i></a></li>
							    	<li class="next" id = "next"><a href="javascript:next();"><i class = "fa fa-angle-right fa-lg"></i></a></li>
							  	</ul-->
							  	<table class="table" id = "ut"></table>
							</div>
							<div class = "panel-footer">
								<div class = "row">
									<div class = "col-xs-3">
										<button class = "btn btn-link btn-block" id = "previous" onclick = "previous();">
											<i class = "fa fa-angle-left fa-lg"></i>
										</button>
									</div>
									<div class = "col-xs-3">
										<button class = "btn btn-link btn-block" id = "next" onclick = "next();">
											<i class = "fa fa-angle-right fa-lg"></i>
										</button>
									</div>
									<div class = "col-xs-6">
										<button class = "btn btn-success btn-block" id = "authbtn">
											<i class = "fa fa-key"></i>&nbsp;&nbsp;&nbsp;&nbsp;授&nbsp;&nbsp;&nbsp;&nbsp;权
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class = "col-xs-8">
						<div class = "panel panel-default">
							<div class = "panel-heading">
								<i class="fa fa-folder-o"></i>&nbsp;&nbsp;系统目录
							</div>
							<div class = "panel-body">
								<ul id = "tree" class = "ztree"></ul>
							</div>
						</div>
					</div>
				</div>
			</div> 
		</div>
	</div>
	<script>
	   var zTree = null;//目录树	
	   var total = 0, offset = 0, limit = 5;
	   var setting = {	//树配置
	        check: {
	            enable: true
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
	                zTree = $.fn.zTree.getZTreeObj("tree");
	                if (treeNode.isParent) {
	                    zTree.expandNode(treeNode);
	                    return false;
	                } else {
	                    return true;
	                }
	            }
	        }
	   };
	   $(function(){
		   if('${authed}' == 'N'){
				$("#contentdiv").html("<h2 class = 'text-center text-danger'>您不具备目录权限管理权限,请联系管理员!</h2>");
			}else{
				//加载用户
			   loadUsers(offset, limit);
			   //加载树结构
			   loadCatalogTree();
			   //执行授权
			   $("#authbtn").click(function(){
				   var userid = 0;
				   $("#ut").find(":radio").each(function(){
					   if($(this).is(":checked"))
						   userid = $(this).val();
				   });
				   if(userid == 0){
					   sys_alert("系统消息", "请选择用户!", false, function(){
						  
					   });
				   }else{
					   var tree = $.fn.zTree.getZTreeObj("tree");
						var nodes = tree.getCheckedNodes(true);//获取所有选中的节点
						var node ;
						var ids = [];
						for(var i = 0; i < nodes.length; i++){
							node = nodes[i];
							ids.push(node.id);
						}
						if(ids.join() == ""){
							sys_alert("系统消息", "目录没有指定!", false, function(){});
						}else{
							$("#authbtn").attr("disabled", "disabled");
							//执行保存
							$.ajax({
								url:"<%=basePath%>sys/catalog/auth/execute.do",
							   	type:"post",
							   	data:{userid:userid,catalog:ids.join()},
							   	success:function(r){
								   sys_alert("系统消息", r.result, false, function(){
									   $("#authbtn").removeAttr("disabled");
								   		loadUsers(offset, limit);
								   		loadCatalogTree();
					            	});
							   	},
							   	error:function(){
								   
							   	}
							});
						}
				   }
			   });
			}
	   });
	   //加载用户
	   function loadUsers(offset, limit){
		   $.ajax({
			   type:"post",
			   url:"<%=basePath%>sys/user/getAll.do",
			   data:{offset:offset, limit:limit},
			   success:function(r){
				   var users = r.rows;
				   total = r.total;
				   $("#ut").empty();
				   for(var i = 0; i < users.length; i++){
					   $("#ut").append("<tr><td><input type = 'radio' name = 'us' value = '"+users[i].tid+"' onclick = 'loadSetCatalog("+users[i].tid+")'></td><td>"+users[i].usernm+"</td></tr>");
				   }
			   },
			   error:function(){
				   
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
	   //加载已设置的目录权限
	   function loadSetCatalog(userid){
		   var tree = $.fn.zTree.getZTreeObj("tree");
		    var nodes = tree.transformToArray(tree.getNodes());
			var node ;
			for(var i = 0; i < nodes.length; i++){
				node = nodes[i];
				tree.checkNode(node, false);
			}
			$.ajax({
				url:"<%=basePath%>sys/catalog/auth/getSysCatalogAuth.do",
			   	type:"post",
			   	data:{userid:userid},
			   	success:function(r){
			   		for(var i = 0; i < nodes.length; i++){
						node = nodes[i];
						if($.inArray(node.id, r) >= 0)
							tree.checkNode(node, true);
					}
			   	},
			   	error:function(){
				   
			   	}
			});
	   }
	   //上一页
	   function previous(){
		   $("#next").removeClass("disabled");
		   if(offset != 0){
			   offset = offset - limit;
			   $.ajax({
				   type:"post",
				   url:"<%=basePath%>sys/user/getAll.do",
				   data:{offset:offset, limit:limit},
				   success:function(r){
					   var users = r.rows;
					   $("#ut").empty();
					   for(var i = 0; i < users.length; i++){
						   $("#ut").append("<tr><td><input type = 'radio' name = 'us' value = '"+users[i].tid+"' onclick = 'loadSetCatalog("+users[i].tid+")'></td><td>"+users[i].usernm+"</td></tr>");
					   }
					   if(offset == 0){
						   $("#previous").addClass("disabled"); 
					   }
				   },
				   error:function(){
					   
				   }
			   });
		   }else{
			   $("#previous").addClass("disabled");
		   }
	   }
	   //下一页
	   function next(){
		  $("#previous").removeClass("disabled");
		  if(offset+limit >= total)
			   	offset = (parseInt(total / limit)) * limit;
		  else
		  		offset = offset + limit;
		  if(total > limit && total > offset){
			  $.ajax({
				   type:"post",
				   url:"<%=basePath%>sys/user/getAll.do",
				   data:{offset:offset, limit:limit},
				   success:function(r){
					   var users = r.rows;
					   $("#ut").empty();
					   for(var i = 0; i < users.length; i++){
						   $("#ut").append("<tr><td><input type = 'radio' name = 'us' value = '"+users[i].tid+"' onclick = 'loadSetCatalog("+users[i].tid+")'></td><td>"+users[i].usernm+"</td></tr>");
					   }
					   if(offset+limit >= total){
						   $("#next").addClass("disabled"); 
					   }
				   },
				   error:function(){
					   
				   }
			   });
		  }else{
			  $("#next").addClass("disabled");
		  }
	   }
	</script>
</body>
</html>