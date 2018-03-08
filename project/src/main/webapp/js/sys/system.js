//设置日期控件的默认值为今天
function sys_setDate(id, days, date){
	if(date != ""){
		$("#"+id).val(date);
	}else{
		var curr_time = new Date();    
		curr_time.setDate(curr_time.getDate() + days);
		var today = curr_time.getFullYear() + "-" + (curr_time.getMonth()+1) + "-" + curr_time.getDate();
		$("#"+id).val(today);
	}
}
//弹出框 
//title:标题
//content:内容
//bgMiss:是否允许单机弹出框外区域关闭弹出框， ture：允许 false：不允许
//fn:回调函数
function sys_alert(title, content, bgMiss, fn){
	if(isIE() && ieVersion() < 10){
	   alert(content);
	   $.extend({'alertBackFn':fn}); 
	   $.alertBackFn();
    }else{
	   $.alert({
	        title: title,
	        content: content,
	        confirmButton: 'OK',
	        confirmButtonClass: 'btn-primary',
	        icon: 'fa fa-info',
	        animation: 'zoom',
	        backgroundDismiss: bgMiss,
	        confirm:fn
	    });
   }
}
//确认框
//title:标题
//content:内容
//fn:回调函数
function sys_confirm(title, content, fn){
	$.confirm({
        title: title,
        content: content,
        confirmButton: 'Yes',
        cancelButton:'No',
        confirmButtonClass: 'btn-warning',
        cancelButtonClass: 'btn-primary',
        icon: 'fa fa-question-circle',
        animation: 'scale',
        backgroundDismiss:false,
        confirm:fn
    });
}
//初始化下拉列表(仅限于系统维护的CODE)
//sid:下拉列表的id
//code:系统维护的code
//filter:过滤条件
//dv:Default Value默认选中
function fillSelect(sid, code, filter, dv){
	//清空下拉列表
	$("#"+sid).empty();
	//获取下拉列表值
	$.ajax({
		type:"post",
		url:$("#jsCommPath").val()+"/sys/code/getOps.do",
		data:{code:code, filter:filter},
		success:function(r){
			for(var i = 0; i < r.length; i++){
				if(r[i].cdvl == dv)
					$("#"+sid).append("<option value = '"+r[i].cdvl+"' selected>"+r[i].cdvw+"</option>");
				else
					$("#"+sid).append("<option value = '"+r[i].cdvl+"'>"+r[i].cdvw+"</option>");
			}
		},
		error:function(){
			 sys_alert("警告", "获取下拉列表异常,请联系管理员!", false,  function(){});
		}
	});
}
//校验手机号码
//m:手机号
function checkMobile(m){
	var reg = /^0?1[3|4|5|7|8][0-9]\d{8}$/;
	return reg.test(m);
}
//校验证件号码
//idNo:证件号
function checkIdNo(idNo){
	var reg = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
	return reg.test(idNo);
}
//解除验证
function destroyValidator(formId){
	$("#"+formId).data('bootstrapValidator').destroy();
    $("#"+formId).data('bootstrapValidator', null);
}
//判断是否是IE浏览器
function isIE(){
	if(!!window.ActiveXObject || "ActiveXObject" in window){
		return true;
	}else{
		return false;
	}
}
//获取IE浏览器版本
function ieVersion(){
  var rv = -1; 
  if (navigator.appName == 'Microsoft Internet Explorer'){ 
    var ua = navigator.userAgent; 
    var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})"); 
    if (re.exec(ua) != null) 
    	rv = parseFloat( RegExp.$1 );  
  	}else if (navigator.appName == 'Netscape'){
  		var ua = navigator.userAgent; 
  		var re  = new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})");
  		if (re.exec(ua) != null) 
  			rv = parseFloat( RegExp.$1 );
  	} 
  return rv; 
} 
//显示窗体
function showWindow(id){
	$("#"+id).modal({backdrop:false});//设置点击窗体外的区域不可关闭窗体
	$("#"+id).modal("show");
}
//关闭窗体
function hideWindow(id){
	$("#"+id).modal("hide");
}