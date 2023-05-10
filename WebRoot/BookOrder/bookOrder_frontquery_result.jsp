<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BookOrder" %>
<%@ page import="com.chengxusheji.po.Room" %>
<%@ page import="com.chengxusheji.po.RoomType" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<BookOrder> bookOrderList = (List<BookOrder>)request.getAttribute("bookOrderList");
    //获取所有的roomObj信息
    List<Room> roomList = (List<Room>)request.getAttribute("roomList");
    //获取所有的roomTypeObj信息
    List<RoomType> roomTypeList = (List<RoomType>)request.getAttribute("roomTypeList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Room roomObj = (Room)request.getAttribute("roomObj");
    RoomType roomTypeObj = (RoomType)request.getAttribute("roomTypeObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String liveDate = (String)request.getAttribute("liveDate"); //入住日期查询关键字
    String orderState = (String)request.getAttribute("orderState"); //订单状态查询关键字
    String orderTime = (String)request.getAttribute("orderTime"); //预订时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>房间预订查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#bookOrderListPanel" aria-controls="bookOrderListPanel" role="tab" data-toggle="tab">房间预订列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>BookOrder/bookOrder_frontAdd.jsp" style="display:none;">添加房间预订</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="bookOrderListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>订单id</td><td>预订房间</td><td>房间类型</td><td>预订人</td><td>入住日期</td><td>预订天数</td><td>总价</td><td>订单备注</td><td>订单状态</td><td>预订时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<bookOrderList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		BookOrder bookOrder = bookOrderList.get(i); //获取到房间预订对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=bookOrder.getOrderId() %></td>
 											<td><%=bookOrder.getRoomObj().getRoomNo() %></td>
 											<td><%=bookOrder.getRoomTypeObj().getRoomTypeName() %></td>
 											<td><%=bookOrder.getUserObj().getName() %></td>
 											<td><%=bookOrder.getLiveDate() %></td>
 											<td><%=bookOrder.getDays() %></td>
 											<td><%=bookOrder.getTotalMoney() %></td>
 											<td><%=bookOrder.getOrderMemo() %></td>
 											<td><%=bookOrder.getOrderState() %></td>
 											<td><%=bookOrder.getOrderTime() %></td>
 											<td>
 												<a href="<%=basePath  %>BookOrder/<%=bookOrder.getOrderId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="bookOrderEdit('<%=bookOrder.getOrderId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="bookOrderDelete('<%=bookOrder.getOrderId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>房间预订查询</h1>
		</div>
		<form name="bookOrderQueryForm" id="bookOrderQueryForm" action="<%=basePath %>BookOrder/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="roomObj_roomNo">预订房间：</label>
                <select id="roomObj_roomNo" name="roomObj.roomNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Room roomTemp:roomList) {
	 					String selected = "";
 					if(roomObj!=null && roomObj.getRoomNo()!=null && roomObj.getRoomNo().equals(roomTemp.getRoomNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=roomTemp.getRoomNo() %>" <%=selected %>><%=roomTemp.getRoomNo() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="roomTypeObj_roomTypeId">房间类型：</label>
                <select id="roomTypeObj_roomTypeId" name="roomTypeObj.roomTypeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(RoomType roomTypeTemp:roomTypeList) {
	 					String selected = "";
 					if(roomTypeObj!=null && roomTypeObj.getRoomTypeId()!=null && roomTypeObj.getRoomTypeId().intValue()==roomTypeTemp.getRoomTypeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=roomTypeTemp.getRoomTypeId() %>" <%=selected %>><%=roomTypeTemp.getRoomTypeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">预订人：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="liveDate">入住日期:</label>
				<input type="text" id="liveDate" name="liveDate" class="form-control"  placeholder="请选择入住日期" value="<%=liveDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="orderState">订单状态:</label>
				<input type="text" id="orderState" name="orderState" value="<%=orderState %>" class="form-control" placeholder="请输入订单状态">
			</div>






			<div class="form-group">
				<label for="orderTime">预订时间:</label>
				<input type="text" id="orderTime" name="orderTime" class="form-control"  placeholder="请选择预订时间" value="<%=orderTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="bookOrderEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;房间预订信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
                <div class="input-group date bookOrder_liveDate_edit col-md-12" data-link-field="bookOrder_liveDate_edit"  data-link-format="yyyy-mm-dd">
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
		</form> 
	    <style>#bookOrderEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxBookOrderModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.bookOrderQueryForm.currentPage.value = currentPage;
    document.bookOrderQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.bookOrderQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.bookOrderQueryForm.currentPage.value = pageValue;
    documentbookOrderQueryForm.submit();
}

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
				$('#bookOrderEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除房间预订信息*/
function bookOrderDelete(orderId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "BookOrder/deletes",
			data : {
				orderIds : orderId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#bookOrderQueryForm").submit();
					//location.href= basePath + "BookOrder/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

