package com.kh.seeReal.meeting.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.dao.MeetingDao;
import com.kh.seeReal.meeting.model.vo.Meeting;
import com.kh.seeReal.meeting.model.vo.MeetingUser;

@Service
public class MeetingServiceImpl implements MeetingService {
	
	@Autowired
	private MeetingDao meetingDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertMeeting(Meeting meeting) {
		return meetingDao.insertMeeting(sqlSession, meeting);
	}

	@Override
	public int selectMeetingListCount() {
		return meetingDao.selectMeetingListCount(sqlSession);
	}

	@Override
	public ArrayList<Meeting> selectMeetingList(PageInfo pi) {
		return meetingDao.selectMeetingList(sqlSession, pi);
	}

	@Override
	public int increaseMeetingCount(int mtno) {
		return meetingDao.increaseMeetingCount(sqlSession, mtno);
	}

	@Override
	public Meeting selectMeetingDetail(int mtno) {
		return meetingDao.selectMeetingDetail(sqlSession, mtno);
	}

	@Override
	public void insertMeetingUser(MeetingUser mu) {
		meetingDao.insertMeetingUser(sqlSession, mu);
	}

}
