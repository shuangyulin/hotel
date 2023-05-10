<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Room" %>
<%@ page import="com.chengxusheji.po.RoomType" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Room> roomList = (List<Room>)request.getAttribute("roomList");
    //获取所有的roomTypeObj信息
    List<RoomType> roomTypeList = (List<RoomType>)request.getAttribute("roomTypeList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String roomNo = (String)request.getAttribute("roomNo"); //房间号查询关键字
    RoomType roomTypeObj = (RoomType)request.getAttribute("roomTypeObj");
    String roomState = (String)request.getAttribute("roomState"); //占用状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>房间查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Room/frontlist">房间信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Room/room_frontAdd.jsp" style="display:none;">添加房间</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<roomList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Room room = roomList.get(i); //获取到房间对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Room/<%=room.getRoomNo() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=room.getRoomPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		房间号:<%=room.getRoomNo() %>
			     	</div>
			     	<div class="field">
	            		房间类型:<%=room.getRoomTypeObj().getRoomTypeName() %>
			     	</div>
			     	<div class="field">
	            		价格(每天):<%=room.getRoomPrice() %>
			     	</div>
			     	<div class="field">
	            		楼层:<%=room.getFloorNum() %>
			     	</div>
			     	<div class="field">
	            		占用状态:<%=room.getRoomState() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Room/<%=room.getRoomNo() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="roomEdit('<%=room.getRoomNo() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="roomDelete('<%=room.getRoomNo() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>房间查询</h1>
		</div>
		<form name="roomQueryForm" id="roomQueryForm" action="<%=basePath %>Room/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="roomNo">房间号:</label>
				<input type="text" id="roomNo" name="roomNo" value="<%=roomNo %>" class="form-control" placeholder="请输入房间号">
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
				<label for="roomState">占用状态:</label>
				<input type="text" id="roomState" name="roomState" value="<%=roomState %>" class="form-control" placeholder="请输入占用状态">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="roomEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;房间信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
			 	<textarea name="room.roomDesc" id="room_roomDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#roomEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxRoomModify();">提交</button>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var room_roomDesc_edit = UE.getEditor('room_roomDesc_edit'); //房间描述编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.roomQueryForm.currentPage.value = currentPage;
    document.roomQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.roomQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.roomQueryForm.currentPage.value = pageValue;
    documentroomQueryForm.submit();
}

/*弹出修改房间界面并初始化数据*/
function roomEdit(roomNo) {
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
				room_roomDesc_edit.setContent(room.roomDesc, false);
				$('#roomEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除房间信息*/
function roomDelete(roomNo) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Room/deletes",
			data : {
				roomNos : roomNo,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#roomQueryForm").submit();
					//location.href= basePath + "Room/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

