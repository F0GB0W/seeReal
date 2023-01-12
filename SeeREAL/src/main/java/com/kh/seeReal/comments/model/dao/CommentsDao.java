package com.kh.seeReal.comments.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.MovieRating;
import com.kh.seeReal.member.model.vo.Member;

@Repository
public class CommentsDao {
	
	public double ratingGet(MovieRating movieRating,SqlSessionTemplate sqlSession) {
		
				System.out.println("movie rating dldi");
				System.out.println(movieRating);
				System.out.println("movie rating dldi");
				double tt=sqlSession.selectOne("comments-mapper.ratingGet",movieRating);
				System.out.println("tt값은:  "+tt);
				return tt;
	}
	public int ratingCheck(MovieRating movieRating,SqlSessionTemplate sqlSession) {
		System.out.println("dao"+movieRating);
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
	public List<Map<String, Object>> commentsList(Comments comments,SqlSessionTemplate sqlSession) {
		
		List<Map<String, Object>> list = (ArrayList)sqlSession.selectList("comments-mapper.commentsList", comments);
		//Map<String,Object> list = sqlSession.selectMap("comments-mapper.commentsList", comments);
		//Map list=  sqlSession.selectMap("comments-mapper.commentsList", comments);
		//HashMap<String,Object> list=(HashMap)sqlSession.selectList("comments-mapper.commentsList", comments);		
		  return list;	  
	}
	public int thumbsUp(Comments comments,SqlSessionTemplate sqlSession) {
		return sqlSession.update("comments-mapper.thumbsUp",comments);
	}
	public int thumbsDown(Comments comments,SqlSessionTemplate sqlSession) {
		return sqlSession.update("comments-mapper.thumbsDown",comments);
	}
	public ArrayList showCommentsLike(Comments comments,SqlSessionTemplate sqlSession) {
		System.out.println("---showCommentsLike 가기전 ----"+comments);
		
		ArrayList list=(ArrayList)sqlSession.selectList("comments-mapper.showCommentsLike", comments);
		System.out.println("---showCommentsLike 가기후 ----"+list);
		return list;
	}
}
