package com.kh.seeReal.meeting.model.service;

import java.util.ArrayList;

import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.vo.Meeting;

public interface MeetingService {

	int insertMeeting(Meeting meeting);

	int selectMeetingListCount();

	ArrayList<Meeting> selectMeetingList(PageInfo pi);

	int increaseMeetingCount(int mtno);
}
