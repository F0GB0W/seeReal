package com.kh.seeReal.comments.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.CommentsLike;
import com.kh.seeReal.comments.model.vo.MovieRating;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.report.model.vo.Report;

public interface CommentsService {
	
	int checkMyCommentExit(Comments comments);
	
	double ratingGet(MovieRating movieRating);
	
	//int ratingCheck(String movie,int rating);
	int checkRatingExit(MovieRating movieRating);
	
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
	
	List<Map<String,Object>> getMyComments(Comments comments);
	
	int reviseMyComments(Comments comments);
	
	int deleteMyComments(Comments comments);
	
	int selectCommentsCount(Comments comments);
	
	//List<Map<String, Object>> selectCommentsListAll(Comments comments,PageInfo pi);
	
	List<HashMap<String, Object>> selectCommentsListAll(HashMap<String,Object> commentsSortInfo);
	
	//List<Map<String,Object>> myComment(Comments comment);
	
	int commentsLikeExit(CommentsLike commentsLike);
	
	//double ratingShow(Comments comments);
	
	List<HashMap<String,Object>> commentsListSort(HashMap<String,Object> commentsSortInfo);
	
	int commentsReport(Report report);
	
	int isCommentsReport(Report report);
}
