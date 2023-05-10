<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/roomType.css" /> 

<div id="roomType_manage"></div>
<div id="roomType_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="roomType_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="roomType_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="roomType_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="roomType_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="roomType_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="roomTypeQueryForm" method="post">
		</form>	
	</div>
</div>

<div id="roomTypeEditDiv">
	<form id="roomTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类型id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="roomType_roomTypeId_edit" name="roomType.roomTypeId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="RoomType/js/roomType_manage.js"></script> 
