<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/roomType.css" />
<div id="roomType_editDiv">
	<form id="roomTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类型id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomType_roomTypeId_edit" name="roomType.roomTypeId" value="<%=request.getParameter("roomTypeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">房间类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomType_roomTypeName_edit" name="roomType.roomTypeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">价格(每天):</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomType_price_edit" name="roomType.price" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="roomTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/RoomType/js/roomType_modify.js"></script> 
