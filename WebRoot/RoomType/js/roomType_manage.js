var roomType_manage_tool = null; 
$(function () { 
	initRoomTypeManageTool(); //建立RoomType管理对象
	roomType_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#roomType_manage").datagrid({
		url : 'RoomType/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "roomTypeId",
		sortOrder : "desc",
		toolbar : "#roomType_manage_tool",
		columns : [[
			{
				field : "roomTypeId",
				title : "类型id",
				width : 70,
			},
			{
				field : "roomTypeName",
				title : "房间类型",
				width : 140,
			},
			{
				field : "price",
				title : "价格(每天)",
				width : 70,
			},
		]],
	});

	$("#roomTypeEditDiv").dialog({
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
				if ($("#roomTypeEditForm").form("validate")) {
					//验证表单 
					if(!$("#roomTypeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#roomTypeEditForm").form({
						    url:"RoomType/" + $("#roomType_roomTypeId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#roomTypeEditForm").form("validate"))  {
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
			                        $("#roomTypeEditDiv").dialog("close");
			                        roomType_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#roomTypeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#roomTypeEditDiv").dialog("close");
				$("#roomTypeEditForm").form("reset"); 
			},
		}],
	});
});

function initRoomTypeManageTool() {
	roomType_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#roomType_manage").datagrid("reload");
		},
		redo : function () {
			$("#roomType_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#roomType_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#roomTypeQueryForm").form({
			    url:"RoomType/OutToExcel",
			});
			//提交表单
			$("#roomTypeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#roomType_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var roomTypeIds = [];
						for (var i = 0; i < rows.length; i ++) {
							roomTypeIds.push(rows[i].roomTypeId);
						}
						$.ajax({
							type : "POST",
							url : "RoomType/deletes",
							data : {
								roomTypeIds : roomTypeIds.join(","),
							},
							beforeSend : function () {
								$("#roomType_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#roomType_manage").datagrid("loaded");
									$("#roomType_manage").datagrid("load");
									$("#roomType_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#roomType_manage").datagrid("loaded");
									$("#roomType_manage").datagrid("load");
									$("#roomType_manage").datagrid("unselectAll");
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
			var rows = $("#roomType_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "RoomType/" + rows[0].roomTypeId +  "/update",
					type : "get",
					data : {
						//roomTypeId : rows[0].roomTypeId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (roomType, response, status) {
						$.messager.progress("close");
						if (roomType) { 
							$("#roomTypeEditDiv").dialog("open");
							$("#roomType_roomTypeId_edit").val(roomType.roomTypeId);
							$("#roomType_roomTypeId_edit").validatebox({
								required : true,
								missingMessage : "请输入类型id",
								editable: false
							});
							$("#roomType_roomTypeName_edit").val(roomType.roomTypeName);
							$("#roomType_roomTypeName_edit").validatebox({
								required : true,
								missingMessage : "请输入房间类型",
							});
							$("#roomType_price_edit").val(roomType.price);
							$("#roomType_price_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入价格(每天)",
								invalidMessage : "价格(每天)输入不对",
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
