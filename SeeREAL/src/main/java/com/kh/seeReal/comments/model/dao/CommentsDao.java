package com.kh.seeReal.comments.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.MovieRating;

@Repository
public class CommentsDao {
	
	public int ratingGet(String movie,SqlSessionTemplate sqlSession) {
		return 3;
		//return sqlSession.selectOne("CommentsMapper.ratingGet",movie);
	}
	public int ratingCheck(MovieRating movieRating,SqlSessionTemplate sqlSession) {
		return sqlSession.insert("CommentsMapper.ratingCheck", movieRating);
	}
	public int ratingUpdate(MovieRating movieRating,SqlSessionTemplate sqlSession) {
		return sqlSession.update("CommentsMapper.ratingUpdate",movieRating);
	}
	
	public ArrayList<Comments> commentsList(Comments comments,SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("CommentsMapper.commentsList", comments);
	}
	public int commentsWrite(Comments comments,SqlSessionTemplate sqlSession) {
		return sqlSession.insert("CommnetsMapper.commentsWrite", comments);
	}
}
