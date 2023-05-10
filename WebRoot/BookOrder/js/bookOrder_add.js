$(function () {
	$("#bookOrder_roomObj_roomNo").combobox({
	    url:'Room/listAll',
	    valueField: "roomNo",
	    textField: "roomNo",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#bookOrder_roomObj_roomNo").combobox("getData"); 
            if (data.length > 0) {
                $("#bookOrder_roomObj_roomNo").combobox("select", data[0].roomNo);
            }
        }
	});
	$("#bookOrder_roomTypeObj_roomTypeId").combobox({
	    url:'RoomType/listAll',
	    valueField: "roomTypeId",
	    textField: "roomTypeName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#bookOrder_roomTypeObj_roomTypeId").combobox("getData"); 
            if (data.length > 0) {
                $("#bookOrder_roomTypeObj_roomTypeId").combobox("select", data[0].roomTypeId);
            }
        }
	});
	$("#bookOrder_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#bookOrder_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#bookOrder_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#bookOrder_liveDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#bookOrder_days").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入预订天数',
		invalidMessage : '预订天数输入不对',
	});

	$("#bookOrder_totalMoney").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入总价',
		invalidMessage : '总价输入不对',
	});

	$("#bookOrder_orderState").validatebox({
		required : true, 
		missingMessage : '请输入订单状态',
	});

	$("#bookOrder_orderTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#bookOrderAddButton").click(function () {
		//验证表单 
		if(!$("#bookOrderAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#bookOrderAddForm").form({
			    url:"BookOrder/add",
			    onSubmit: function(){
					if($("#bookOrderAddForm").form("validate"))  { 
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
                        $("#bookOrderAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#bookOrderAddForm").submit();
		}
	});

	//单击清空按钮
	$("#bookOrderClearButton").click(function () { 
		$("#bookOrderAddForm").form("clear"); 
	});
});
