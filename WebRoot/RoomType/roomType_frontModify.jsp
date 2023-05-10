<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.RoomType" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    RoomType roomType = (RoomType)request.getAttribute("roomType");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改房间类型信息</TITLE>
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
  		<li class="active">房间类型信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="roomTypeEditForm" id="roomTypeEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="roomType_roomTypeId_edit" class="col-md-3 text-right">类型id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="roomType_roomTypeId_edit" name="roomType.roomTypeId" class="form-control" placeholder="请输入类型id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="roomType_roomTypeName_edit" class="col-md-3 text-right">房间类型:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="roomType_roomTypeName_edit" name="roomType.roomTypeName" class="form-control" placeholder="请输入房间类型">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="roomType_price_edit" class="col-md-3 text-right">价格(每天):</label>
		  	 <div class="col-md-9">
			    <input type="text" id="roomType_price_edit" name="roomType.price" class="form-control" placeholder="请输入价格(每天)">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxRoomTypeModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#roomTypeEditForm .form-group {margin-bottom:5px;}  </style>
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
<script>
var basePath = "<%=basePath%>";
/*弹出修改房间类型界面并初始化数据*/
function roomTypeEdit(roomTypeId) {
	$.ajax({
		url :  basePath + "RoomType/" + roomTypeId + "/update",
		type : "get",
		dataType: "json",
		success : function (roomType, response, status) {
			if (roomType) {
				$("#roomType_roomTypeId_edit").val(roomType.roomTypeId);
				$("#roomType_roomTypeName_edit").val(roomType.roomTypeName);
				$("#roomType_price_edit").val(roomType.price);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交房间类型信息表单给服务器端修改*/
function ajaxRoomTypeModify() {
	$.ajax({
		url :  basePath + "RoomType/" + $("#roomType_roomTypeId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#roomTypeEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "RoomType/frontlist";
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
    roomTypeEdit("<%=request.getParameter("roomTypeId")%>");
 })
 </script> 
</body>
</html>

