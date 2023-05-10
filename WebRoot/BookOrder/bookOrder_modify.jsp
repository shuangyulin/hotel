<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookOrder.css" />
<div id="bookOrder_editDiv">
	<form id="bookOrderEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订单id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_orderId_edit" name="bookOrder.orderId" value="<%=request.getParameter("orderId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="bookOrderModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/BookOrder/js/bookOrder_modify.js"></script> 
