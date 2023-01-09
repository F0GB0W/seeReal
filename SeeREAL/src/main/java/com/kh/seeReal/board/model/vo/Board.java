package com.kh.seeReal.board.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Board {
	private int boardNo; //BOARD_NO
	private String boardTitle; //BOARD_TITLE
	private String boardContent; //BOARD_CONTENT
	private Date enrollDate; //ENROLL_DATE
	private int count; //COUNT
	private String originName; //ORIGIN_NAME
	private String changeName; //CHANGE_NAME
	private int reportCount; //REPORT_COUNT
	private String status; //STATUS
	private String boardType; //BOARD_TYPE
	private int boardWriter;
	private String nickName;
	
	
}
