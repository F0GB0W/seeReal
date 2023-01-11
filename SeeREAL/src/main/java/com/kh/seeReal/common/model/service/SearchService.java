package com.kh.seeReal.common.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.vo.Meeting;

public interface SearchService {
	
	int searchCountList(HashMap<String,String> map);
	ArrayList<Meeting> searchMeetingList(HashMap<String,String> map);
	
	
}
