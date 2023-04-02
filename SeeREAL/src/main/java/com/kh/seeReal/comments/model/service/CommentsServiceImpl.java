package com.kh.seeReal.comments.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.seeReal.comments.model.dao.CommentsDao;
import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.CommentsLike;
import com.kh.seeReal.comments.model.vo.MovieRating;
import com.kh.seeReal.common.model.vo.PageInfo;

@Service
public class CommentsServiceImpl implements CommentsService{

	
	@Autowired
	private CommentsDao CommentsDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;//기존의 mybatis의 sqlSession 대체

	@Override
	public int checkMyCommentExit(Comments comments) {
		
		return CommentsDao.checkMyCommentExit(comments,sqlSession);
	}
	
	@Override
	public double ratingGet(MovieRating movieRating) {
		
		return CommentsDao.ratingGet(movieRating,sqlSession);
	}

	@Override
	public int ratingCheck(MovieRating movieRating) {
		return CommentsDao.ratingCheck(movieRating,sqlSession);
		
	}

	@Override
	public int ratingUpdate(MovieRating movieRating) {
		
		return CommentsDao.ratingUpdate(movieRating,sqlSession);
	}

	@Override
	public List<Map<String, Object>> commentsList(Comments comments) {
		
		return CommentsDao.commentsList(comments,sqlSession);
	}

	@Override
	public int commentsWrite(Comments comments) {
		
		return CommentsDao.commentsWrite(comments,sqlSession);
	}

	@Override
	public int thumbsUp(CommentsLike commentsLike) {
		
		return CommentsDao.thumbsUp(commentsLike,sqlSession);
	}

	@Override
	public int thumbsDown(CommentsLike commentsLike) {
		
		return CommentsDao.thumbsDown(commentsLike,sqlSession);
	}

	@Override
	public ArrayList showCommentsLike(Comments comments) {
		
		return CommentsDao.showCommentsLike(comments,sqlSession);
	}

	@Override
	public ArrayList commentsLikeSum(Comments comments) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int thumbsUpCreate(CommentsLike commentsLike) {
		System.out.println("@@@@@thumbup create 왔다@@@@@@@@@@@@@");
		return CommentsDao.thumbsUpCreate(commentsLike, sqlSession);
	}

	@Override
	public int thumbsDownCreate(CommentsLike commentsLike) {
		System.out.println("@@@@@thumbdown create 왔다@@@@@@@@@@@@@");
		return CommentsDao.thumbsDownCreate(commentsLike, sqlSession);
	}

	@Override
	public List<Map<String,Object>> getMyComments(Comments comments) {
		
		return CommentsDao.getMyComments(comments,sqlSession);
	}

	@Override
	public int reviseMyComments(Comments comments) {
		
		return CommentsDao.reviseMyComments(comments,sqlSession);
	}

	@Override
	public int deleteMyComments(Comments comments) {
		
		return CommentsDao.deleteMyComments(comments,sqlSession);
	}

	@Override
	public int selectCommentsCount(Comments comments) {
		
		return CommentsDao.selectCommentsCount(comments,sqlSession);
	}

	@Override
	public List<Map<String, Object>> selectCommentsListAll(Comments comments,PageInfo pi) {
		// TODO Auto-generated method stub
		return CommentsDao.selectCommentsListAll(comments,pi,sqlSession);
	}
	/*
	@Override
	public List<Map<String,Object>> myComment(Comments comments) {
		return CommentsDao.myComment(comments,sqlSession);
	}
	*/
	@Override
	public int checkRatingExit(MovieRating movieRating) {
		// TODO Auto-generated method stub
		return CommentsDao.checkRatingExit(movieRating,sqlSession);
	}

	@Override
	public int commentsLikeExit(CommentsLike commentsLike) {
		
		return CommentsDao.commentsLikeExit(commentsLike,sqlSession);
	}
	/*
	@Override
	public double ratingShow(Comments comments) {
		
		return CommentsDao.ratingShow(comments,sqlSession);
	}
	*/

	@Override
	public List<HashMap<String,Object>> commentsListSort(HashMap<String, Object> commentsSortInfo) {
		
		return CommentsDao.commentsListSort(commentsSortInfo,sqlSession);
	}

	
	

	
	
}
