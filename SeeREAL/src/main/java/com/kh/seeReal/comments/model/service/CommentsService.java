package com.kh.seeReal.comments.model.service;

import java.util.ArrayList;

import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.MovieRating;

public interface CommentsService {
	int ratingGet(String movie);
	
	//int ratingCheck(String movie,int rating);
	int ratingCheck(MovieRating movieRating);
	
	int ratingUpdate(MovieRating movieRating);
	
	ArrayList<Comments> commentsList(Comments comments);
	
	int commentsWrite(Comments comments);
	
}
