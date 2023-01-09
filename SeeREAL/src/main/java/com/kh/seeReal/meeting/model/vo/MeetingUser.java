package com.kh.seeReal.meeting.model.vo;

import lombok.Data;

@Data
public class MeetingUser {
	private int meetingNo; // METTING_NO	NUMBER
	private int memberNo; // MEMBER_NO	NUMBER
	private String meetingAccept; // MEETING_ ACCEPT	CHAR(1 BYTE)
	private String meetingContent; //MEETING_CONETNT	VARCHAR2(300 BYTE)
	
	private String nickName;
	private String memberPhoto;
}
