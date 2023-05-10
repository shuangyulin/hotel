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
import com.chengxusheji.service.RoomTypeService;
import com.chengxusheji.po.RoomType;

//RoomType管理控制层
@Controller
@RequestMapping("/RoomType")
public class RoomTypeController extends BaseController {

    /*业务层对象*/
    @Resource RoomTypeService roomTypeService;

	@InitBinder("roomType")
	public void initBinderRoomType(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("roomType.");
	}
	/*跳转到添加RoomType视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new RoomType());
		return "RoomType_add";
	}

	/*客户端ajax方式提交添加房间类型信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated RoomType roomType, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        roomTypeService.addRoomType(roomType);
        message = "房间类型添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询房间类型信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)roomTypeService.setRows(rows);
		List<RoomType> roomTypeList = roomTypeService.queryRoomType(page);
	    /*计算总的页数和总的记录数*/
	    roomTypeService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = roomTypeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = roomTypeService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(RoomType roomType:roomTypeList) {
			JSONObject jsonRoomType = roomType.getJsonObject();
			jsonArray.put(jsonRoomType);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询房间类型信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<RoomType> roomTypeList = roomTypeService.queryAllRoomType();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(RoomType roomType:roomTypeList) {
			JSONObject jsonRoomType = new JSONObject();
			jsonRoomType.accumulate("roomTypeId", roomType.getRoomTypeId());
			jsonRoomType.accumulate("roomTypeName", roomType.getRoomTypeName());
			jsonArray.put(jsonRoomType);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询房间类型信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<RoomType> roomTypeList = roomTypeService.queryRoomType(currentPage);
	    /*计算总的页数和总的记录数*/
	    roomTypeService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = roomTypeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = roomTypeService.getRecordNumber();
	    request.setAttribute("roomTypeList",  roomTypeList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "RoomType/roomType_frontquery_result"; 
	}

     /*前台查询RoomType信息*/
	@RequestMapping(value="/{roomTypeId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer roomTypeId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键roomTypeId获取RoomType对象*/
        RoomType roomType = roomTypeService.getRoomType(roomTypeId);

        request.setAttribute("roomType",  roomType);
        return "RoomType/roomType_frontshow";
	}

	/*ajax方式显示房间类型修改jsp视图页*/
	@RequestMapping(value="/{roomTypeId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer roomTypeId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键roomTypeId获取RoomType对象*/
        RoomType roomType = roomTypeService.getRoomType(roomTypeId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonRoomType = roomType.getJsonObject();
		out.println(jsonRoomType.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新房间类型信息*/
	@RequestMapping(value = "/{roomTypeId}/update", method = RequestMethod.POST)
	public void update(@Validated RoomType roomType, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			roomTypeService.updateRoomType(roomType);
			message = "房间类型更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "房间类型更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除房间类型信息*/
	@RequestMapping(value="/{roomTypeId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer roomTypeId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  roomTypeService.deleteRoomType(roomTypeId);
	            request.setAttribute("message", "房间类型删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "房间类型删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条房间类型记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String roomTypeIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = roomTypeService.deleteRoomTypes(roomTypeIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出房间类型信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<RoomType> roomTypeList = roomTypeService.queryRoomType();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "RoomType信息记录"; 
        String[] headers = { "类型id","房间类型","价格(每天)"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<roomTypeList.size();i++) {
        	RoomType roomType = roomTypeList.get(i); 
        	dataset.add(new String[]{roomType.getRoomTypeId() + "",roomType.getRoomTypeName(),roomType.getPrice() + ""});
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
			response.setHeader("Content-disposition","attachment; filename="+"RoomType.xls");//filename是下载的xls的名，建议最好用英文 
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
