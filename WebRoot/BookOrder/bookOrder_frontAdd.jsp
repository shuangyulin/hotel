<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Room" %>
<%@ page import="com.chengxusheji.po.RoomType" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>房间预订添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>BookOrder/frontlist">房间预订列表</a></li>
			    	<li role="presentation" class="active"><a href="#bookOrderAdd" aria-controls="bookOrderAdd" role="tab" data-toggle="tab">添加房间预订</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="bookOrderList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="bookOrderAdd"> 
				      	<form class="form-horizontal" name="bookOrderAddForm" id="bookOrderAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="bookOrder_roomObj_roomNo" class="col-md-2 text-right">预订房间:</label>
						  	 <div class="col-md-8">
							    <select id="bookOrder_roomObj_roomNo" name="bookOrder.roomObj.roomNo" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="bookOrder_roomTypeObj_roomTypeId" class="col-md-2 text-right">房间类型:</label>
						  	 <div class="col-md-8">
							    <select id="bookOrder_roomTypeObj_roomTypeId" name="bookOrder.roomTypeObj.roomTypeId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="bookOrder_userObj_user_name" class="col-md-2 text-right">预订人:</label>
						  	 <div class="col-md-8">
							    <select id="bookOrder_userObj_user_name" name="bookOrder.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="bookOrder_liveDateDiv" class="col-md-2 text-right">入住日期:</label>
						  	 <div class="col-md-8">
				                <div id="bookOrder_liveDateDiv" class="input-group date bookOrder_liveDate col-md-12" data-link-field="bookOrder_liveDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="bookOrder_liveDate" name="bookOrder.liveDate" size="16" type="text" value="" placeholder="请选择入住日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="bookOrder_days" class="col-md-2 text-right">预订天数:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="bookOrder_days" name="bookOrder.days" class="form-control" placeholder="请输入预订天数">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="bookOrder_totalMoney" class="col-md-2 text-right">总价:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="bookOrder_totalMoney" name="bookOrder.totalMoney" class="form-control" placeholder="请输入总价">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="bookOrder_orderMemo" class="col-md-2 text-right">订单备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="bookOrder_orderMemo" name="bookOrder.orderMemo" rows="8" class="form-control" placeholder="请输入订单备注"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="bookOrder_orderState" class="col-md-2 text-right">订单状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="bookOrder_orderState" name="bookOrder.orderState" class="form-control" placeholder="请输入订单状态">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="bookOrder_orderTimeDiv" class="col-md-2 text-right">预订时间:</label>
						  	 <div class="col-md-8">
				                <div id="bookOrder_orderTimeDiv" class="input-group date bookOrder_orderTime col-md-12" data-link-field="bookOrder_orderTime">
				                    <input class="form-control" id="bookOrder_orderTime" name="bookOrder.orderTime" size="16" type="text" value="" placeholder="请选择预订时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxBookOrderAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#bookOrderAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加房间预订信息
	function ajaxBookOrderAdd() { 
		//提交之前先验证表单
		$("#bookOrderAddForm").data('bootstrapValidator').validate();
		if(!$("#bookOrderAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "BookOrder/add",
			dataType : "json" , 
			data: new FormData($("#bookOrderAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#bookOrderAddForm").find("input").val("");
					$("#bookOrderAddForm").find("textarea").val("");
				} else {
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
	//验证房间预订添加表单字段
	$('#bookOrderAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"bookOrder.liveDate": {
				validators: {
					notEmpty: {
						message: "入住日期不能为空",
					}
				}
			},
			"bookOrder.days": {
				validators: {
					notEmpty: {
						message: "预订天数不能为空",
					},
					integer: {
						message: "预订天数不正确"
					}
				}
			},
			"bookOrder.totalMoney": {
				validators: {
					notEmpty: {
						message: "总价不能为空",
					},
					numeric: {
						message: "总价不正确"
					}
				}
			},
			"bookOrder.orderState": {
				validators: {
					notEmpty: {
						message: "订单状态不能为空",
					}
				}
			},
			"bookOrder.orderTime": {
				validators: {
					notEmpty: {
						message: "预订时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化预订房间下拉框值 
	$.ajax({
		url: basePath + "Room/listAll",
		type: "get",
		success: function(rooms,response,status) { 
			$("#bookOrder_roomObj_roomNo").empty();
			var html="";
    		$(rooms).each(function(i,room){
    			html += "<option value='" + room.roomNo + "'>" + room.roomNo + "</option>";
    		});
    		$("#bookOrder_roomObj_roomNo").html(html);
    	}
	});
	//初始化房间类型下拉框值 
	$.ajax({
		url: basePath + "RoomType/listAll",
		type: "get",
		success: function(roomTypes,response,status) { 
			$("#bookOrder_roomTypeObj_roomTypeId").empty();
			var html="";
    		$(roomTypes).each(function(i,roomType){
    			html += "<option value='" + roomType.roomTypeId + "'>" + roomType.roomTypeName + "</option>";
    		});
    		$("#bookOrder_roomTypeObj_roomTypeId").html(html);
    	}
	});
	//初始化预订人下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#bookOrder_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#bookOrder_userObj_user_name").html(html);
    	}
	});
	//入住日期组件
	$('#bookOrder_liveDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#bookOrderAddForm').data('bootstrapValidator').updateStatus('bookOrder.liveDate', 'NOT_VALIDATED',null).validateField('bookOrder.liveDate');
	});
	//预订时间组件
	$('#bookOrder_orderTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#bookOrderAddForm').data('bootstrapValidator').updateStatus('bookOrder.orderTime', 'NOT_VALIDATED',null).validateField('bookOrder.orderTime');
	});
})
</script>
</body>
</html>
