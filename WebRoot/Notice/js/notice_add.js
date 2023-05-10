$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('notice_content');
	var notice_content_editor = UE.getEditor('notice_content'); //公告内容编辑框
	$("#notice_title").validatebox({
		required : true, 
		missingMessage : '请输入标题',
	});

	$("#notice_hitNum").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入点击率',
		invalidMessage : '点击率输入不对',
	});

	$("#notice_publishDate").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#noticeAddButton").click(function () {
		if(notice_content_editor.getContent() == "") {
			alert("请输入公告内容");
			return;
		}
		//验证表单 
		if(!$("#noticeAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#noticeAddForm").form({
			    url:"Notice/add",
			    onSubmit: function(){
					if($("#noticeAddForm").form("validate"))  { 
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
                        $("#noticeAddForm").form("clear");
                        notice_content_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#noticeAddForm").submit();
		}
	});

	//单击清空按钮
	$("#noticeClearButton").click(function () { 
		$("#noticeAddForm").form("clear"); 
	});
});
