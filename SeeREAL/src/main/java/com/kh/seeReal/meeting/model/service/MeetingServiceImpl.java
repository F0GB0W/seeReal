package com.kh.seeReal.meeting.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.seeReal.meeting.model.dao.MeetingDao;
import com.kh.seeReal.meeting.model.vo.Meeting;

@Service
public class MeetingServiceImpl implements MeetingService {
	
	@Autowired
	private MeetingDao meetingDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public Meeting insertMeeting(Meeting meeting) {
		// TODO Auto-generated method stub
		return null;
	}

}