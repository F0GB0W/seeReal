package com.kh.seeReal.report.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.vo.Meeting;
import com.kh.seeReal.report.model.dao.ReportDao;

@Service
public class ReportServiceImpl implements ReportService {

	@Autowired
	private ReportDao reportDao;	
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public int selectBoardReportCount() {
		// TODO Auto-generated method stub
		return reportDao.selectBoardReportCount(sqlSession);
	}

	@Override
	public ArrayList<Board> selectReportBoardList(PageInfo pi) {
		// TODO Auto-generated method stub
		return reportDao.selectReportBoardList(sqlSession, pi);
	}

	@Override
	public int selectMeetingReportCount() {
		// TODO Auto-generated method stub
		 return reportDao.selectMeetingReportCount(sqlSession);
	}

	@Override
	public ArrayList<Meeting> selectReportMeetingList(PageInfo pi) {
		// TODO Auto-generated method stub
		return reportDao.selectReportMeetingList(sqlSession, pi);
	}


	
	
	

}
