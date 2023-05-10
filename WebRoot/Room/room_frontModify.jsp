<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Room" %>
<%@ page import="com.chengxusheji.po.RoomType" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的roomTypeObj信息
    List<RoomType> roomTypeList = (List<RoomType>)request.getAttribute("roomTypeList");
    Room room = (Room)request.getAttribute("room");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改房间信息</TITLE>
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
  		<li class="active">房间信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="roomEditForm" id="roomEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="room_roomNo_edit" class="col-md-3 text-right">房间号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="room_roomNo_edit" name="room.roomNo" class="form-control" placeholder="请输入房间号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="room_roomTypeObj_roomTypeId_edit" class="col-md-3 text-right">房间类型:</label>
		  	 <div class="col-md-9">
			    <select id="room_roomTypeObj_roomTypeId_edit" name="room.roomTypeObj.roomTypeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="room_roomPhoto_edit" class="col-md-3 text-right">房间图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="room_roomPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="room_roomPhoto" name="room.roomPhoto"/>
			    <input id="roomPhotoFile" name="roomPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="room_roomPrice_edit" class="col-md-3 text-right">价格(每天):</label>
		  	 <div class="col-md-9">
			    <input type="text" id="room_roomPrice_edit" name="room.roomPrice" class="form-control" placeholder="请输入价格(每天)">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="room_floorNum_edit" class="col-md-3 text-right">楼层:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="room_floorNum_edit" name="room.floorNum" class="form-control" placeholder="请输入楼层">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="room_roomState_edit" class="col-md-3 text-right">占用状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="room_roomState_edit" name="room.roomState" class="form-control" placeholder="请输入占用状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="room_roomDesc_edit" class="col-md-3 text-right">房间描述:</label>
		  	 <div class="col-md-9">
			    <script name="room.roomDesc" id="room_roomDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxRoomModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#roomEditForm .form-group {margin-bottom:5px;}  </style>
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
var room_roomDesc_editor = UE.getEditor('room_roomDesc_edit'); //房间描述编辑框
var basePath = "<%=basePath%>";
/*弹出修改房间界面并初始化数据*/
function roomEdit(roomNo) {
  room_roomDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(roomNo);
  });
}
 function ajaxModifyQuery(roomNo) {
	$.ajax({
		url :  basePath + "Room/" + roomNo + "/update",
		type : "get",
		dataType: "json",
		success : function (room, response, status) {
			if (room) {
				$("#room_roomNo_edit").val(room.roomNo);
				$.ajax({
					url: basePath + "RoomType/listAll",
					type: "get",
					success: function(roomTypes,response,status) { 
						$("#room_roomTypeObj_roomTypeId_edit").empty();
						var html="";
		        		$(roomTypes).each(function(i,roomType){
		        			html += "<option value='" + roomType.roomTypeId + "'>" + roomType.roomTypeName + "</option>";
		        		});
		        		$("#room_roomTypeObj_roomTypeId_edit").html(html);
		        		$("#room_roomTypeObj_roomTypeId_edit").val(room.roomTypeObjPri);
					}
				});
				$("#room_roomPhoto").val(room.roomPhoto);
				$("#room_roomPhotoImg").attr("src", basePath +　room.roomPhoto);
				$("#room_roomPrice_edit").val(room.roomPrice);
				$("#room_floorNum_edit").val(room.floorNum);
				$("#room_roomState_edit").val(room.roomState);
				room_roomDesc_editor.setContent(room.roomDesc, false);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交房间信息表单给服务器端修改*/
function ajaxRoomModify() {
	$.ajax({
		url :  basePath + "Room/" + $("#room_roomNo_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#roomEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#roomQueryForm").submit();
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
    roomEdit("<%=request.getParameter("roomNo")%>");
 })
 </script> 
</body>
</html>

