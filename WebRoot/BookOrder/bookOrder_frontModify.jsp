<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BookOrder" %>
<%@ page import="com.chengxusheji.po.Room" %>
<%@ page import="com.chengxusheji.po.RoomType" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的roomObj信息
    List<Room> roomList = (List<Room>)request.getAttribute("roomList");
    //获取所有的roomTypeObj信息
    List<RoomType> roomTypeList = (List<RoomType>)request.getAttribute("roomTypeList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    BookOrder bookOrder = (BookOrder)request.getAttribute("bookOrder");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改房间预订信息</TITLE>
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
  		<li class="active">房间预订信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="bookOrderEditForm" id="bookOrderEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="bookOrder_orderId_edit" class="col-md-3 text-right">订单id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="bookOrder_orderId_edit" name="bookOrder.orderId" class="form-control" placeholder="请输入订单id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="bookOrder_roomObj_roomNo_edit" class="col-md-3 text-right">预订房间:</label>
		  	 <div class="col-md-9">
			    <select id="bookOrder_roomObj_roomNo_edit" name="bookOrder.roomObj.roomNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookOrder_roomTypeObj_roomTypeId_edit" class="col-md-3 text-right">房间类型:</label>
		  	 <div class="col-md-9">
			    <select id="bookOrder_roomTypeObj_roomTypeId_edit" name="bookOrder.roomTypeObj.roomTypeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookOrder_userObj_user_name_edit" class="col-md-3 text-right">预订人:</label>
		  	 <div class="col-md-9">
			    <select id="bookOrder_userObj_user_name_edit" name="bookOrder.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookOrder_liveDate_edit" class="col-md-3 text-right">入住日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date bookOrder_liveDate_edit col-md-12" data-link-field="bookOrder_liveDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="bookOrder_liveDate_edit" name="bookOrder.liveDate" size="16" type="text" value="" placeholder="请选择入住日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookOrder_days_edit" class="col-md-3 text-right">预订天数:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookOrder_days_edit" name="bookOrder.days" class="form-control" placeholder="请输入预订天数">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookOrder_totalMoney_edit" class="col-md-3 text-right">总价:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookOrder_totalMoney_edit" name="bookOrder.totalMoney" class="form-control" placeholder="请输入总价">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookOrder_orderMemo_edit" class="col-md-3 text-right">订单备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="bookOrder_orderMemo_edit" name="bookOrder.orderMemo" rows="8" class="form-control" placeholder="请输入订单备注"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookOrder_orderState_edit" class="col-md-3 text-right">订单状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookOrder_orderState_edit" name="bookOrder.orderState" class="form-control" placeholder="请输入订单状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookOrder_orderTime_edit" class="col-md-3 text-right">预订时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date bookOrder_orderTime_edit col-md-12" data-link-field="bookOrder_orderTime_edit">
                    <input class="form-control" id="bookOrder_orderTime_edit" name="bookOrder.orderTime" size="16" type="text" value="" placeholder="请选择预订时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxBookOrderModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#bookOrderEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改房间预订界面并初始化数据*/
function bookOrderEdit(orderId) {
	$.ajax({
		url :  basePath + "BookOrder/" + orderId + "/update",
		type : "get",
		dataType: "json",
		success : function (bookOrder, response, status) {
			if (bookOrder) {
				$("#bookOrder_orderId_edit").val(bookOrder.orderId);
				$.ajax({
					url: basePath + "Room/listAll",
					type: "get",
					success: function(rooms,response,status) { 
						$("#bookOrder_roomObj_roomNo_edit").empty();
						var html="";
		        		$(rooms).each(function(i,room){
		        			html += "<option value='" + room.roomNo + "'>" + room.roomNo + "</option>";
		        		});
		        		$("#bookOrder_roomObj_roomNo_edit").html(html);
		        		$("#bookOrder_roomObj_roomNo_edit").val(bookOrder.roomObjPri);
					}
				});
				$.ajax({
					url: basePath + "RoomType/listAll",
					type: "get",
					success: function(roomTypes,response,status) { 
						$("#bookOrder_roomTypeObj_roomTypeId_edit").empty();
						var html="";
		        		$(roomTypes).each(function(i,roomType){
		        			html += "<option value='" + roomType.roomTypeId + "'>" + roomType.roomTypeName + "</option>";
		        		});
		        		$("#bookOrder_roomTypeObj_roomTypeId_edit").html(html);
		        		$("#bookOrder_roomTypeObj_roomTypeId_edit").val(bookOrder.roomTypeObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#bookOrder_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#bookOrder_userObj_user_name_edit").html(html);
		        		$("#bookOrder_userObj_user_name_edit").val(bookOrder.userObjPri);
					}
				});
				$("#bookOrder_liveDate_edit").val(bookOrder.liveDate);
				$("#bookOrder_days_edit").val(bookOrder.days);
				$("#bookOrder_totalMoney_edit").val(bookOrder.totalMoney);
				$("#bookOrder_orderMemo_edit").val(bookOrder.orderMemo);
				$("#bookOrder_orderState_edit").val(bookOrder.orderState);
				$("#bookOrder_orderTime_edit").val(bookOrder.orderTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交房间预订信息表单给服务器端修改*/
function ajaxBookOrderModify() {
	$.ajax({
		url :  basePath + "BookOrder/" + $("#bookOrder_orderId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#bookOrderEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#bookOrderQueryForm").submit();
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
    /*入住日期组件*/
    $('.bookOrder_liveDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    /*预订时间组件*/
    $('.bookOrder_orderTime_edit').datetimepicker({
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
    bookOrderEdit("<%=request.getParameter("orderId")%>");
 })
 </script> 
</body>
</html>

