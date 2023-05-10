var bookOrder_manage_tool = null; 
$(function () { 
	initBookOrderManageTool(); //建立BookOrder管理对象
	bookOrder_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#bookOrder_manage").datagrid({
		url : 'BookOrder/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "orderId",
		sortOrder : "desc",
		toolbar : "#bookOrder_manage_tool",
		columns : [[
			{
				field : "orderId",
				title : "订单id",
				width : 70,
			},
			{
				field : "roomObj",
				title : "预订房间",
				width : 140,
			},
			{
				field : "roomTypeObj",
				title : "房间类型",
				width : 140,
			},
			{
				field : "userObj",
				title : "预订人",
				width : 140,
			},
			{
				field : "liveDate",
				title : "入住日期",
				width : 140,
			},
			{
				field : "days",
				title : "预订天数",
				width : 70,
			},
			{
				field : "totalMoney",
				title : "总价",
				width : 70,
			},
			{
				field : "orderMemo",
				title : "订单备注",
				width : 140,
			},
			{
				field : "orderState",
				title : "订单状态",
				width : 140,
			},
			{
				field : "orderTime",
				title : "预订时间",
				width : 140,
			},
		]],
	});

	$("#bookOrderEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#bookOrderEditForm").form("validate")) {
					//验证表单 
					if(!$("#bookOrderEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#bookOrderEditForm").form({
						    url:"BookOrder/" + $("#bookOrder_orderId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#bookOrderEditDiv").dialog("close");
			                        bookOrder_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#bookOrderEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#bookOrderEditDiv").dialog("close");
				$("#bookOrderEditForm").form("reset"); 
			},
		}],
	});
});

function initBookOrderManageTool() {
	bookOrder_manage_tool = {
		init: function() {
			$.ajax({
				url : "Room/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#roomObj_roomNo_query").combobox({ 
					    valueField:"roomNo",
					    textField:"roomNo",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{roomNo:"",roomNo:"不限制"});
					$("#roomObj_roomNo_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "RoomType/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#roomTypeObj_roomTypeId_query").combobox({ 
					    valueField:"roomTypeId",
					    textField:"roomTypeName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{roomTypeId:0,roomTypeName:"不限制"});
					$("#roomTypeObj_roomTypeId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#bookOrder_manage").datagrid("reload");
		},
		redo : function () {
			$("#bookOrder_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#bookOrder_manage").datagrid("options").queryParams;
			queryParams["roomObj.roomNo"] = $("#roomObj_roomNo_query").combobox("getValue");
			queryParams["roomTypeObj.roomTypeId"] = $("#roomTypeObj_roomTypeId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["liveDate"] = $("#liveDate").datebox("getValue"); 
			queryParams["orderState"] = $("#orderState").val();
			queryParams["orderTime"] = $("#orderTime").datebox("getValue"); 
			$("#bookOrder_manage").datagrid("options").queryParams=queryParams; 
			$("#bookOrder_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#bookOrderQueryForm").form({
			    url:"BookOrder/OutToExcel",
			});
			//提交表单
			$("#bookOrderQueryForm").submit();
		},
		remove : function () {
			var rows = $("#bookOrder_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var orderIds = [];
						for (var i = 0; i < rows.length; i ++) {
							orderIds.push(rows[i].orderId);
						}
						$.ajax({
							type : "POST",
							url : "BookOrder/deletes",
							data : {
								orderIds : orderIds.join(","),
							},
							beforeSend : function () {
								$("#bookOrder_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#bookOrder_manage").datagrid("loaded");
									$("#bookOrder_manage").datagrid("load");
									$("#bookOrder_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#bookOrder_manage").datagrid("loaded");
									$("#bookOrder_manage").datagrid("load");
									$("#bookOrder_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#bookOrder_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "BookOrder/" + rows[0].orderId +  "/update",
					type : "get",
					data : {
						//orderId : rows[0].orderId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (bookOrder, response, status) {
						$.messager.progress("close");
						if (bookOrder) { 
							$("#bookOrderEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
