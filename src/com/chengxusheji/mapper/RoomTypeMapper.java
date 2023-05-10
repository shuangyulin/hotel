package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.RoomType;

public interface RoomTypeMapper {
	/*添加房间类型信息*/
	public void addRoomType(RoomType roomType) throws Exception;

	/*按照查询条件分页查询房间类型记录*/
	public ArrayList<RoomType> queryRoomType(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有房间类型记录*/
	public ArrayList<RoomType> queryRoomTypeList(@Param("where") String where) throws Exception;

	/*按照查询条件的房间类型记录数*/
	public int queryRoomTypeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条房间类型记录*/
	public RoomType getRoomType(int roomTypeId) throws Exception;

	/*更新房间类型记录*/
	public void updateRoomType(RoomType roomType) throws Exception;

	/*删除房间类型记录*/
	public void deleteRoomType(int roomTypeId) throws Exception;

}
