package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Room;
import com.chengxusheji.po.RoomType;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.BookOrder;

import com.chengxusheji.mapper.BookOrderMapper;
@Service
public class BookOrderService {

	@Resource BookOrderMapper bookOrderMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加房间预订记录*/
    public void addBookOrder(BookOrder bookOrder) throws Exception {
    	bookOrderMapper.addBookOrder(bookOrder);
    }

    /*按照查询条件分页查询房间预订记录*/
    public ArrayList<BookOrder> queryBookOrder(Room roomObj,RoomType roomTypeObj,UserInfo userObj,String liveDate,String orderState,String orderTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != roomObj &&  roomObj.getRoomNo() != null  && !roomObj.getRoomNo().equals(""))  where += " and t_bookOrder.roomObj='" + roomObj.getRoomNo() + "'";
    	if(null != roomTypeObj && roomTypeObj.getRoomTypeId()!= null && roomTypeObj.getRoomTypeId()!= 0)  where += " and t_bookOrder.roomTypeObj=" + roomTypeObj.getRoomTypeId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_bookOrder.userObj='" + userObj.getUser_name() + "'";
    	if(!liveDate.equals("")) where = where + " and t_bookOrder.liveDate like '%" + liveDate + "%'";
    	if(!orderState.equals("")) where = where + " and t_bookOrder.orderState like '%" + orderState + "%'";
    	if(!orderTime.equals("")) where = where + " and t_bookOrder.orderTime like '%" + orderTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return bookOrderMapper.queryBookOrder(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<BookOrder> queryBookOrder(Room roomObj,RoomType roomTypeObj,UserInfo userObj,String liveDate,String orderState,String orderTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != roomObj &&  roomObj.getRoomNo() != null && !roomObj.getRoomNo().equals(""))  where += " and t_bookOrder.roomObj='" + roomObj.getRoomNo() + "'";
    	if(null != roomTypeObj && roomTypeObj.getRoomTypeId()!= null && roomTypeObj.getRoomTypeId()!= 0)  where += " and t_bookOrder.roomTypeObj=" + roomTypeObj.getRoomTypeId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_bookOrder.userObj='" + userObj.getUser_name() + "'";
    	if(!liveDate.equals("")) where = where + " and t_bookOrder.liveDate like '%" + liveDate + "%'";
    	if(!orderState.equals("")) where = where + " and t_bookOrder.orderState like '%" + orderState + "%'";
    	if(!orderTime.equals("")) where = where + " and t_bookOrder.orderTime like '%" + orderTime + "%'";
    	return bookOrderMapper.queryBookOrderList(where);
    }

    /*查询所有房间预订记录*/
    public ArrayList<BookOrder> queryAllBookOrder()  throws Exception {
        return bookOrderMapper.queryBookOrderList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Room roomObj,RoomType roomTypeObj,UserInfo userObj,String liveDate,String orderState,String orderTime) throws Exception {
     	String where = "where 1=1";
    	if(null != roomObj &&  roomObj.getRoomNo() != null && !roomObj.getRoomNo().equals(""))  where += " and t_bookOrder.roomObj='" + roomObj.getRoomNo() + "'";
    	if(null != roomTypeObj && roomTypeObj.getRoomTypeId()!= null && roomTypeObj.getRoomTypeId()!= 0)  where += " and t_bookOrder.roomTypeObj=" + roomTypeObj.getRoomTypeId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_bookOrder.userObj='" + userObj.getUser_name() + "'";
    	if(!liveDate.equals("")) where = where + " and t_bookOrder.liveDate like '%" + liveDate + "%'";
    	if(!orderState.equals("")) where = where + " and t_bookOrder.orderState like '%" + orderState + "%'";
    	if(!orderTime.equals("")) where = where + " and t_bookOrder.orderTime like '%" + orderTime + "%'";
        recordNumber = bookOrderMapper.queryBookOrderCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取房间预订记录*/
    public BookOrder getBookOrder(int orderId) throws Exception  {
        BookOrder bookOrder = bookOrderMapper.getBookOrder(orderId);
        return bookOrder;
    }

    /*更新房间预订记录*/
    public void updateBookOrder(BookOrder bookOrder) throws Exception {
        bookOrderMapper.updateBookOrder(bookOrder);
    }

    /*删除一条房间预订记录*/
    public void deleteBookOrder (int orderId) throws Exception {
        bookOrderMapper.deleteBookOrder(orderId);
    }

    /*删除多条房间预订信息*/
    public int deleteBookOrders (String orderIds) throws Exception {
    	String _orderIds[] = orderIds.split(",");
    	for(String _orderId: _orderIds) {
    		bookOrderMapper.deleteBookOrder(Integer.parseInt(_orderId));
    	}
    	return _orderIds.length;
    }
}
