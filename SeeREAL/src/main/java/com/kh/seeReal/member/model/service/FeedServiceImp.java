package com.kh.seeReal.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.MovieRating;
import com.kh.seeReal.member.model.dao.FeedDao;
import com.kh.seeReal.member.model.vo.Member;

@Service
public class FeedServiceImp implements FeedService{

	@Autowired
	private FeedDao feedDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectCommentsCount(int memberNo) {
		return feedDao.selectCommentsCount(sqlSession,memberNo);
	}

	@Override
	public ArrayList<Comments> commentsCount(int memberNo) {
		return feedDao.commentsCount(sqlSession, memberNo);
	}

	@Override
	public ArrayList<Comments> reviewList(int memberNo) {
		return feedDao.reviewList(sqlSession, memberNo);
	}

	@Override
	public ArrayList<MovieRating> ratingList(int memberNo) {
		return feedDao.ratingList(sqlSession, memberNo);
	}

	@Override
	public Member selectMember(int memberNo) {
		return feedDao.selectMember(sqlSession, memberNo);
	}

	@Override
	public int ratingYj(int memberNo) {
		return feedDao.ratingYj(sqlSession, memberNo);
	}
	

}
