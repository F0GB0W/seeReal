package com.kh.seeReal.report.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.vo.Meeting;
import com.kh.seeReal.report.model.vo.Report;

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

	public int insertReport(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.insert("reportMapper.insertReport", r);
	}

	
	
	
	
	
	
	
	
	
	
	public int increaseSpoBoardReport(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("reportMapper.increaseSpoBoardReport", boardNo);
	}
	public int increaseFreeBoardReport(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("reportMapper.increaseFreeBoardReport", boardNo);
	}
	public int increaseBoReplyReport(SqlSessionTemplate sqlSession, int boReplyNo) {
		return sqlSession.update("reportMapper.increaseBoReplyReport", boReplyNo);
	}
	public int increaseMeetingReport(SqlSessionTemplate sqlSession, int meetingNo) {
		return sqlSession.update("reportMapper.increaseMeetingReport", meetingNo);
	}
	public int increaseCollectionReport(SqlSessionTemplate sqlSession, int collectionNo) {
		return sqlSession.update("reportMapper.increaseCollectionReport", collectionNo);
	}
	public int increaseCommentReport(SqlSessionTemplate sqlSession, int commentNo) {
		return sqlSession.update("reportMapper.increaseCommentReport", commentNo);
	}
	public int increaseCoReplyReport(SqlSessionTemplate sqlSession, int coReplyNo) {
		return sqlSession.update("reportMapper.increaseCoReplyReport", coReplyNo);
	}
	public int selectReportCount(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.selectOne("reportMapper.selectReportCount", r);
	}
	public int sanctionsCollection(SqlSessionTemplate sqlSession) {
		return sqlSession.update("reportMapper.sanctionsCollection") ;
	}
	public int sanctionsMeeting(SqlSessionTemplate sqlSession) {
		return sqlSession.update("reportMapper.sanctionsMeeting") ;
	}
	public int sanctionsComments(SqlSessionTemplate sqlSession) {
		return sqlSession.update("reportMapper.sanctionsComments") ;
	}
	public int sanctionsBoReply(SqlSessionTemplate sqlSession) {
		return sqlSession.update("reportMapper.sanctionsBoReply") ;
	}
	public int sanctionsCollectionReply(SqlSessionTemplate sqlSession) {
		return sqlSession.update("reportMapper.sanctionsCollectionReply") ;
	}
	public int insertReportBoardReply(SqlSessionTemplate sqlSession,Report r) {
		return sqlSession.insert("reportMapper.insertReportBoardReply", r);
	}
	public int selectReportBoardReplyCount(SqlSessionTemplate sqlSession,Report r) {
		return sqlSession.selectOne("reportMapper.selectReportBoardReplyCount", r);
	}
	public int insertMeetingReport(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.insert("reportMapper.insertMeetingReport", r);
	}
	public int reportMeetingCount(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.selectOne("reportMapper.reportMeetingCount", r);
	}
	public int insertCollectionReport(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.insert("reportMapper.insertCollectionReport", r);
	}
	public int reportCollectionCount(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.selectOne("reportMapper.reportCollectionCount", r);
	}
	public int insertReportCollectionReply(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.insert("reportMapper.insertReportCollectionReply", r);

	}
	public int reportCollectionReplyCount(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.selectOne("reportMapper.reportCollectionReplyCount", r);
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
