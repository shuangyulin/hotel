<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/room.css" />
<div id="room_editDiv">
	<form id="roomEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">房间号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_roomNo_edit" name="room.roomNo" value="<%=request.getParameter("roomNo") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">房间类型:</span>
			<span class="inputControl">
				<input class="textbox"  id="room_roomTypeObj_roomTypeId_edit" name="room.roomTypeObj.roomTypeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">房间图片:</span>
			<span class="inputControl">
				<img id="room_roomPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="room_roomPhoto" name="room.roomPhoto"/>
				<input id="roomPhotoFile" name="roomPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">价格(每天):</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_roomPrice_edit" name="room.roomPrice" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">楼层:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_floorNum_edit" name="room.floorNum" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">占用状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_roomState_edit" name="room.roomState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">房间描述:</span>
			<span class="inputControl">
				<script id="room_roomDesc_edit" name="room.roomDesc" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div class="operation">
			<a id="roomModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Room/js/room_modify.js"></script> 
