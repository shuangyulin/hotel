package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Room;

public interface RoomMapper {
	/*添加房间信息*/
	public void addRoom(Room room) throws Exception;

	/*按照查询条件分页查询房间记录*/
	public ArrayList<Room> queryRoom(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有房间记录*/
	public ArrayList<Room> queryRoomList(@Param("where") String where) throws Exception;

	/*按照查询条件的房间记录数*/
	public int queryRoomCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条房间记录*/
	public Room getRoom(String roomNo) throws Exception;

	/*更新房间记录*/
	public void updateRoom(Room room) throws Exception;

	/*删除房间记录*/
	public void deleteRoom(String roomNo) throws Exception;

}
