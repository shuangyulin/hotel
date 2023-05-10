$(function () {
	$("#roomType_roomTypeName").validatebox({
		required : true, 
		missingMessage : '请输入房间类型',
	});

	$("#roomType_price").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入价格(每天)',
		invalidMessage : '价格(每天)输入不对',
	});

	//单击添加按钮
	$("#roomTypeAddButton").click(function () {
		//验证表单 
		if(!$("#roomTypeAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#roomTypeAddForm").form({
			    url:"RoomType/add",
			    onSubmit: function(){
					if($("#roomTypeAddForm").form("validate"))  { 
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
                        $("#roomTypeAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#roomTypeAddForm").submit();
		}
	});

	//单击清空按钮
	$("#roomTypeClearButton").click(function () { 
		$("#roomTypeAddForm").form("clear"); 
	});
});
