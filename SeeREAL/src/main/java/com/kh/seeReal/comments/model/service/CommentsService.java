package com.kh.seeReal.comments.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.CommentsLike;
import com.kh.seeReal.comments.model.vo.MovieRating;
import com.kh.seeReal.common.model.vo.PageInfo;

public interface CommentsService {
	
	int checkMyCommentExit(Comments comments);
	
	double ratingGet(MovieRating movieRating);
	
	//int ratingCheck(String movie,int rating);
	int ratingCheck(MovieRating movieRating);
	
	int ratingUpdate(MovieRating movieRating);
	
	List<Map<String, Object>> commentsList(Comments comments);
	
	int commentsWrite(Comments comments);
	
	int thumbsUp(CommentsLike commentsLike);
	int thumbsDown(CommentsLike commentsLike);
	int thumbsUpCreate(CommentsLike commentsLike);
	int thumbsDownCreate(CommentsLike commentsLike);
	
	ArrayList showCommentsLike(Comments comments);
	
	ArrayList commentsLikeSum(Comments comments);
	
	Comments getMyComments(Comments comments);
	
	int reviseMyComments(Comments comments);
	
	int deleteMyComments(Comments comments);
	
	int selectCommentsCount(Comments comments);
	
	List<Map<String, Object>> selectCommentsListAll(Comments comments,PageInfo pi);
	
	Map<String, Object> getMyComment(Comments comment);
}
