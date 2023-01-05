package com.kh.seeReal.meeting.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.meeting.model.vo.Meeting;

@Repository
public class MeetingDao {

	public int insertMeeting(SqlSessionTemplate sqlSession, Meeting meeting) {
		return sqlSession.insert("meetingMapper.insertMeeting", meeting);
	}

}
