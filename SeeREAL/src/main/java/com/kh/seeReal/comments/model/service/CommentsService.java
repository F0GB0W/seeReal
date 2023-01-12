package com.kh.seeReal.comments.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.MovieRating;

public interface CommentsService {
	double ratingGet(MovieRating movieRating);
	
	//int ratingCheck(String movie,int rating);
	int ratingCheck(MovieRating movieRating);
	
	int ratingUpdate(MovieRating movieRating);
	
	List<Map<String, Object>> commentsList(Comments comments);
	
	int commentsWrite(Comments comments);
	
	int thumbsUp(Comments comments);
	int thumbsDown(Comments comments);
	
	ArrayList showCommentsLike(Comments comments);
	
	ArrayList commentsLikeSum(Comments comments);
	
}
