var room_manage_tool = null; 
$(function () { 
	initRoomManageTool(); //建立Room管理对象
	room_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#room_manage").datagrid({
		url : 'Room/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "roomNo",
		sortOrder : "desc",
		toolbar : "#room_manage_tool",
		columns : [[
			{
				field : "roomNo",
				title : "房间号",
				width : 140,
			},
			{
				field : "roomTypeObj",
				title : "房间类型",
				width : 140,
			},
			{
				field : "roomPhoto",
				title : "房间图片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "roomPrice",
				title : "价格(每天)",
				width : 70,
			},
			{
				field : "floorNum",
				title : "楼层",
				width : 140,
			},
			{
				field : "roomState",
				title : "占用状态",
				width : 140,
			},
		]],
	});

	$("#roomEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#roomEditForm").form("validate")) {
					//验证表单 
					if(!$("#roomEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#roomEditForm").form({
						    url:"Room/" + $("#room_roomNo_edit").val() + "/update",
						    onSubmit: function(){
								if($("#roomEditForm").form("validate"))  {
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
			                        $("#roomEditDiv").dialog("close");
			                        room_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#roomEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#roomEditDiv").dialog("close");
				$("#roomEditForm").form("reset"); 
			},
		}],
	});
});

function initRoomManageTool() {
	room_manage_tool = {
		init: function() {
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
		},
		reload : function () {
			$("#room_manage").datagrid("reload");
		},
		redo : function () {
			$("#room_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#room_manage").datagrid("options").queryParams;
			queryParams["roomNo"] = $("#roomNo").val();
			queryParams["roomTypeObj.roomTypeId"] = $("#roomTypeObj_roomTypeId_query").combobox("getValue");
			queryParams["roomState"] = $("#roomState").val();
			$("#room_manage").datagrid("options").queryParams=queryParams; 
			$("#room_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#roomQueryForm").form({
			    url:"Room/OutToExcel",
			});
			//提交表单
			$("#roomQueryForm").submit();
		},
		remove : function () {
			var rows = $("#room_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var roomNos = [];
						for (var i = 0; i < rows.length; i ++) {
							roomNos.push(rows[i].roomNo);
						}
						$.ajax({
							type : "POST",
							url : "Room/deletes",
							data : {
								roomNos : roomNos.join(","),
							},
							beforeSend : function () {
								$("#room_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#room_manage").datagrid("loaded");
									$("#room_manage").datagrid("load");
									$("#room_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#room_manage").datagrid("loaded");
									$("#room_manage").datagrid("load");
									$("#room_manage").datagrid("unselectAll");
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
			var rows = $("#room_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Room/" + rows[0].roomNo +  "/update",
					type : "get",
					data : {
						//roomNo : rows[0].roomNo,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (room, response, status) {
						$.messager.progress("close");
						if (room) { 
							$("#roomEditDiv").dialog("open");
							$("#room_roomNo_edit").val(room.roomNo);
							$("#room_roomNo_edit").validatebox({
								required : true,
								missingMessage : "请输入房间号",
								editable: false
							});
							$("#room_roomTypeObj_roomTypeId_edit").combobox({
								url:"RoomType/listAll",
							    valueField:"roomTypeId",
							    textField:"roomTypeName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#room_roomTypeObj_roomTypeId_edit").combobox("select", room.roomTypeObjPri);
									//var data = $("#room_roomTypeObj_roomTypeId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#room_roomTypeObj_roomTypeId_edit").combobox("select", data[0].roomTypeId);
						            //}
								}
							});
							$("#room_roomPhoto").val(room.roomPhoto);
							$("#room_roomPhotoImg").attr("src", room.roomPhoto);
							$("#room_roomPrice_edit").val(room.roomPrice);
							$("#room_roomPrice_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入价格(每天)",
								invalidMessage : "价格(每天)输入不对",
							});
							$("#room_floorNum_edit").val(room.floorNum);
							$("#room_floorNum_edit").validatebox({
								required : true,
								missingMessage : "请输入楼层",
							});
							$("#room_roomState_edit").val(room.roomState);
							$("#room_roomState_edit").validatebox({
								required : true,
								missingMessage : "请输入占用状态",
							});
							room_roomDesc_editor.setContent(room.roomDesc, false);
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
