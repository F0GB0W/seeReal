package com.kh.seeReal.meeting.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Meeting {

	private int meetingNo; // METTING_NO
	private String meetingTitle; // MEETING_TITLE	VARCHAR2(30 BYTE)
	private String meetingExp; // MEETING_EXP	VARCHAR2(2000 BYTE)
	private String meetingPlace; // MEETING_PLACE	VARCHAR2(300 BYTE)
	private String meetingPlaceDetail; // MEETING_PLACE_DETAIL	VARCHAR2(300 BYTE)
	private String movieTitle; // MOVIE_TITLE	VARCHAR2(300 BYTE)
	private	String movieYear; // MOVIE_YEAR	NUMBER
	private String status; // STATUS	CHAR(1 BYTE)
	private Date meetingEnrollDate; // MEETING_ENROLL	DATE
	private int memberNo; // MEMBER_NO	NUMBER
	private int meetingReport; // MEETING_REPORT	NUMBER

	// 작성자 아이디가 필요
	private String meetingWriter;
}
