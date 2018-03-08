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
		<title>文档共享</title>
		<link rel="shortcut icon" type="image/x-icon" href="<%=basePath %>/images/logoes/way.ico" media="screen" />
		<%@include file = "css.jsp" %>
		<%@include file = "js.jsp" %>
	</head>
	<body>
		<jsp:include page="common/head.jsp"></jsp:include>	
		<div class = "container container-sys-add">
			<div class = "row" style = "padding:0;">
				<div class = "col-xs-3"> 
					<div class = "panel panel-default">
						<!--div class = "panel-heading">
							<i class = "fa fa-file-text-o fa-lg"></i>&nbsp;&nbsp;文件目录
						</div-->
						<div class = "panel-body">
							<div class = "row">
								<div class = "col-xs-12">
									<ul id = "tree" class = "ztree"></ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class = "col-xs-9">
					<div class = "row" style = "padding:0;">
						<div class = "col-xs-7">
							<span id = "folderPathView">&nbsp;</span>
						</div>
						<div class = "col-xs-5">
							<div class="input-group">
			                    <input type="text" name = "docName" id = "docName" class="form-control input-sm">
			                    <span class="input-group-btn">
			                        <button class="btn btn-primary btn-sm" type="button" onclick = "doSearch();"><i class = "glyphicon glyphicon-search"></i>&nbsp;查找</button>
			                    </span>
			                </div>
						</div>
					</div>
					<div class = "row" style = "margin-top:10px;padding:0;">
						<div class = "col-xs-12">
							<!-- 文档清单 -->
			    			<table id = "dt"></table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type = "text/javascript">
			var url = "<%=basePath%>sys/download/file/download.do?docId=";//文档下载路径
			var zTree = null;
			var tid = 0;
			$(function(){
				//加载树结构
			   	var setting = {
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
			            	tid = treeNode.id;
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
			     		    var folderPath = path.join(" / ");
			     		    $("#folderPathView").text("Folder Path : "+folderPath);
			            	doSearch();
			            }
			        }
			    };
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
			   //定义表格
			   $('#dt').bootstrapTable({
				   url:"<%=basePath%>sys/doc/getAllDocuments.do?url="+url+"&catalog=0&docName=", //请求后台的URL（*）
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
				  	 	field: 'docName',
				   		title: '文件'
				   },{
				   		field: 'folderPath',
				   		title: '文件夹'
				   },{
				   		field: 'uploadedDt',
				   		title: '上传时间'
				   },{
					   	field: 'action',
					   	title: 'Action'
				   }]
		   		});
			});
			//移除附件
			function rmFile(e){
				$(e).parent().parent().remove();
			}
			function doSearch(){
				var docName = $("#docName").val();
				$('#dt').bootstrapTable("refresh", {"url":"<%=basePath%>sys/doc/getAllDocuments.do?url="+url+"&catalog="+tid+"&docName="+docName});
			}
		</script>
	</body>
</html>