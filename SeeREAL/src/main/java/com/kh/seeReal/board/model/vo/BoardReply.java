package com.kh.seeReal.board.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardReply {
	
	private int boReplyNo; //BO_REPLY_NO
	private String boReplyContent; //BO_REPLY_CONTENT
	private String boReplyDate; //BO_REPLY_DATE
	private int boReplyReportCount; //BO_REPLY_REPORT_COUNT
	private String boReplyStatus; //BO_REPLY_STATUS
	private int memberNo; //MEMBER_NO
	private int boardNo; //BOARD_NO
	private String replyWriter;
	private String boardType;
}
