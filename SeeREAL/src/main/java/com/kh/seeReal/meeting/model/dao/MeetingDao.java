package com.kh.seeReal.meeting.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.vo.Meeting;
import com.kh.seeReal.meeting.model.vo.MeetingUser;

@Repository
public class MeetingDao {

	public int insertMeeting(SqlSessionTemplate sqlSession, Meeting meeting) {
		return sqlSession.insert("meetingMapper.insertMeeting", meeting);
	}

	public int selectMeetingListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("meetingMapper.selectMeetingListCount");
	}

	public ArrayList<Meeting> selectMeetingList(SqlSessionTemplate sqlSession, PageInfo pi) {

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("meetingMapper.selectMeetingList", pi, rowBounds);
	}

	public int increaseMeetingCount(SqlSessionTemplate sqlSession, int mtno) {
		return sqlSession.update("meetingMapper.increaseMeetingCount", mtno);
	}

	public Meeting selectMeetingDetail(SqlSessionTemplate sqlSession, int mtno) {
		return sqlSession.selectOne("meetingMapper.selectMeetingDetail", mtno);
	}

	public int meetingMaker(SqlSessionTemplate sqlSession, MeetingUser mu) {
		return sqlSession.insert("meetingMapper.meetingMaker", mu);
		
	}

	public ArrayList<MeetingUser> selectMeetingMember(SqlSessionTemplate sqlSession, int meetingNo) {
		return (ArrayList)sqlSession.selectList("meetingMapper.selectMeetingMember", meetingNo);
	}

	public int insertMeetingUser(SqlSessionTemplate sqlSession, MeetingUser mu) {
		return sqlSession.insert("meetingMapper.insertMeetingUser", mu);
	}

	public int checkJoinMeeting(SqlSessionTemplate sqlSession, MeetingUser mu) {
		return sqlSession.selectOne("meetingMapper.checkJoinMeeting", mu);
	}

	public int updateMeetingUser(SqlSessionTemplate sqlSession, MeetingUser mu) {
		return sqlSession.update("meetingMapper.updateMeetingUser", mu);
	}

	public int updateMeeting(SqlSessionTemplate sqlSession, Meeting meet) {
		return sqlSession.update("meetingMapper.updateMeeting", meet);
	}

	public int deleteMeeting(SqlSessionTemplate sqlSession, Meeting meet) {
		return sqlSession.update("meetingMapper.deleteMeeting", meet);
	}

	public ArrayList<Meeting> selectMeetingMain(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("meetingMapper.selectMeetingMain");
	}

}
