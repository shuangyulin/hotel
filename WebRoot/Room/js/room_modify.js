$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('room_roomDesc_edit');
	var room_roomDesc_edit = UE.getEditor('room_roomDesc_edit'); //房间描述编辑器
	room_roomDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Room/" + $("#room_roomNo_edit").val() + "/update",
		type : "get",
		data : {
			//roomNo : $("#room_roomNo_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (room, response, status) {
			$.messager.progress("close");
			if (room) { 
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
				room_roomDesc_edit.setContent(room.roomDesc);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#roomModifyButton").click(function(){ 
		if ($("#roomEditForm").form("validate")) {
			$("#roomEditForm").form({
			    url:"Room/" +  $("#room_roomNo_edit").val() + "/update",
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
			$("#roomEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
