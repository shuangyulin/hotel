var notice_manage_tool = null; 
$(function () { 
	initNoticeManageTool(); //建立Notice管理对象
	notice_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#notice_manage").datagrid({
		url : 'Notice/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "noticeId",
		sortOrder : "desc",
		toolbar : "#notice_manage_tool",
		columns : [[
			{
				field : "noticeId",
				title : "公告id",
				width : 70,
			},
			{
				field : "title",
				title : "标题",
				width : 140,
			},
			{
				field : "hitNum",
				title : "点击率",
				width : 70,
			},
			{
				field : "publishDate",
				title : "发布时间",
				width : 140,
			},
		]],
	});

	$("#noticeEditDiv").dialog({
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
				if ($("#noticeEditForm").form("validate")) {
					//验证表单 
					if(!$("#noticeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#noticeEditForm").form({
						    url:"Notice/" + $("#notice_noticeId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#noticeEditForm").form("validate"))  {
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
			                        $("#noticeEditDiv").dialog("close");
			                        notice_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#noticeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#noticeEditDiv").dialog("close");
				$("#noticeEditForm").form("reset"); 
			},
		}],
	});
});

function initNoticeManageTool() {
	notice_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#notice_manage").datagrid("reload");
		},
		redo : function () {
			$("#notice_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#notice_manage").datagrid("options").queryParams;
			queryParams["title"] = $("#title").val();
			queryParams["publishDate"] = $("#publishDate").datebox("getValue"); 
			$("#notice_manage").datagrid("options").queryParams=queryParams; 
			$("#notice_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#noticeQueryForm").form({
			    url:"Notice/OutToExcel",
			});
			//提交表单
			$("#noticeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#notice_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var noticeIds = [];
						for (var i = 0; i < rows.length; i ++) {
							noticeIds.push(rows[i].noticeId);
						}
						$.ajax({
							type : "POST",
							url : "Notice/deletes",
							data : {
								noticeIds : noticeIds.join(","),
							},
							beforeSend : function () {
								$("#notice_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#notice_manage").datagrid("loaded");
									$("#notice_manage").datagrid("load");
									$("#notice_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#notice_manage").datagrid("loaded");
									$("#notice_manage").datagrid("load");
									$("#notice_manage").datagrid("unselectAll");
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
			var rows = $("#notice_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Notice/" + rows[0].noticeId +  "/update",
					type : "get",
					data : {
						//noticeId : rows[0].noticeId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (notice, response, status) {
						$.messager.progress("close");
						if (notice) { 
							$("#noticeEditDiv").dialog("open");
							$("#notice_noticeId_edit").val(notice.noticeId);
							$("#notice_noticeId_edit").validatebox({
								required : true,
								missingMessage : "请输入公告id",
								editable: false
							});
							$("#notice_title_edit").val(notice.title);
							$("#notice_title_edit").validatebox({
								required : true,
								missingMessage : "请输入标题",
							});
							notice_content_editor.setContent(notice.content, false);
							$("#notice_hitNum_edit").val(notice.hitNum);
							$("#notice_hitNum_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入点击率",
								invalidMessage : "点击率输入不对",
							});
							$("#notice_publishDate_edit").datetimebox({
								value: notice.publishDate,
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
