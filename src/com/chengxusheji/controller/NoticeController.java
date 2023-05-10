package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.NoticeService;
import com.chengxusheji.po.Notice;

//Notice管理控制层
@Controller
@RequestMapping("/Notice")
public class NoticeController extends BaseController {

    /*业务层对象*/
    @Resource NoticeService noticeService;

	@InitBinder("notice")
	public void initBinderNotice(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("notice.");
	}
	/*跳转到添加Notice视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Notice());
		return "Notice_add";
	}

	/*客户端ajax方式提交添加新闻公告信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Notice notice, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        noticeService.addNotice(notice);
        message = "新闻公告添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询新闻公告信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String title,String publishDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (title == null) title = "";
		if (publishDate == null) publishDate = "";
		if(rows != 0)noticeService.setRows(rows);
		List<Notice> noticeList = noticeService.queryNotice(title, publishDate, page);
	    /*计算总的页数和总的记录数*/
	    noticeService.queryTotalPageAndRecordNumber(title, publishDate);
	    /*获取到总的页码数目*/
	    int totalPage = noticeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = noticeService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Notice notice:noticeList) {
			JSONObject jsonNotice = notice.getJsonObject();
			jsonArray.put(jsonNotice);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询新闻公告信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Notice> noticeList = noticeService.queryAllNotice();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Notice notice:noticeList) {
			JSONObject jsonNotice = new JSONObject();
			jsonNotice.accumulate("noticeId", notice.getNoticeId());
			jsonNotice.accumulate("title", notice.getTitle());
			jsonArray.put(jsonNotice);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询新闻公告信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String title,String publishDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (title == null) title = "";
		if (publishDate == null) publishDate = "";
		List<Notice> noticeList = noticeService.queryNotice(title, publishDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    noticeService.queryTotalPageAndRecordNumber(title, publishDate);
	    /*获取到总的页码数目*/
	    int totalPage = noticeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = noticeService.getRecordNumber();
	    request.setAttribute("noticeList",  noticeList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("title", title);
	    request.setAttribute("publishDate", publishDate);
		return "Notice/notice_frontquery_result"; 
	}

     /*前台查询Notice信息*/
	@RequestMapping(value="/{noticeId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer noticeId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键noticeId获取Notice对象*/
        Notice notice = noticeService.getNotice(noticeId);

        request.setAttribute("notice",  notice);
        return "Notice/notice_frontshow";
	}

	/*ajax方式显示新闻公告修改jsp视图页*/
	@RequestMapping(value="/{noticeId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer noticeId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键noticeId获取Notice对象*/
        Notice notice = noticeService.getNotice(noticeId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonNotice = notice.getJsonObject();
		out.println(jsonNotice.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新新闻公告信息*/
	@RequestMapping(value = "/{noticeId}/update", method = RequestMethod.POST)
	public void update(@Validated Notice notice, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			noticeService.updateNotice(notice);
			message = "新闻公告更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "新闻公告更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除新闻公告信息*/
	@RequestMapping(value="/{noticeId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer noticeId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  noticeService.deleteNotice(noticeId);
	            request.setAttribute("message", "新闻公告删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "新闻公告删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条新闻公告记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String noticeIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = noticeService.deleteNotices(noticeIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出新闻公告信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String title,String publishDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(title == null) title = "";
        if(publishDate == null) publishDate = "";
        List<Notice> noticeList = noticeService.queryNotice(title,publishDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Notice信息记录"; 
        String[] headers = { "公告id","标题","点击率","发布时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<noticeList.size();i++) {
        	Notice notice = noticeList.get(i); 
        	dataset.add(new String[]{notice.getNoticeId() + "",notice.getTitle(),notice.getHitNum() + "",notice.getPublishDate()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Notice.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
