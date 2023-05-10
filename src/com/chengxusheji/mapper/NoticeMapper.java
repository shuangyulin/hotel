package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Notice;

public interface NoticeMapper {
	/*添加新闻公告信息*/
	public void addNotice(Notice notice) throws Exception;

	/*按照查询条件分页查询新闻公告记录*/
	public ArrayList<Notice> queryNotice(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有新闻公告记录*/
	public ArrayList<Notice> queryNoticeList(@Param("where") String where) throws Exception;

	/*按照查询条件的新闻公告记录数*/
	public int queryNoticeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条新闻公告记录*/
	public Notice getNotice(int noticeId) throws Exception;

	/*更新新闻公告记录*/
	public void updateNotice(Notice notice) throws Exception;

	/*删除新闻公告记录*/
	public void deleteNotice(int noticeId) throws Exception;

}
