$(function () {
	$.ajax({
		url : "BookOrder/" + $("#bookOrder_orderId_edit").val() + "/update",
		type : "get",
		data : {
			//orderId : $("#bookOrder_orderId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (bookOrder, response, status) {
			$.messager.progress("close");
			if (bookOrder) { 
				$("#bookOrder_orderId_edit").val(bookOrder.orderId);
				$("#bookOrder_orderId_edit").validatebox({
					required : true,
					missingMessage : "请输入订单id",
					editable: false
				});
				$("#bookOrder_roomObj_roomNo_edit").combobox({
					url:"Room/listAll",
					valueField:"roomNo",
					textField:"roomNo",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#bookOrder_roomObj_roomNo_edit").combobox("select", bookOrder.roomObjPri);
						//var data = $("#bookOrder_roomObj_roomNo_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#bookOrder_roomObj_roomNo_edit").combobox("select", data[0].roomNo);
						//}
					}
				});
				$("#bookOrder_roomTypeObj_roomTypeId_edit").combobox({
					url:"RoomType/listAll",
					valueField:"roomTypeId",
					textField:"roomTypeName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#bookOrder_roomTypeObj_roomTypeId_edit").combobox("select", bookOrder.roomTypeObjPri);
						//var data = $("#bookOrder_roomTypeObj_roomTypeId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#bookOrder_roomTypeObj_roomTypeId_edit").combobox("select", data[0].roomTypeId);
						//}
					}
				});
				$("#bookOrder_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#bookOrder_userObj_user_name_edit").combobox("select", bookOrder.userObjPri);
						//var data = $("#bookOrder_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#bookOrder_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#bookOrder_liveDate_edit").datebox({
					value: bookOrder.liveDate,
					required: true,
					showSeconds: true,
				});
				$("#bookOrder_days_edit").val(bookOrder.days);
				$("#bookOrder_days_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入预订天数",
					invalidMessage : "预订天数输入不对",
				});
				$("#bookOrder_totalMoney_edit").val(bookOrder.totalMoney);
				$("#bookOrder_totalMoney_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入总价",
					invalidMessage : "总价输入不对",
				});
				$("#bookOrder_orderMemo_edit").val(bookOrder.orderMemo);
				$("#bookOrder_orderState_edit").val(bookOrder.orderState);
				$("#bookOrder_orderState_edit").validatebox({
					required : true,
					missingMessage : "请输入订单状态",
				});
				$("#bookOrder_orderTime_edit").datetimebox({
					value: bookOrder.orderTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#bookOrderModifyButton").click(function(){ 
		if ($("#bookOrderEditForm").form("validate")) {
			$("#bookOrderEditForm").form({
			    url:"BookOrder/" +  $("#bookOrder_orderId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#bookOrderEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#bookOrderEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
