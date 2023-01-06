package com.kh.seeReal.comments.model.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class Comments {
	
	private int commentNo;
	private String commentContent;
	private Date commentEnrollDate;
	private String spoiler;
	private String movieTitle;
	private String movieYear;
	private String status;
	private int memberNo;
	

}
