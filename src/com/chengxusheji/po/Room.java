package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Room {
    /*房间号*/
    @NotEmpty(message="房间号不能为空")
    private String roomNo;
    public String getRoomNo(){
        return roomNo;
    }
    public void setRoomNo(String roomNo){
        this.roomNo = roomNo;
    }

    /*房间类型*/
    private RoomType roomTypeObj;
    public RoomType getRoomTypeObj() {
        return roomTypeObj;
    }
    public void setRoomTypeObj(RoomType roomTypeObj) {
        this.roomTypeObj = roomTypeObj;
    }

    /*房间图片*/
    private String roomPhoto;
    public String getRoomPhoto() {
        return roomPhoto;
    }
    public void setRoomPhoto(String roomPhoto) {
        this.roomPhoto = roomPhoto;
    }

    /*价格(每天)*/
    @NotNull(message="必须输入价格(每天)")
    private Float roomPrice;
    public Float getRoomPrice() {
        return roomPrice;
    }
    public void setRoomPrice(Float roomPrice) {
        this.roomPrice = roomPrice;
    }

    /*楼层*/
    @NotEmpty(message="楼层不能为空")
    private String floorNum;
    public String getFloorNum() {
        return floorNum;
    }
    public void setFloorNum(String floorNum) {
        this.floorNum = floorNum;
    }

    /*占用状态*/
    @NotEmpty(message="占用状态不能为空")
    private String roomState;
    public String getRoomState() {
        return roomState;
    }
    public void setRoomState(String roomState) {
        this.roomState = roomState;
    }

    /*房间描述*/
    @NotEmpty(message="房间描述不能为空")
    private String roomDesc;
    public String getRoomDesc() {
        return roomDesc;
    }
    public void setRoomDesc(String roomDesc) {
        this.roomDesc = roomDesc;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonRoom=new JSONObject(); 
		jsonRoom.accumulate("roomNo", this.getRoomNo());
		jsonRoom.accumulate("roomTypeObj", this.getRoomTypeObj().getRoomTypeName());
		jsonRoom.accumulate("roomTypeObjPri", this.getRoomTypeObj().getRoomTypeId());
		jsonRoom.accumulate("roomPhoto", this.getRoomPhoto());
		jsonRoom.accumulate("roomPrice", this.getRoomPrice());
		jsonRoom.accumulate("floorNum", this.getFloorNum());
		jsonRoom.accumulate("roomState", this.getRoomState());
		jsonRoom.accumulate("roomDesc", this.getRoomDesc());
		return jsonRoom;
    }}