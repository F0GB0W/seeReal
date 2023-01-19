package com.kh.seeReal.report.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.vo.Meeting;
import com.kh.seeReal.report.model.vo.Report;

public interface ReportService {



	
	
	int selectBoardReportCount();
	
	ArrayList<Board> selectReportBoardList(PageInfo pi);
	
	int selectMeetingReportCount();

	ArrayList<Meeting> selectReportMeetingList(PageInfo pi);
	
	


	int insertReport(Report r);
	
	int increaseSpoBoardReport(int boardNo);
	int increaseFreeBoardReport(int boardNo);
	int increaseBoReplyReport(int boReplyNo);
	int increaseMeetingReport(int meetingNo);
	int increaseCollectionReport(int collectionNo);
	int increaseCommentReport(int commentNo);
	int increaseCoReplyReport(int coReplyNo);

	int selectReportCount(Report r);
	int sanctionsCollection();
	int sanctionsMeeting();
	int sanctionsComments();
	int sanctionsBoReply();
	int sanctionsCollectionReply();	
	
	
}
