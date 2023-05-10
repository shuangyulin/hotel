$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('notice_content_edit');
	var notice_content_edit = UE.getEditor('notice_content_edit'); //公告内容编辑器
	notice_content_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Notice/" + $("#notice_noticeId_edit").val() + "/update",
		type : "get",
		data : {
			//noticeId : $("#notice_noticeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (notice, response, status) {
			$.messager.progress("close");
			if (notice) { 
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
				notice_content_edit.setContent(notice.content);
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#noticeModifyButton").click(function(){ 
		if ($("#noticeEditForm").form("validate")) {
			$("#noticeEditForm").form({
			    url:"Notice/" +  $("#notice_noticeId_edit").val() + "/update",
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
			$("#noticeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
