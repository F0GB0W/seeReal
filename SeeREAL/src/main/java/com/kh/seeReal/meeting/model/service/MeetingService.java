package com.kh.seeReal.meeting.model.service;

import java.util.ArrayList;

import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.vo.Meeting;
import com.kh.seeReal.meeting.model.vo.MeetingUser;

public interface MeetingService {

	int insertMeeting(Meeting meeting);

	int selectMeetingListCount();

	ArrayList<Meeting> selectMeetingList(PageInfo pi);

	int increaseMeetingCount(int mtno);

	Meeting selectMeetingDetail(int mtno);

	int meetingMaker(MeetingUser mu);

	ArrayList<MeetingUser> selectMeetingMember(int meetingNo);

	int insertMeetingUser(MeetingUser mu);

	int checkJoinMeeting(MeetingUser mu);
}
