package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class RoomType {
    /*类型id*/
    private Integer roomTypeId;
    public Integer getRoomTypeId(){
        return roomTypeId;
    }
    public void setRoomTypeId(Integer roomTypeId){
        this.roomTypeId = roomTypeId;
    }

    /*房间类型*/
    @NotEmpty(message="房间类型不能为空")
    private String roomTypeName;
    public String getRoomTypeName() {
        return roomTypeName;
    }
    public void setRoomTypeName(String roomTypeName) {
        this.roomTypeName = roomTypeName;
    }

    /*价格(每天)*/
    @NotNull(message="必须输入价格(每天)")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonRoomType=new JSONObject(); 
		jsonRoomType.accumulate("roomTypeId", this.getRoomTypeId());
		jsonRoomType.accumulate("roomTypeName", this.getRoomTypeName());
		jsonRoomType.accumulate("price", this.getPrice());
		return jsonRoomType;
    }}