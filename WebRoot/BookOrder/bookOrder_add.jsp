<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookOrder.css" />
<div id="bookOrderAddDiv">
	<form id="bookOrderAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">预订房间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_roomObj_roomNo" name="bookOrder.roomObj.roomNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">房间类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_roomTypeObj_roomTypeId" name="bookOrder.roomTypeObj.roomTypeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">预订人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_userObj_user_name" name="bookOrder.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">入住日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_liveDate" name="bookOrder.liveDate" />

			</span>

		</div>
		<div>
			<span class="label">预订天数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_days" name="bookOrder.days" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">总价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_totalMoney" name="bookOrder.totalMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">订单备注:</span>
			<span class="inputControl">
				<textarea id="bookOrder_orderMemo" name="bookOrder.orderMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">订单状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_orderState" name="bookOrder.orderState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">预订时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_orderTime" name="bookOrder.orderTime" />

			</span>

		</div>
		<div class="operation">
			<a id="bookOrderAddButton" class="easyui-linkbutton">添加</a>
			<a id="bookOrderClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/BookOrder/js/bookOrder_add.js"></script> 
