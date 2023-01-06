package com.kh.seeReal.meeting.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.vo.Meeting;

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

}
