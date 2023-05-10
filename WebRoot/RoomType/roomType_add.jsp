<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/roomType.css" />
<div id="roomTypeAddDiv">
	<form id="roomTypeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">房间类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomType_roomTypeName" name="roomType.roomTypeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">价格(每天):</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomType_price" name="roomType.price" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="roomTypeAddButton" class="easyui-linkbutton">添加</a>
			<a id="roomTypeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/RoomType/js/roomType_add.js"></script> 
