package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.BookOrder;

public interface BookOrderMapper {
	/*添加房间预订信息*/
	public void addBookOrder(BookOrder bookOrder) throws Exception;

	/*按照查询条件分页查询房间预订记录*/
	public ArrayList<BookOrder> queryBookOrder(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有房间预订记录*/
	public ArrayList<BookOrder> queryBookOrderList(@Param("where") String where) throws Exception;

	/*按照查询条件的房间预订记录数*/
	public int queryBookOrderCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条房间预订记录*/
	public BookOrder getBookOrder(int orderId) throws Exception;

	/*更新房间预订记录*/
	public void updateBookOrder(BookOrder bookOrder) throws Exception;

	/*删除房间预订记录*/
	public void deleteBookOrder(int orderId) throws Exception;

}
