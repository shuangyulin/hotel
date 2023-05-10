<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/room.css" />
<div id="roomAddDiv">
	<form id="roomAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">房间号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_roomNo" name="room.roomNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">房间类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_roomTypeObj_roomTypeId" name="room.roomTypeObj.roomTypeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">房间图片:</span>
			<span class="inputControl">
				<input id="roomPhotoFile" name="roomPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">价格(每天):</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_roomPrice" name="room.roomPrice" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">楼层:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_floorNum" name="room.floorNum" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">占用状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_roomState" name="room.roomState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">房间描述:</span>
			<span class="inputControl">
				<script name="room.roomDesc" id="room_roomDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div class="operation">
			<a id="roomAddButton" class="easyui-linkbutton">添加</a>
			<a id="roomClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Room/js/room_add.js"></script> 
