package com.kh.seeReal.comments.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.MovieRating;
import com.kh.seeReal.member.model.vo.Member;

@Repository
public class CommentsDao {
	
	public int ratingGet(String movie,SqlSessionTemplate sqlSession) {
		return 3;
		//return sqlSession.selectOne("CommentsMapper.ratingGet",movie);
	}
	public int ratingCheck(MovieRating movieRating,SqlSessionTemplate sqlSession) {
		return sqlSession.insert("comments-mapper.ratingCheck", movieRating);
	}
	public int ratingUpdate(MovieRating movieRating,SqlSessionTemplate sqlSession) {
		return sqlSession.update("comments-mapper.ratingUpdate",movieRating);
	}
	/*
	public ArrayList<Comments> commentsList(Comments comments,SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("CommentsMapper.commentsList", comments);
	}
	*/
	public int commentsWrite(Comments comments,SqlSessionTemplate sqlSession) {	
		return sqlSession.insert("comments-mapper.commentsWrite", comments);
	}
	public ArrayList<Comments> commentsList(Comments comments,SqlSessionTemplate sqlSession) {
		Member m=sqlSession.selectOne("comments-mapper.selectMemberIdTest");
		System.out.println(m);
		System.out.println("--");
		
		Map<String, Object> params = new HashMap<>();
		  params.put("comments", comments);
		  params.put("memberId", m.getMemberNickname());
		  
		  return (ArrayList)sqlSession.selectList("comments-mapper.commentsList", params);  
	}
}
