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
import com.chengxusheji.service.BookOrderService;
import com.chengxusheji.po.BookOrder;
import com.chengxusheji.service.RoomService;
import com.chengxusheji.po.Room;
import com.chengxusheji.service.RoomTypeService;
import com.chengxusheji.po.RoomType;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//BookOrder管理控制层
@Controller
@RequestMapping("/BookOrder")
public class BookOrderController extends BaseController {

    /*业务层对象*/
    @Resource BookOrderService bookOrderService;

    @Resource RoomService roomService;
    @Resource RoomTypeService roomTypeService;
    @Resource UserInfoService userInfoService;
	@InitBinder("roomObj")
	public void initBinderroomObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("roomObj.");
	}
	@InitBinder("roomTypeObj")
	public void initBinderroomTypeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("roomTypeObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("bookOrder")
	public void initBinderBookOrder(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("bookOrder.");
	}
	/*跳转到添加BookOrder视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new BookOrder());
		/*查询所有的Room信息*/
		List<Room> roomList = roomService.queryAllRoom();
		request.setAttribute("roomList", roomList);
		/*查询所有的RoomType信息*/
		List<RoomType> roomTypeList = roomTypeService.queryAllRoomType();
		request.setAttribute("roomTypeList", roomTypeList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "BookOrder_add";
	}

	/*客户端ajax方式提交添加房间预订信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated BookOrder bookOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        bookOrderService.addBookOrder(bookOrder);
        message = "房间预订添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询房间预订信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("roomObj") Room roomObj,@ModelAttribute("roomTypeObj") RoomType roomTypeObj,@ModelAttribute("userObj") UserInfo userObj,String liveDate,String orderState,String orderTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (liveDate == null) liveDate = "";
		if (orderState == null) orderState = "";
		if (orderTime == null) orderTime = "";
		if(rows != 0)bookOrderService.setRows(rows);
		List<BookOrder> bookOrderList = bookOrderService.queryBookOrder(roomObj, roomTypeObj, userObj, liveDate, orderState, orderTime, page);
	    /*计算总的页数和总的记录数*/
	    bookOrderService.queryTotalPageAndRecordNumber(roomObj, roomTypeObj, userObj, liveDate, orderState, orderTime);
	    /*获取到总的页码数目*/
	    int totalPage = bookOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = bookOrderService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(BookOrder bookOrder:bookOrderList) {
			JSONObject jsonBookOrder = bookOrder.getJsonObject();
			jsonArray.put(jsonBookOrder);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询房间预订信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<BookOrder> bookOrderList = bookOrderService.queryAllBookOrder();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(BookOrder bookOrder:bookOrderList) {
			JSONObject jsonBookOrder = new JSONObject();
			jsonBookOrder.accumulate("orderId", bookOrder.getOrderId());
			jsonArray.put(jsonBookOrder);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询房间预订信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("roomObj") Room roomObj,@ModelAttribute("roomTypeObj") RoomType roomTypeObj,@ModelAttribute("userObj") UserInfo userObj,String liveDate,String orderState,String orderTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (liveDate == null) liveDate = "";
		if (orderState == null) orderState = "";
		if (orderTime == null) orderTime = "";
		List<BookOrder> bookOrderList = bookOrderService.queryBookOrder(roomObj, roomTypeObj, userObj, liveDate, orderState, orderTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    bookOrderService.queryTotalPageAndRecordNumber(roomObj, roomTypeObj, userObj, liveDate, orderState, orderTime);
	    /*获取到总的页码数目*/
	    int totalPage = bookOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = bookOrderService.getRecordNumber();
	    request.setAttribute("bookOrderList",  bookOrderList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("roomObj", roomObj);
	    request.setAttribute("roomTypeObj", roomTypeObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("liveDate", liveDate);
	    request.setAttribute("orderState", orderState);
	    request.setAttribute("orderTime", orderTime);
	    List<Room> roomList = roomService.queryAllRoom();
	    request.setAttribute("roomList", roomList);
	    List<RoomType> roomTypeList = roomTypeService.queryAllRoomType();
	    request.setAttribute("roomTypeList", roomTypeList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "BookOrder/bookOrder_frontquery_result"; 
	}

     /*前台查询BookOrder信息*/
	@RequestMapping(value="/{orderId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer orderId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键orderId获取BookOrder对象*/
        BookOrder bookOrder = bookOrderService.getBookOrder(orderId);

        List<Room> roomList = roomService.queryAllRoom();
        request.setAttribute("roomList", roomList);
        List<RoomType> roomTypeList = roomTypeService.queryAllRoomType();
        request.setAttribute("roomTypeList", roomTypeList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("bookOrder",  bookOrder);
        return "BookOrder/bookOrder_frontshow";
	}

	/*ajax方式显示房间预订修改jsp视图页*/
	@RequestMapping(value="/{orderId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer orderId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键orderId获取BookOrder对象*/
        BookOrder bookOrder = bookOrderService.getBookOrder(orderId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonBookOrder = bookOrder.getJsonObject();
		out.println(jsonBookOrder.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新房间预订信息*/
	@RequestMapping(value = "/{orderId}/update", method = RequestMethod.POST)
	public void update(@Validated BookOrder bookOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			bookOrderService.updateBookOrder(bookOrder);
			message = "房间预订更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "房间预订更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除房间预订信息*/
	@RequestMapping(value="/{orderId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer orderId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  bookOrderService.deleteBookOrder(orderId);
	            request.setAttribute("message", "房间预订删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "房间预订删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条房间预订记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String orderIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = bookOrderService.deleteBookOrders(orderIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出房间预订信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("roomObj") Room roomObj,@ModelAttribute("roomTypeObj") RoomType roomTypeObj,@ModelAttribute("userObj") UserInfo userObj,String liveDate,String orderState,String orderTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(liveDate == null) liveDate = "";
        if(orderState == null) orderState = "";
        if(orderTime == null) orderTime = "";
        List<BookOrder> bookOrderList = bookOrderService.queryBookOrder(roomObj,roomTypeObj,userObj,liveDate,orderState,orderTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "BookOrder信息记录"; 
        String[] headers = { "订单id","预订房间","房间类型","预订人","入住日期","预订天数","总价","订单备注","订单状态","预订时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<bookOrderList.size();i++) {
        	BookOrder bookOrder = bookOrderList.get(i); 
        	dataset.add(new String[]{bookOrder.getOrderId() + "",bookOrder.getRoomObj().getRoomNo(),bookOrder.getRoomTypeObj().getRoomTypeName(),bookOrder.getUserObj().getName(),bookOrder.getLiveDate(),bookOrder.getDays() + "",bookOrder.getTotalMoney() + "",bookOrder.getOrderMemo(),bookOrder.getOrderState(),bookOrder.getOrderTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"BookOrder.xls");//filename是下载的xls的名，建议最好用英文 
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
