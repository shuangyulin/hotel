<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookOrder.css" /> 

<div id="bookOrder_manage"></div>
<div id="bookOrder_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="bookOrder_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="bookOrder_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="bookOrder_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="bookOrder_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="bookOrder_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="bookOrderQueryForm" method="post">
			预订房间：<input class="textbox" type="text" id="roomObj_roomNo_query" name="roomObj.roomNo" style="width: auto"/>
			房间类型：<input class="textbox" type="text" id="roomTypeObj_roomTypeId_query" name="roomTypeObj.roomTypeId" style="width: auto"/>
			预订人：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			入住日期：<input type="text" id="liveDate" name="liveDate" class="easyui-datebox" editable="false" style="width:100px">
			订单状态：<input type="text" class="textbox" id="orderState" name="orderState" style="width:110px" />
			预订时间：<input type="text" id="orderTime" name="orderTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="bookOrder_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="bookOrderEditDiv">
	<form id="bookOrderEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订单id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_orderId_edit" name="bookOrder.orderId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">预订房间:</span>
			<span class="inputControl">
				<input class="textbox"  id="bookOrder_roomObj_roomNo_edit" name="bookOrder.roomObj.roomNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">房间类型:</span>
			<span class="inputControl">
				<input class="textbox"  id="bookOrder_roomTypeObj_roomTypeId_edit" name="bookOrder.roomTypeObj.roomTypeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">预订人:</span>
			<span class="inputControl">
				<input class="textbox"  id="bookOrder_userObj_user_name_edit" name="bookOrder.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">入住日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_liveDate_edit" name="bookOrder.liveDate" />

			</span>

		</div>
		<div>
			<span class="label">预订天数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_days_edit" name="bookOrder.days" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">总价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_totalMoney_edit" name="bookOrder.totalMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">订单备注:</span>
			<span class="inputControl">
				<textarea id="bookOrder_orderMemo_edit" name="bookOrder.orderMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">订单状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_orderState_edit" name="bookOrder.orderState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">预订时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_orderTime_edit" name="bookOrder.orderTime" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="BookOrder/js/bookOrder_manage.js"></script> 
