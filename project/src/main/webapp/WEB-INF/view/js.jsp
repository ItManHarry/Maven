<%
	String jsUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<script type = "text/javascript" src = "<%=jsUrl%>js/jquery-1.11.3.min.js" charset="UTF-8"></script>
<script type = "text/javascript" src = "<%=jsUrl%>js/bootstrap.min.js" charset="UTF-8"></script>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
    <script src="<%=jsUrl%>js/html5.js" charset="UTF-8"></script>
    <script src="<%=jsUrl%>js/respond.min.js" charset="UTF-8"></script>
<![endif]--> 
<script type = "text/javascript" src = "<%=jsUrl%>js/bootstrapValidator.js" charset="UTF-8"></script>
<script type = "text/javascript" src = "<%=jsUrl%>js/language/zh-CN.js" charset="UTF-8"></script>
<script type = "text/javascript" src = "<%=jsUrl%>js/bootstrap-table.min.js" charset="UTF-8"></script>
<script type = "text/javascript" src = "<%=jsUrl%>js/locale/bootstrap-table-zh-CN.min.js" charset="UTF-8"></script>
<script type = "text/javascript" src = "<%=jsUrl%>js/jquery-confirm.min.js" charset="UTF-8"></script>
<script type = "text/javascript" src = "<%=jsUrl%>js/tree/tree.js"></script>
<script type = "text/javascript" src = "<%=jsUrl%>js/zTree/jquery.ztree.all-3.5.min.js" charset="UTF-8"></script>
<!--script type = "text/javascript" src = "<%=jsUrl%>js/zTree/jquery.ztree.core.js" charset="UTF-8"></script-->
<script type = "text/javascript" src = "<%=jsUrl%>js/sys/system.js" charset="UTF-8"></script>
<input type = "hidden" id = "jsCommPath" value = "<%=jsUrl%>"/>