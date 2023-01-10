package com.kh.seeReal.report.model.service;

import java.util.ArrayList;


import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.vo.Meeting;

public interface ReportService {



	
	
	int selectBoardReportCount();
	
	ArrayList<Board> selectReportBoardList(PageInfo pi);
	
	int selectMeetingReportCount();

	ArrayList<Meeting> selectReportMeetingList(PageInfo pi);
	
	

	int insertReport(Board b);

	int increaseReportCount(int boardNo);
	
	
	
	
	
}
