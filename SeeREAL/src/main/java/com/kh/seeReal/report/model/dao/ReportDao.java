package com.kh.seeReal.report.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.common.template.Pagination;
import com.kh.seeReal.meeting.model.vo.Meeting;
import com.kh.seeReal.report.model.service.ReportService;
import com.kh.seeReal.report.model.service.ReportServiceImpl;

@Repository
public class ReportDao {


	public ArrayList<Board> selectReportBoardList(SqlSessionTemplate sqlSession, PageInfo pi){
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("reportMapper.selectReportBoardList", pi, rowBounds);
	}
	public ArrayList<Meeting> selectReportMeetingList(SqlSessionTemplate sqlSession, PageInfo pi) {

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("reportMapper.selectReportMeetingList", pi, rowBounds);
	}
	public int selectBoardReportCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reportMapper.selectBoardReportCount");
	}
	public int selectMeetingReportCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reportMapper.selectMeetingReportCount");
	}
	public int selectCollectionReportCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reportMapper.selectCollectionReportCount");
	}
	
	
	
	

	
	
	
	
	
	
	
	
	/*
	
	public int insertBoardReport(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.insert("reportMapper.insertBoardReport", r);
	}
	public int insertCollectionReport(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.insert("reportMapper.insertCollectionReport", r);
	}	
	public int insertMeetingReport(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.insert("reportMapper.insertMeetingReport", r);
	}
	*/
	
	
	
	
	
	
}
