package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Notice;

import com.chengxusheji.mapper.NoticeMapper;
@Service
public class NoticeService {

	@Resource NoticeMapper noticeMapper;
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

    /*添加新闻公告记录*/
    public void addNotice(Notice notice) throws Exception {
    	noticeMapper.addNotice(notice);
    }

    /*按照查询条件分页查询新闻公告记录*/
    public ArrayList<Notice> queryNotice(String title,String publishDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_notice.title like '%" + title + "%'";
    	if(!publishDate.equals("")) where = where + " and t_notice.publishDate like '%" + publishDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return noticeMapper.queryNotice(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Notice> queryNotice(String title,String publishDate) throws Exception  { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_notice.title like '%" + title + "%'";
    	if(!publishDate.equals("")) where = where + " and t_notice.publishDate like '%" + publishDate + "%'";
    	return noticeMapper.queryNoticeList(where);
    }

    /*查询所有新闻公告记录*/
    public ArrayList<Notice> queryAllNotice()  throws Exception {
        return noticeMapper.queryNoticeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String title,String publishDate) throws Exception {
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_notice.title like '%" + title + "%'";
    	if(!publishDate.equals("")) where = where + " and t_notice.publishDate like '%" + publishDate + "%'";
        recordNumber = noticeMapper.queryNoticeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取新闻公告记录*/
    public Notice getNotice(int noticeId) throws Exception  {
        Notice notice = noticeMapper.getNotice(noticeId);
        return notice;
    }

    /*更新新闻公告记录*/
    public void updateNotice(Notice notice) throws Exception {
        noticeMapper.updateNotice(notice);
    }

    /*删除一条新闻公告记录*/
    public void deleteNotice (int noticeId) throws Exception {
        noticeMapper.deleteNotice(noticeId);
    }

    /*删除多条新闻公告信息*/
    public int deleteNotices (String noticeIds) throws Exception {
    	String _noticeIds[] = noticeIds.split(",");
    	for(String _noticeId: _noticeIds) {
    		noticeMapper.deleteNotice(Integer.parseInt(_noticeId));
    	}
    	return _noticeIds.length;
    }
}
