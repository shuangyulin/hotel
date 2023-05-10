$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('room_roomDesc');
	var room_roomDesc_editor = UE.getEditor('room_roomDesc'); //房间描述编辑框
	$("#room_roomNo").validatebox({
		required : true, 
		missingMessage : '请输入房间号',
	});

	$("#room_roomTypeObj_roomTypeId").combobox({
	    url:'RoomType/listAll',
	    valueField: "roomTypeId",
	    textField: "roomTypeName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#room_roomTypeObj_roomTypeId").combobox("getData"); 
            if (data.length > 0) {
                $("#room_roomTypeObj_roomTypeId").combobox("select", data[0].roomTypeId);
            }
        }
	});
	$("#room_roomPrice").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入价格(每天)',
		invalidMessage : '价格(每天)输入不对',
	});

	$("#room_floorNum").validatebox({
		required : true, 
		missingMessage : '请输入楼层',
	});

	$("#room_roomState").validatebox({
		required : true, 
		missingMessage : '请输入占用状态',
	});

	//单击添加按钮
	$("#roomAddButton").click(function () {
		if(room_roomDesc_editor.getContent() == "") {
			alert("请输入房间描述");
			return;
		}
		//验证表单 
		if(!$("#roomAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#roomAddForm").form({
			    url:"Room/add",
			    onSubmit: function(){
					if($("#roomAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#roomAddForm").form("clear");
                        room_roomDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#roomAddForm").submit();
		}
	});

	//单击清空按钮
	$("#roomClearButton").click(function () { 
		$("#roomAddForm").form("clear"); 
	});
});
