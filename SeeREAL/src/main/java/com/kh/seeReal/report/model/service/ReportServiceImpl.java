package com.kh.seeReal.report.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.vo.Meeting;
import com.kh.seeReal.report.model.dao.ReportDao;
import com.kh.seeReal.report.model.vo.Report;

@Service
public class ReportServiceImpl implements ReportService {

	@Autowired
	private ReportDao reportDao;	
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectBoardReportCount() {
		return reportDao.selectBoardReportCount(sqlSession);
	}
	@Override
	public ArrayList<Board> selectReportBoardList(PageInfo pi) {
		return reportDao.selectReportBoardList(sqlSession, pi);
	}

	@Override
	public int selectMeetingReportCount() {
		 return reportDao.selectMeetingReportCount(sqlSession);
	}

	@Override
	public ArrayList<Meeting> selectReportMeetingList(PageInfo pi) {
		return reportDao.selectReportMeetingList(sqlSession, pi);
	}

	@Override
	public int insertReport(Report r) {
			return reportDao.insertReport(sqlSession, r);
	}
	
	
	
	
	

	@Override
	public int increaseSpoBoardReport(int boardNo) {
		return reportDao.increaseSpoBoardReport(sqlSession, boardNo);
	}
	@Override
	public int increaseFreeBoardReport(int boardNo) {
		return reportDao.increaseSpoBoardReport(sqlSession, boardNo);

	}
	@Override
	public int increaseBoReplyReport(int boReplyNo) {
		return reportDao.increaseBoReplyReport(sqlSession, boReplyNo);

	}
	@Override
	public int increaseMeetingReport(int meetingNo) {
		return reportDao.increaseMeetingReport(sqlSession, meetingNo);

	}
	@Override
	public int increaseCollectionReport(int collectionNo) {
		return reportDao.increaseCollectionReport(sqlSession, collectionNo);

	}
	@Override
	public int increaseCommentReport(int commentNo) {
		return reportDao.increaseCommentReport(sqlSession, commentNo);
		
	}
	@Override
	public int increaseCoReplyReport(int coReplyNo) {
		return reportDao.increaseCoReplyReport(sqlSession, coReplyNo);

	}
	@Override
	public int selectReportCount(Report r) {
		return reportDao.selectReportCount(sqlSession, r);
	}
	@Override
	public int sanctionsCollection() {
		return reportDao.sanctionsCollection(sqlSession);
	}
	@Override
	public int sanctionsMeeting() {
		return reportDao.sanctionsMeeting(sqlSession);
	}
	@Override
	public int sanctionsComments() {
		return reportDao.sanctionsComments(sqlSession);
	}
	@Override
	public int sanctionsBoReply() {
		return reportDao.sanctionsBoReply(sqlSession);
	}
	@Override
	public int sanctionsCollectionReply() {
		return reportDao.sanctionsCollectionReply(sqlSession);
	}
	@Override
	public int selectReportBoardReplyCount(Report r) {
		return reportDao.selectReportBoardReplyCount(sqlSession,r);
	}
	@Override
	public int insertReportBoardReply(Report r) {
		return reportDao.insertReportBoardReply(sqlSession, r);
	}
	@Override
	public int insertMeetingReport(Report r) {
		return reportDao.insertMeetingReport(sqlSession, r);
	}
	@Override
	public int reportMeetingCount(Report r) {
		return reportDao.reportMeetingCount(sqlSession,r);
	}
	@Override
	public int insertCollectionReport(Report r) {
		return reportDao.insertCollectionReport(sqlSession, r);
	}
	@Override
	public int reportCollectionCount(Report r) {
		return reportDao.reportCollectionCount(sqlSession,r);
	}
	@Override
	public int insertReportCollectionReply(Report r) {
		return reportDao.insertReportCollectionReply(sqlSession, r);
	}
	@Override
	public int reportCollectionReplyCount(Report r) {
		return reportDao.reportCollectionReplyCount(sqlSession,r);
	}
	



	
	
	

}
