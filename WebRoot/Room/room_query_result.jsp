<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/room.css" /> 

<div id="room_manage"></div>
<div id="room_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="room_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="room_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="room_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="room_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="room_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="roomQueryForm" method="post">
			房间号：<input type="text" class="textbox" id="roomNo" name="roomNo" style="width:110px" />
			房间类型：<input class="textbox" type="text" id="roomTypeObj_roomTypeId_query" name="roomTypeObj.roomTypeId" style="width: auto"/>
			占用状态：<input type="text" class="textbox" id="roomState" name="roomState" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="room_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="roomEditDiv">
	<form id="roomEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">房间号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="room_roomNo_edit" name="room.roomNo" style="width:200px" />
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
				<script name="room.roomDesc" id="room_roomDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var room_roomDesc_editor = UE.getEditor('room_roomDesc_edit'); //房间描述编辑器
</script>
<script type="text/javascript" src="Room/js/room_manage.js"></script> 
