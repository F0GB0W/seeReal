package com.kh.seeReal.comments.model.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class MovieRating {
	
	private int memberNo;
	private double rating;
	private String movieTitle;
	private String movieYear;

}
