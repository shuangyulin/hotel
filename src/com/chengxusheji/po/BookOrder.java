package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class BookOrder {
    /*订单id*/
    private Integer orderId;
    public Integer getOrderId(){
        return orderId;
    }
    public void setOrderId(Integer orderId){
        this.orderId = orderId;
    }

    /*预订房间*/
    private Room roomObj;
    public Room getRoomObj() {
        return roomObj;
    }
    public void setRoomObj(Room roomObj) {
        this.roomObj = roomObj;
    }

    /*房间类型*/
    private RoomType roomTypeObj;
    public RoomType getRoomTypeObj() {
        return roomTypeObj;
    }
    public void setRoomTypeObj(RoomType roomTypeObj) {
        this.roomTypeObj = roomTypeObj;
    }

    /*预订人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*入住日期*/
    @NotEmpty(message="入住日期不能为空")
    private String liveDate;
    public String getLiveDate() {
        return liveDate;
    }
    public void setLiveDate(String liveDate) {
        this.liveDate = liveDate;
    }

    /*预订天数*/
    @NotNull(message="必须输入预订天数")
    private Integer days;
    public Integer getDays() {
        return days;
    }
    public void setDays(Integer days) {
        this.days = days;
    }

    /*总价*/
    @NotNull(message="必须输入总价")
    private Float totalMoney;
    public Float getTotalMoney() {
        return totalMoney;
    }
    public void setTotalMoney(Float totalMoney) {
        this.totalMoney = totalMoney;
    }

    /*订单备注*/
    private String orderMemo;
    public String getOrderMemo() {
        return orderMemo;
    }
    public void setOrderMemo(String orderMemo) {
        this.orderMemo = orderMemo;
    }

    /*订单状态*/
    @NotEmpty(message="订单状态不能为空")
    private String orderState;
    public String getOrderState() {
        return orderState;
    }
    public void setOrderState(String orderState) {
        this.orderState = orderState;
    }

    /*预订时间*/
    @NotEmpty(message="预订时间不能为空")
    private String orderTime;
    public String getOrderTime() {
        return orderTime;
    }
    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonBookOrder=new JSONObject(); 
		jsonBookOrder.accumulate("orderId", this.getOrderId());
		jsonBookOrder.accumulate("roomObj", this.getRoomObj().getRoomNo());
		jsonBookOrder.accumulate("roomObjPri", this.getRoomObj().getRoomNo());
		jsonBookOrder.accumulate("roomTypeObj", this.getRoomTypeObj().getRoomTypeName());
		jsonBookOrder.accumulate("roomTypeObjPri", this.getRoomTypeObj().getRoomTypeId());
		jsonBookOrder.accumulate("userObj", this.getUserObj().getName());
		jsonBookOrder.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonBookOrder.accumulate("liveDate", this.getLiveDate().length()>19?this.getLiveDate().substring(0,19):this.getLiveDate());
		jsonBookOrder.accumulate("days", this.getDays());
		jsonBookOrder.accumulate("totalMoney", this.getTotalMoney());
		jsonBookOrder.accumulate("orderMemo", this.getOrderMemo());
		jsonBookOrder.accumulate("orderState", this.getOrderState());
		jsonBookOrder.accumulate("orderTime", this.getOrderTime().length()>19?this.getOrderTime().substring(0,19):this.getOrderTime());
		return jsonBookOrder;
    }}