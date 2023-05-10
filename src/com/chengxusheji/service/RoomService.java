package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.RoomType;
import com.chengxusheji.po.Room;

import com.chengxusheji.mapper.RoomMapper;
@Service
public class RoomService {

	@Resource RoomMapper roomMapper;
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

    /*添加房间记录*/
    public void addRoom(Room room) throws Exception {
    	roomMapper.addRoom(room);
    }

    /*按照查询条件分页查询房间记录*/
    public ArrayList<Room> queryRoom(String roomNo,RoomType roomTypeObj,String roomState,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!roomNo.equals("")) where = where + " and t_room.roomNo like '%" + roomNo + "%'";
    	if(null != roomTypeObj && roomTypeObj.getRoomTypeId()!= null && roomTypeObj.getRoomTypeId()!= 0)  where += " and t_room.roomTypeObj=" + roomTypeObj.getRoomTypeId();
    	if(!roomState.equals("")) where = where + " and t_room.roomState like '%" + roomState + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return roomMapper.queryRoom(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Room> queryRoom(String roomNo,RoomType roomTypeObj,String roomState) throws Exception  { 
     	String where = "where 1=1";
    	if(!roomNo.equals("")) where = where + " and t_room.roomNo like '%" + roomNo + "%'";
    	if(null != roomTypeObj && roomTypeObj.getRoomTypeId()!= null && roomTypeObj.getRoomTypeId()!= 0)  where += " and t_room.roomTypeObj=" + roomTypeObj.getRoomTypeId();
    	if(!roomState.equals("")) where = where + " and t_room.roomState like '%" + roomState + "%'";
    	return roomMapper.queryRoomList(where);
    }

    /*查询所有房间记录*/
    public ArrayList<Room> queryAllRoom()  throws Exception {
        return roomMapper.queryRoomList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String roomNo,RoomType roomTypeObj,String roomState) throws Exception {
     	String where = "where 1=1";
    	if(!roomNo.equals("")) where = where + " and t_room.roomNo like '%" + roomNo + "%'";
    	if(null != roomTypeObj && roomTypeObj.getRoomTypeId()!= null && roomTypeObj.getRoomTypeId()!= 0)  where += " and t_room.roomTypeObj=" + roomTypeObj.getRoomTypeId();
    	if(!roomState.equals("")) where = where + " and t_room.roomState like '%" + roomState + "%'";
        recordNumber = roomMapper.queryRoomCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取房间记录*/
    public Room getRoom(String roomNo) throws Exception  {
        Room room = roomMapper.getRoom(roomNo);
        return room;
    }

    /*更新房间记录*/
    public void updateRoom(Room room) throws Exception {
        roomMapper.updateRoom(room);
    }

    /*删除一条房间记录*/
    public void deleteRoom (String roomNo) throws Exception {
        roomMapper.deleteRoom(roomNo);
    }

    /*删除多条房间信息*/
    public int deleteRooms (String roomNos) throws Exception {
    	String _roomNos[] = roomNos.split(",");
    	for(String _roomNo: _roomNos) {
    		roomMapper.deleteRoom(_roomNo);
    	}
    	return _roomNos.length;
    }
}
