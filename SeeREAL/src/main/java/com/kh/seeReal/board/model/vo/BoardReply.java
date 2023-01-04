package com.kh.seeReal.board.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardReply {
	
	private int boReplyNo; //BO_REPLY_NO
	private String boReplyContent; //BO_REPLY_CONTENT
	private Date boReplyDate; //BO_REPLY_DATE
	private int boReplyREportCount; //BO_REPLY_REPORT_COUNT
	private String boReplyStatus; //BO_REPLY_STATUS
	private int memberNo; //MEMBER_NO
	private int boardNo; //BOARD_NO

}
