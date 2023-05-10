<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Notice" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Notice notice = (Notice)request.getAttribute("notice");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改新闻公告信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">新闻公告信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="noticeEditForm" id="noticeEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="notice_noticeId_edit" class="col-md-3 text-right">公告id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="notice_noticeId_edit" name="notice.noticeId" class="form-control" placeholder="请输入公告id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="notice_title_edit" class="col-md-3 text-right">标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="notice_title_edit" name="notice.title" class="form-control" placeholder="请输入标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="notice_content_edit" class="col-md-3 text-right">公告内容:</label>
		  	 <div class="col-md-9">
			    <script name="notice.content" id="notice_content_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="notice_hitNum_edit" class="col-md-3 text-right">点击率:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="notice_hitNum_edit" name="notice.hitNum" class="form-control" placeholder="请输入点击率">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="notice_publishDate_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date notice_publishDate_edit col-md-12" data-link-field="notice_publishDate_edit">
                    <input class="form-control" id="notice_publishDate_edit" name="notice.publishDate" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxNoticeModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#noticeEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var notice_content_editor = UE.getEditor('notice_content_edit'); //公告内容编辑框
var basePath = "<%=basePath%>";
/*弹出修改新闻公告界面并初始化数据*/
function noticeEdit(noticeId) {
  notice_content_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(noticeId);
  });
}
 function ajaxModifyQuery(noticeId) {
	$.ajax({
		url :  basePath + "Notice/" + noticeId + "/update",
		type : "get",
		dataType: "json",
		success : function (notice, response, status) {
			if (notice) {
				$("#notice_noticeId_edit").val(notice.noticeId);
				$("#notice_title_edit").val(notice.title);
				notice_content_editor.setContent(notice.content, false);
				$("#notice_hitNum_edit").val(notice.hitNum);
				$("#notice_publishDate_edit").val(notice.publishDate);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交新闻公告信息表单给服务器端修改*/
function ajaxNoticeModify() {
	$.ajax({
		url :  basePath + "Notice/" + $("#notice_noticeId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#noticeEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#noticeQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*发布时间组件*/
    $('.notice_publishDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    noticeEdit("<%=request.getParameter("noticeId")%>");
 })
 </script> 
</body>
</html>

