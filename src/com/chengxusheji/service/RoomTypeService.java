package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.RoomType;

import com.chengxusheji.mapper.RoomTypeMapper;
@Service
public class RoomTypeService {

	@Resource RoomTypeMapper roomTypeMapper;
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

    /*添加房间类型记录*/
    public void addRoomType(RoomType roomType) throws Exception {
    	roomTypeMapper.addRoomType(roomType);
    }

    /*按照查询条件分页查询房间类型记录*/
    public ArrayList<RoomType> queryRoomType(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return roomTypeMapper.queryRoomType(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<RoomType> queryRoomType() throws Exception  { 
     	String where = "where 1=1";
    	return roomTypeMapper.queryRoomTypeList(where);
    }

    /*查询所有房间类型记录*/
    public ArrayList<RoomType> queryAllRoomType()  throws Exception {
        return roomTypeMapper.queryRoomTypeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = roomTypeMapper.queryRoomTypeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取房间类型记录*/
    public RoomType getRoomType(int roomTypeId) throws Exception  {
        RoomType roomType = roomTypeMapper.getRoomType(roomTypeId);
        return roomType;
    }

    /*更新房间类型记录*/
    public void updateRoomType(RoomType roomType) throws Exception {
        roomTypeMapper.updateRoomType(roomType);
    }

    /*删除一条房间类型记录*/
    public void deleteRoomType (int roomTypeId) throws Exception {
        roomTypeMapper.deleteRoomType(roomTypeId);
    }

    /*删除多条房间类型信息*/
    public int deleteRoomTypes (String roomTypeIds) throws Exception {
    	String _roomTypeIds[] = roomTypeIds.split(",");
    	for(String _roomTypeId: _roomTypeIds) {
    		roomTypeMapper.deleteRoomType(Integer.parseInt(_roomTypeId));
    	}
    	return _roomTypeIds.length;
    }
}
