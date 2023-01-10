package com.kh.seeReal.comments.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.seeReal.comments.model.dao.CommentsDao;
import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.MovieRating;

@Service
public class CommentsServiceImpl implements CommentsService{

	
	@Autowired
	private CommentsDao CommentsDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;//기존의 mybatis의 sqlSession 대체

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
	public HashMap commentsList(Comments comments) {
		
		return CommentsDao.commentsList(comments,sqlSession);
	}

	@Override
	public int commentsWrite(Comments comments) {
		
		return CommentsDao.commentsWrite(comments,sqlSession);
	}
	
}
